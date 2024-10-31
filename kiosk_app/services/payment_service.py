import asyncio
import struct
from datetime import datetime
from typing import List, Union
from config import Config
from services.logging_service import logging_service


class PaymentService:
    def __init__(self):
        self.ped_state = 0
        self.logger = logging_service
        self.config = Config()

    async def check_state(self) -> None:
        self.logger.info("\n=== CHECK STATE START ===")
        self.logger.info(f"Timestamp: {datetime.now()}")
        self.logger.info("Attempting to connect to PED device...")

        try:
            reader, writer = await asyncio.open_connection(
                self.config.TERMINAL_ELAVON_IP, 
                self.config.TERMINAL_ELAVON_PORT_STATE
            )

            local_addr = writer.get_extra_info('socket').getsockname()
            remote_addr = writer.get_extra_info('socket').getpeername()
            
            self.logger.info("Socket details:")
            self.logger.info(f"  - Local address: {local_addr[0]}")
            self.logger.info(f"  - Local port: {local_addr[1]}")
            self.logger.info(f"  - Remote address: {remote_addr[0]}")
            self.logger.info(f"  - Remote port: {remote_addr[1]}")

            # Prepare state check message
            message = bytearray()
            message.extend([0x00, 0x00, 0x00, 0x00])  # Header
            message.extend([0x00, 0x02])  # Protocol version
            message.extend([0x00, 0x1C])  # Message type

            self.logger.info("Preparing state check message:")
            self.logger.info(f"  - Header: {' '.join([f'0x{b:02x}' for b in message[0:4]])}")
            self.logger.info(f"  - Protocol version: {' '.join([f'0x{b:02x}' for b in message[4:6]])}")
            self.logger.info(f"  - Message type: {' '.join([f'0x{b:02x}' for b in message[6:8]])}")

            self.logger.info("Sending state check request...")
            writer.write(message)
            await writer.drain()
            self.logger.info("Request sent successfully")

            data = await reader.read(1024)
            self.logger.info("\nReceived response from PED:")
            self.logger.info(f"  - Raw data (hex): {' '.join([f'0x{b:02x}' for b in data])}")
            self.logger.info(f"  - Data length: {len(data)} bytes")
            self.logger.info(f"  - PED State byte: 0x{data[16]:02x} ({data[16]})")
            
            self.ped_state = data[16]
            self.logger.info(f"  - Updated internal pedState to: {self.ped_state}")

        except Exception as e:
            self.logger.error(f"\n!!! ERROR IN CHECK STATE !!!")
            self.logger.error(f"Error details: {str(e)}")
            self.logger.exception("Stack trace:")
            raise
        
        finally:
            if 'writer' in locals():
                self.logger.info("Closing socket connection...")
                writer.close()
                await writer.wait_closed()
                self.logger.info("Check state connection closed successfully")
                self.logger.info("=== CHECK STATE END ===\n")

    async def start_transaction(self, price: float) -> str:
        self.logger.info("\n====== STARTING NEW TRANSACTION ======")
        self.logger.info(f"Timestamp: {datetime.now()}")
        self.logger.info("Transaction details:")
        self.logger.info(f"  - Amount: {price}")
        self.logger.info(f"  - Current PED state: {self.ped_state}")

        self.ped_state = 0
        self.logger.info(f"PED state reset to: {self.ped_state}")

        attempts = 0
        while True:
            attempts += 1
            self.logger.info(f"\nPED state check attempt #{attempts}")
            await self.check_state()
            
            if self.ped_state == 1:
                self.logger.info("✓ PED is ready for transaction (state=1)")
                break
                
            self.logger.info(f"⚠ PED not ready (state={self.ped_state}), waiting 100ms before next attempt...")
            await asyncio.sleep(0.1)

        self.logger.info("\nInitiating payment process...")
        result = await self.start_payment(price)
        self.logger.info("====== TRANSACTION COMPLETE ======\n")
        
        return result

    def _build_and_log_tag(self, tag_name: str, tag: List[int], length: List[int], value: List[int]) -> bytes:
        self.logger.info(f"  - Tag: {tag_name}")
        self.logger.info(f"    - ID: {' '.join([f'0x{b:02x}' for b in tag])}")
        self.logger.info(f"    - Length: {' '.join([f'0x{b:02x}' for b in length])}")
        self.logger.info(f"    - Value: {' '.join([f'0x{b:02x}' for b in value])}")
        return bytes(tag + length + value)

    def _price_to_ascii(self, price: float) -> bytes:
        self.logger.info("\n=== PRICE CONVERSION START ===")
        self.logger.info(f"Input price: {price}")
        
        price_string = f"{price:.2f}"
        self.logger.info(f"Formatted price string: {price_string}")
        self.logger.info(f"Padding needed: {13 - len(price_string)} zeros")

        result = bytearray()
        self.logger.info("\nBuilding ASCII representation:")

        # Add padding zeros
        for _ in range(13 - len(price_string)):
            result.append(0x30)
            self.logger.info("  - Added padding zero: 0x30")

        # Convert price digits
        for char in price_string:
            if char != '.':
                ascii_value = 0x30 + int(char)
                result.append(ascii_value)
                self.logger.info(f"  - Converted \"{char}\" to: 0x{ascii_value:02x}")

        self.logger.info("\nFinal ASCII representation:")
        self.logger.info(f"  - Hex: {' '.join([f'0x{b:02x}' for b in result])}")
        self.logger.info(f"  - Length: {len(result)} bytes")
        self.logger.info("=== PRICE CONVERSION END ===\n")
        
        return bytes(result)

    def _ascii_to_int(self, data: int) -> int:
        self.logger.info("\n=== ASCII TO INT CONVERSION ===")
        self.logger.info(f"Input ASCII byte: 0x{data:02x}")
        
        ascii_map = {
            0x30: 0, 0x31: 1, 0x32: 2, 0x33: 3, 0x34: 4,
            0x35: 5, 0x36: 6, 0x37: 7, 0x38: 8, 0x39: 9
        }
        
        result = ascii_map.get(data, 10)
        self.logger.info(f"Conversion result: {result}")
        self.logger.info("=== CONVERSION END ===\n")
        return result

    async def start_payment(self, price: float) -> str:
        self.logger.info("\n=== PAYMENT PROCESS START ===")
        self.logger.info(f"Timestamp: {datetime.now()}")
        self.logger.info("Connecting to payment terminal...")

        try:
            reader, writer = await asyncio.open_connection(
                self.config.TERMINAL_ELAVON_IP,
                self.config.TERMINAL_ELAVON_PORT_PAYMENT
            )

            local_addr = writer.get_extra_info('socket').getsockname()
            remote_addr = writer.get_extra_info('socket').getpeername()
            
            self.logger.info("\nPayment socket connection established:")
            self.logger.info(f"  - Local endpoint: {local_addr[0]}:{local_addr[1]}")
            self.logger.info(f"  - Remote endpoint: {remote_addr[0]}:{remote_addr[1]}")

            self.logger.info("\nConstructing payment message tags...")
            tags = []

            # EFT Message Number
            tags.append(self._build_and_log_tag("EFT Message Number",
                [0x00, 0x00, 0x02, 0x00], [0x02, 0x00, 0x00, 0x00], [0x30, 0x31]))

            # Amount 1
            price_ascii = self._price_to_ascii(price)
            tags.append(self._build_and_log_tag("Amount 1",
                [0x01, 0x00, 0x02, 0x00], [0x0C, 0x00, 0x00, 0x00], list(price_ascii)))

            # Amount 1 Label
            tags.append(self._build_and_log_tag("Amount 1 Label",
                [0x05, 0x00, 0x02, 0x00], [0x07, 0x00, 0x00, 0x00],
                [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x31]))  # "Amount1" in ASCII

            # Transaction Type
            tags.append(self._build_and_log_tag("Transaction Type",
                [0x09, 0x00, 0x02, 0x00], [0x02, 0x00, 0x00, 0x00], [0x30, 0x30]))

            # Amount 2
            tags.append(self._build_and_log_tag("Amount 2",
                [0x02, 0x00, 0x02, 0x00], [0x0C, 0x00, 0x00, 0x00],
                [0x30] * 12))  # 12 zeros

            # Amount 3
            tags.append(self._build_and_log_tag("Amount 3",
                [0x03, 0x00, 0x02, 0x00], [0x0C, 0x00, 0x00, 0x00],
                [0x30] * 12))

            # Amount 4
            tags.append(self._build_and_log_tag("Amount 4",
                [0x04, 0x00, 0x02, 0x00], [0x0C, 0x00, 0x00, 0x00],
                [0x30] * 12))

            # Amount 2 Label
            tags.append(self._build_and_log_tag("Amount 2 Label",
                [0x06, 0x00, 0x02, 0x00], [0x07, 0x00, 0x00, 0x00],
                [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x32]))

            # Amount 3 Label
            tags.append(self._build_and_log_tag("Amount 3 Label",
                [0x07, 0x00, 0x02, 0x00], [0x07, 0x00, 0x00, 0x00],
                [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x33]))

            # Amount 4 Label
            tags.append(self._build_and_log_tag("Amount 4 Label",
                [0x08, 0x00, 0x02, 0x00], [0x07, 0x00, 0x00, 0x00],
                [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x34]))

            # Commercial Code
            tags.append(self._build_and_log_tag("Commercial Code",
                [0x0C, 0x00, 0x02, 0x00], [0x02, 0x00, 0x00, 0x00],
                [0x20, 0x20]))

            # Suspect Fraud Indicator
            tags.append(self._build_and_log_tag("Suspect Fraud Indicator",
                [0x5B, 0x00, 0x02, 0x00], [0x01, 0x00, 0x00, 0x00],
                [0x00]))

            # Return Card Response Value
            tags.append(self._build_and_log_tag("Return Card Response Value",
                [0x7D, 0x00, 0x02, 0x00], [0x01, 0x00, 0x00, 0x00],
                [0x01]))

            # Return Signature Request Value
            tags.append(self._build_and_log_tag("Return Signature Request Value",
                [0x86, 0x00, 0x02, 0x00], [0x01, 0x00, 0x00, 0x00],
                [0x01]))

            # Enable ECR BLIK
            tags.append(self._build_and_log_tag("Enable ECR BLIK",
                [0x89, 0x00, 0x02, 0x00], [0x01, 0x00, 0x00, 0x00],
                [0x01]))

            # Enable Token
            tags.append(self._build_and_log_tag("Enable Token",
                [0x8D, 0x00, 0x02, 0x00], [0x01, 0x00, 0x00, 0x00],
                [0x00]))

            # Enable Return Markup Text Indicator
            tags.append(self._build_and_log_tag("Enable Return Markup Text Indicator",
                [0x9B, 0x00, 0x02, 0x00], [0x01, 0x00, 0x00, 0x00],
                [0x00]))

            # Return APM Data
            tags.append(self._build_and_log_tag("Return APM Data",
                [0x9D, 0x00, 0x02, 0x00], [0x01, 0x00, 0x00, 0x00],
                [0x00]))

            # Combine all tags
            payload = b''.join(tags)

            self.logger.info("\nPayload construction complete:")
            self.logger.info(f"  - Total tags: {len(tags)}")
            self.logger.info(f"  - Payload size: {len(payload)} bytes")
            self.logger.info("  - Full payload (hex):")
            for i in range(0, len(payload), 16):
                chunk = payload[i:i + 16]
                self.logger.info(f"    {' '.join([f'{b:02x}' for b in chunk])}")

            # Prepare final message
            message = struct.pack('<I', len(payload))  # Length (little endian)
            message += bytes([0x00, 0x02])  # Protocol version
            message += bytes([0x00, 0x02])  # Message type
            message += payload

            # Send payment request
            self.logger.info("Sending payment request...")
            writer.write(message)
            await writer.drain()
            self.logger.info("Payment request sent and flushed")

            # Read response
            data = await reader.read(1024)
            return self._process_payment_response(data)

        except Exception as e:
            self.logger.error(f"Error during payment processing: {str(e)}")
            self.logger.exception("Stack trace:")
            return "5"  # Terminal error
            
        finally:
            if 'writer' in locals():
                self.logger.info("Closing payment connection...")
                writer.close()
                await writer.wait_closed()

    def _process_payment_response(self, data: bytes) -> str:
        """Process the payment response data and extract response code."""
        self.logger.info(f"Received payment response data: {' '.join([f'{b:02x}' for b in data])}")
        self.logger.info(f"Response length: {len(data)} bytes")

        i = 8
        while i < len(data):
            tag = int.from_bytes(data[i:i+4], 'little')
            tag_length = int.from_bytes(data[i+4:i+8], 'little')
            
            self.logger.info(f"Processing tag: {tag}, length: {tag_length}")
            
            if tag == 131086:  # Response code tag
                self.logger.info("Found response code tag (131086)")
                if tag_length == 1:
                    response_code = self._ascii_to_int(data[i+8])
                    self.logger.info(f"Single byte response code: {response_code}")
                elif tag_length == 2:
                    response_code = self._ascii_to_int(data[i+8]) * 10 + self._ascii_to_int(data[i+9])
                    self.logger.info(f"Two byte response code: {response_code}")
            
            i += 8 + tag_length

        if 'response_code' in locals():
            self.logger.info(f"Processing final response code: {response_code}")
            response_str = str(response_code)
            self.logger.info(f"Final transaction result: {response_str}")
            return response_str
        
        self.logger.info("No response code found, returning default error code")
        return "5"


payment_service = PaymentService()