import socket
import time
import struct
import asyncio
from app.errors import PaymentError
from kiosk_app.config import Config
from services.logging_service import logging_service

class PaymentService:
    def __init__(self):
        self.ped_state = 0
        self.terminal_ip = Config.TERMINAL_ELAVON_IP
        self.terminal_port_state = Config.TERMINAL_ELAVON_PORT_STATE
        self.terminal_port_payment = Config.TERMINAL_ELAVON_PORT_PAYMENT
        logging_service.info(f"Payment service initialized with IP: {self.terminal_ip}, "
                           f"State port: {self.terminal_port_state}, "
                           f"Payment port: {self.terminal_port_payment}")

    async def check_state(self):
        """Asynchroniczna implementacja sprawdzania stanu terminala"""
        logging_service.info("Checking terminal state")
        try:
            reader, writer = await asyncio.open_connection(self.terminal_ip, self.terminal_port_state)
            
            # Przygotuj wiadomość dokładnie jak w Dart
            message = bytearray()
            message.extend([0x00, 0x00, 0x00, 0x00])
            message.extend([0x00, 0x02])
            message.extend([0x00, 0x1C])
            
            writer.write(message)
            await writer.drain()
            
            # Odbierz odpowiedź
            data = await reader.read(1024)
            
            if len(data) >= 17:
                self.ped_state = data[16]
                logging_service.info(f"Terminal state: {self.ped_state}")
            
            writer.close()
            await writer.wait_closed()
            
        except Exception as e:
            logging_service.error(f"Error in check_state: {str(e)}")
            raise PaymentError(str(e))

    async def init_transaction(self, price):
        """Asynchroniczna implementacja inicjalizacji transakcji"""
        logging_service.info(f"Initializing transaction with price: {price}")
        self.ped_state = 0
        
        while True:  # Dokładnie jak w Dart - nieskończona pętla
            try:
                await self.check_state()
                if self.ped_state == 1:
                    return await self.start_payment(price)  

                await asyncio.sleep(0.1)  # 100ms delay jak w Dart
            except PaymentError as e:
                logging_service.error(f"Error in init_transaction: {str(e)}")
                raise

    async def start_payment(self, price):
        """Asynchroniczna implementacja rozpoczęcia płatności"""
        logging_service.info(f"Starting payment with amount: {price}")
        try:
            reader, writer = await asyncio.open_connection(self.terminal_ip, self.terminal_port_payment)
            
            message = self.construct_payment_message(price)
            writer.write(message)
            await writer.drain()
            
            # Czekamy na odpowiedź z terminala
            endstring = "Unknown"
            while True:
                try:
                    data = await asyncio.wait_for(reader.read(1024), timeout=60.0)  # 60 sekund timeout
                    if not data:  # Połączenie zostało zamknięte
                        logging_service.error("Connection closed by terminal")
                        break
                    
                    logging_service.info(f"Received data from terminal: {data.hex()}")
                    parsed_response = self.parse_response(data)
                    if parsed_response != "Unknown":  # Otrzymaliśmy prawidłową odpowiedź
                        logging_service.info(f"Payment completed with response: {parsed_response}")
                        endstring = parsed_response
                        break
                    
                    await asyncio.sleep(0.1)  # Krótka przerwa między próbami
                    
                except asyncio.TimeoutError:
                    logging_service.error("Timeout waiting for terminal response")
                    break
                
            writer.close()
            await writer.wait_closed()
            
            logging_service.info(f"Payment completed with response: {endstring}")
            return endstring
            
        except Exception as e:
            logging_service.error(f"Error in start_payment: {str(e)}")
            raise PaymentError(str(e))

    def create_socket_connection(self, port, timeout=5):
        """Helper method to create socket connection with proper error handling"""
        try:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.settimeout(timeout)
            sock.connect((self.terminal_ip, port))
            logging_service.info(f"Successfully connected to {self.terminal_ip}:{port}")
            return sock
        except socket.timeout:
            logging_service.error(f"Connection timeout to {self.terminal_ip}:{port}")
            raise PaymentError("Terminal connection timeout")
        except socket.error as e:
            error_msg = str(e)
            if "No route to host" in error_msg:
                logging_service.error(f"Terminal not accessible at {self.terminal_ip}:{port}")
                raise PaymentError("Terminal is not accessible")
            elif "Connection refused" in error_msg:
                logging_service.error(f"Terminal refused connection at {self.terminal_ip}:{port}")
                raise PaymentError("Terminal refused connection")
            else:
                logging_service.error(f"Socket error connecting to {self.terminal_ip}:{port}: {error_msg}")
                raise PaymentError(f"Connection error: {error_msg}")

    def send_and_receive(self, sock, message, expected_response_size=17):
        """Helper method to send data and receive response with proper error handling"""
        try:
            # Send data
            total_sent = 0
            while total_sent < len(message):
                sent = sock.send(message[total_sent:])
                if sent == 0:
                    raise PaymentError("Socket connection broken during send")
                total_sent += sent
            logging_service.info(f"Successfully sent {total_sent} bytes")

            # Receive response
            chunks = []
            bytes_received = 0
            while bytes_received < expected_response_size:
                chunk = sock.recv(min(expected_response_size - bytes_received, 1024))
                if not chunk:
                    raise PaymentError("Connection closed by terminal")
                chunks.append(chunk)
                bytes_received += len(chunk)
                if bytes_received >= expected_response_size:
                    break

            data = b''.join(chunks)
            logging_service.info(f"Received {len(data)} bytes")
            return data

        except socket.timeout:
            logging_service.error("Timeout during data transfer")
            raise PaymentError("Terminal communication timeout")
        except socket.error as e:
            logging_service.error(f"Socket error during data transfer: {e}")
            raise PaymentError(f"Communication error: {str(e)}")

    def construct_payment_message(self, price):
        logging_service.info("Constructing payment message")
        try:
            # Definicje tagów dokładnie jak w Dart
            tagEftMessageNumber = [0x00, 0x00, 0x02, 0x00]
            tagEftMessageNumberLength = [0x02, 0x00, 0x00, 0x00]  # 2
            tagEftMessageNumberValue = [0x30, 0x31]  # 0 1
            tagEftMessageNumberFull = tagEftMessageNumber + tagEftMessageNumberLength + tagEftMessageNumberValue

            tagEftAmount1 = [0x01, 0x00, 0x02, 0x00]
            tagEftAmount1Length = [0x0C, 0x00, 0x00, 0x00]  # 12
            tagEftAmount1Value = list(self.price_to_ascii(price))
            tagEftAmount1Full = tagEftAmount1 + tagEftAmount1Length + tagEftAmount1Value

            tagEftAmount1Label = [0x05, 0x00, 0x02, 0x00]
            tagEftAmount1LabelLength = [0x07, 0x00, 0x00, 0x00]  # 7
            tagEftAmount1LabelValue = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x31]  # A m o u n t 1
            tagEftAmount1LabelFull = tagEftAmount1Label + tagEftAmount1LabelLength + tagEftAmount1LabelValue

            tagEftTransactionType = [0x09, 0x00, 0x02, 0x00]
            tagEftTransactionTypeLength = [0x02, 0x00, 0x00, 0x00]  # 2
            tagEftTransactionTypeValue = [0x30, 0x30]  # 0 0
            tagEftTransactionTypeFull = tagEftTransactionType + tagEftTransactionTypeLength + tagEftTransactionTypeValue

            tagEftAmount2 = [0x02, 0x00, 0x02, 0x00]
            tagEftAmount2Length = [0x0C, 0x00, 0x00, 0x00]  # 12
            tagEftAmount2Value = [0x30] * 12  # 0 0 0 0 0 0 0 0 0 0 0 0
            tagEftAmount2Full = tagEftAmount2 + tagEftAmount2Length + tagEftAmount2Value

            tagEftAmount3 = [0x03, 0x00, 0x02, 0x00]
            tagEftAmount3Length = [0x0C, 0x00, 0x00, 0x00]  # 12
            tagEftAmount3Value = [0x30] * 12  # 0 0 0 0 0 0 0 0 0 0 0 0
            tagEftAmount3Full = tagEftAmount3 + tagEftAmount3Length + tagEftAmount3Value

            tagEftAmount4 = [0x04, 0x00, 0x02, 0x00]
            tagEftAmount4Length = [0x0C, 0x00, 0x00, 0x00]  # 12
            tagEftAmount4Value = [0x30] * 12  # 0 0 0 0 0 0 0 0 0 0 0 0
            tagEftAmount4Full = tagEftAmount4 + tagEftAmount4Length + tagEftAmount4Value

            tagEftAmount2Label = [0x06, 0x00, 0x02, 0x00]
            tagEftAmount2LabelLength = [0x07, 0x00, 0x00, 0x00]  # 7
            tagEftAmount2LabelValue = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x32]  # A m o u n t 2
            tagEftAmount2LabelFull = tagEftAmount2Label + tagEftAmount2LabelLength + tagEftAmount2LabelValue

            tagEftAmount3Label = [0x07, 0x00, 0x02, 0x00]
            tagEftAmount3LabelLength = [0x07, 0x00, 0x00, 0x00]  # 7
            tagEftAmount3LabelValue = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x33]  # A m o u n t 3
            tagEftAmount3LabelFull = tagEftAmount3Label + tagEftAmount3LabelLength + tagEftAmount3LabelValue

            tagEftAmount4Label = [0x08, 0x00, 0x02, 0x00]
            tagEftAmount4LabelLength = [0x07, 0x00, 0x00, 0x00]  # 7
            tagEftAmount4LabelValue = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x34]  # A m o u n t 4
            tagEftAmount4LabelFull = tagEftAmount4Label + tagEftAmount4LabelLength + tagEftAmount4LabelValue

            tagEftCommercialCode = [0x0C, 0x00, 0x02, 0x00]
            tagEftCommercialCodeLength = [0x02, 0x00, 0x00, 0x00]  # 2
            tagEftCommercialCodeValue = [0x20, 0x20]  # SPACE SPACE
            tagEftCommercialCodeFull = tagEftCommercialCode + tagEftCommercialCodeLength + tagEftCommercialCodeValue

            tagEftSuspectFraudIndicator = [0x5B, 0x00, 0x02, 0x00]
            tagEftSuspectFraudIndicatorLength = [0x01, 0x00, 0x00, 0x00]  # 1
            tagEftSuspectFraudIndicatorValue = [0x00]  # 0
            tagEftSuspectFraudIndicatorFull = tagEftSuspectFraudIndicator + tagEftSuspectFraudIndicatorLength + tagEftSuspectFraudIndicatorValue

            tagEftReturnCardRespValue = [0x7D, 0x00, 0x02, 0x00]
            tagEftReturnCardRespValueLength = [0x01, 0x00, 0x00, 0x00]  # 1
            tagEftReturnCardRespValueValue = [0x01]  # 1
            tagEftReturnCardRespValueFull = tagEftReturnCardRespValue + tagEftReturnCardRespValueLength + tagEftReturnCardRespValueValue

            tagEftReturnSigReqValue = [0x86, 0x00, 0x02, 0x00]
            tagEftReturnSigReqValueLength = [0x01, 0x00, 0x00, 0x00]  # 1
            tagEftReturnSigReqValueValue = [0x01]  # 1
            tagEftReturnSigReqValueFull = tagEftReturnSigReqValue + tagEftReturnSigReqValueLength + tagEftReturnSigReqValueValue

            tagEftEnableEcrBlik = [0x89, 0x00, 0x02, 0x00]
            tagEftEnableEcrBlikLength = [0x01, 0x00, 0x00, 0x00]  # 1
            tagEftEnableEcrBlikValue = [0x01]  # 1
            tagEftEnableEcrBlikFull = tagEftEnableEcrBlik + tagEftEnableEcrBlikLength + tagEftEnableEcrBlikValue

            tagEftEnableToken = [0x8D, 0x00, 0x02, 0x00]
            tagEftEnableTokenLength = [0x01, 0x00, 0x00, 0x00]  # 1
            tagEftEnableTokenValue = [0x00]  # 0
            tagEftEnableTokenFull = tagEftEnableToken + tagEftEnableTokenLength + tagEftEnableTokenValue

            tagEftEnableReturnMarkupTextIndicator = [0x9B, 0x00, 0x02, 0x00]
            tagEftEnableReturnMarkupTextIndicatorLength = [0x01, 0x00, 0x00, 0x00]  # 1
            tagEftEnableReturnMarkupTextIndicatorValue = [0x00]  # 0
            tagEftEnableReturnMarkupTextIndicatorFull = (
                tagEftEnableReturnMarkupTextIndicator + 
                tagEftEnableReturnMarkupTextIndicatorLength + 
                tagEftEnableReturnMarkupTextIndicatorValue
            )

            tagEftReturnApmData = [0x9D, 0x00, 0x02, 0x00]
            tagEftReturnApmDataLength = [0x01, 0x00, 0x00, 0x00]  # 1
            tagEftReturnApmDataValue = [0x00]  # 0
            tagEftReturnApmDataFull = tagEftReturnApmData + tagEftReturnApmDataLength + tagEftReturnApmDataValue

            # Łączenie wszystkich tagów w payload
            payload = (tagEftMessageNumberFull +
                      tagEftAmount1Full +
                      tagEftAmount1LabelFull +
                      tagEftTransactionTypeFull +
                      tagEftAmount2Full +
                      tagEftAmount3Full +
                      tagEftAmount4Full +
                      tagEftAmount2LabelFull +
                      tagEftAmount3LabelFull +
                      tagEftAmount4LabelFull +
                      tagEftCommercialCodeFull +
                      tagEftSuspectFraudIndicatorFull +
                      tagEftReturnCardRespValueFull +
                      tagEftReturnSigReqValueFull +
                      tagEftEnableEcrBlikFull +
                      tagEftEnableTokenFull +
                      tagEftEnableReturnMarkupTextIndicatorFull +
                      tagEftReturnApmDataFull)

            # Tworzenie nagłówka i finalnej wiadomości
            header = [len(payload), 0x00, 0x00, 0x00] + [0x00, 0x02] + [0x00, 0x02]
            final_message = bytes(header + payload)

            logging_service.info(f"Payment message constructed, total length: {len(final_message)}")
            logging_service.info(f"Payment message: {final_message}")
            return final_message

        except Exception as e:
            logging_service.error(f"Error constructing payment message: {e}")
            raise PaymentError(f"Error constructing payment message: {str(e)}")

    @staticmethod
    def price_to_ascii(price):
        try:
            price_string = f"{float(price):.2f}"
            result = bytearray(b'0' * (13 - len(price_string)))
            result.extend(price_string.encode('ascii'))
            return bytes(result)
        except (ValueError, TypeError) as e:
            logging_service.error(f"Error converting price to ASCII: {e}")
            raise PaymentError(f"Invalid price format: {str(e)}")

    @staticmethod
    def ascii_to_int(data):
        if 0x30 <= data <= 0x39:
            return data - 0x30
        return 10

    def parse_response(self, data):
        """Dokładne odwzorowanie logiki z Dart"""
        logging_service.info("Parsing terminal response")
        logging_service.info(f"Raw response data: {data}")
        try:
            i = 8
            response_code = None
            endstring = "Unknown"
            
            while i < len(data):
                # Dokładnie ta sama logika co w Dart
                tag = (data[i] + 
                      data[i + 1] * 256 + 
                      data[i + 2] * 65536 + 
                      data[i + 3] * 16777216)
                
                tag_length = (data[i + 4] + 
                            data[i + 5] * 256 + 
                            data[i + 6] * 65536 + 
                            data[i + 7] * 16777216)
                
                if tag == 131086:  # 0x0002000E
                    if tag_length == 1:
                        response_code = self.ascii_to_int(data[i + 8])
                    elif tag_length == 2:
                        # W Dart jest błąd, ale zachowujemy go dla zgodności
                        response_code = self.ascii_to_int(data[i + 8] + data[i + 8])
                    
                    # Taka sama konwersja na string jak w Dart
                    if 0 <= response_code <= 15:
                        endstring = str(response_code)
                    break
                
                i += 8 + tag_length
            
            return endstring
            
        except Exception as e:
            logging_service.error(f"Error parsing terminal response: {e}")
            return "Unknown"  # Tak samo jak w Dart

    def run_sync_init_transaction(self, price):
        """Synchroniczny wrapper dla init_transaction"""
        return asyncio.run(self.init_transaction(price))

payment_service = PaymentService()
