import socket
import time 
import struct
from app.errors import PaymentError
from kiosk_app.config import Config
from services.logging_service import logging_service

class PaymentService:
    def __init__(self):
        self.ped_state = 0
        self.terminal_ip = Config.TERMINAL_ELAVON_IP
        self.terminal_port_state = Config.TERMINAL_ELAVON_PORT_STATE
        self.terminal_port_payment = Config.TERMINAL_ELAVON_PORT_PAYMENT

    def check_state(self):
        try:
            logging_service.info(f"Checking terminal state")
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.settimeout(5)
                s.connect((self.terminal_ip, self.terminal_port_state))
                message = b'\x00\x00\x00\x00\x00\x02\x00\x1C'
                s.sendall(message)
                data = s.recv(1024)
                self.ped_state = data[16]
                logging_service.info(f"Terminal state: {self.ped_state}")
        except (socket.timeout, ConnectionRefusedError) as e:
            logging_service.error(f"Failed to connect to terminal: {str(e)}")
            raise PaymentError("Unable to connect to payment terminal")

    def init_transaction(self, price):
        self.ped_state = 0
        retry_count = 0
        max_retries = 3
        logging_service.info(f"Initializing transaction with price: {price}")
        while retry_count < max_retries:
            logging_service.info(f"Attempt {retry_count + 1} of {max_retries}")
            try:
                self.check_state()
                if self.ped_state == 1:
                    return self.start_payment(price)
                time.sleep(2)
                retry_count += 1
            except PaymentError as e:
                logging_service.warning(f"Attempt {retry_count + 1} failed: {str(e)}")
                if retry_count == max_retries - 1:
                    logging_service.error(f"Unable to initialize transaction after multiple attempts")
                    raise PaymentError("Unable to initialize transaction after multiple attempts")
        logging_service.error(f"Terminal not ready after multiple attempts")
        raise PaymentError("Terminal not ready after multiple attempts")

    def start_payment(self, price):
        try:
            logging_service.info(f"Starting payment with price: {price}")
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.settimeout(30)
                s.connect((self.terminal_ip, self.terminal_port_payment))
                message = self.construct_payment_message(price)
                s.sendall(message)
                data = s.recv(1024)
                return self.parse_response(data)
        except (socket.timeout, ConnectionRefusedError) as e:
            logging_service.error(f"Payment transaction failed: {str(e)}")
            raise PaymentError("Unable to complete payment transaction")

    def construct_payment_message(self, price):
        tags = [
            (0x00000200, b'01'),
            (0x00000201, self.price_to_ascii(price)),
            (0x00000205, b'Amount1'),
            (0x00000209, b'00'),
            (0x00000202, b'000000000000'),
            (0x00000203, b'000000000000'),
            (0x00000204, b'000000000000'),
            (0x00000206, b'Amount2'),
            (0x00000207, b'Amount3'),
            (0x00000208, b'Amount4'),
            (0x0000020C, b'  '),
            (0x0000025B, b'\x00'),
            (0x0000027D, b'\x01'),
            (0x00000286, b'\x01'),
            (0x00000289, b'\x01'),
            (0x0000028D, b'\x00'),
            (0x0000029B, b'\x00'),
            (0x0000029D, b'\x00'),
        ]

        payload = b''.join(struct.pack('<I', tag) + struct.pack('<I', len(value)) + value for tag, value in tags)
        header = struct.pack('<I', len(payload)) + b'\x00\x02\x00\x02'
        return header + payload

    def parse_response(self, data):
        i = 8
        response_code = None
        while i < len(data):
            tag = struct.unpack('<I', data[i:i+4])[0]
            tag_length = struct.unpack('<I', data[i+4:i+8])[0]
            if tag == 131086:  # 0x0002000E
                if tag_length == 1:
                    response_code = self.ascii_to_int(data[i+8])
                elif tag_length == 2:
                    response_code = self.ascii_to_int(data[i+8]) * 10 + self.ascii_to_int(data[i+9])
                break
            i += 8 + tag_length

        if response_code is None:
            logging_service.warning("Unknown response from terminal")
            return "Unknown"
        return str(response_code)

    @staticmethod
    def price_to_ascii(price):
        price_string = f"{price:.2f}"
        ascii_bytes = bytearray(b'0' * (13 - len(price_string)))
        ascii_bytes.extend(price_string.encode('ascii'))
        return bytes(ascii_bytes)

    @staticmethod
    def ascii_to_int(data):
        return int(chr(data)) if 0x30 <= data <= 0x39 else 10

payment_service = PaymentService()
