import asyncio
from typing import List
from services.logging_service import logging_service
from config import Config

class Payment:
    def __init__(self):
        logging_service.info("Initializing Payment Service")
        self.ped_state = 0
        self.terminal_ip = Config.TERMINAL_ELAVON_IP
        self.terminal_port_state = Config.TERMINAL_ELAVON_PORT_STATE
        self.terminal_port_payment = Config.TERMINAL_ELAVON_PORT_PAYMENT
        logging_service.info(f"Terminal configuration - IP: {self.terminal_ip}, State Port: {self.terminal_port_state}, Payment Port: {self.terminal_port_payment}")

    async def check_state(self) -> None:
        try:
            logging_service.info(f"Attempting to connect to terminal at {self.terminal_ip}:{self.terminal_port_state}")
            reader, writer = await asyncio.open_connection(self.terminal_ip, self.terminal_port_state)
            logging_service.info(f'Connected to: {writer.get_extra_info("peername")}')

            message = bytearray()
            message.extend([0x00, 0x00, 0x00, 0x00])  # header
            message.extend([0x00, 0x02])  # protocol version
            message.extend([0x00, 0x1C])  # message type
            
            logging_service.debug(f"Sending state check message: {message.hex()}")
            writer.write(message)
            await writer.drain()

            logging_service.debug("Waiting for terminal response...")
            data = await reader.read(100)
            logging_service.debug(f"Received raw data: {data.hex()}")
            
            self.ped_state = data[16]
            logging_service.info(f'Terminal state updated: {self.ped_state}')

        except Exception as e:
            logging_service.error(f'Error in check_state: {str(e)}')
            logging_service.exception("Full stack trace:")
            raise
        finally:
            logging_service.debug("Closing connection")
            writer.close()
            await writer.wait_closed()

    async def start_payment(self, price: float) -> str:
        try:
            logging_service.info(f"Starting payment process for amount: {price}")
            reader, writer = await asyncio.open_connection(self.terminal_ip, self.terminal_port_payment)
            logging_service.info(f'Connected to: {writer.get_extra_info("peername")}')

            # Define all tags exactly as in Dart version
            tag_eft_message_number = [0x00, 0x00, 0x02, 0x00]
            tag_eft_message_number_length = [0x02, 0x00, 0x00, 0x00]
            tag_eft_message_number_value = [0x30, 0x31]
            tag_eft_message_number_full = tag_eft_message_number + tag_eft_message_number_length + tag_eft_message_number_value

            tag_eft_amount1 = [0x01, 0x00, 0x02, 0x00]
            tag_eft_amount1_length = [0x0C, 0x00, 0x00, 0x00]
            tag_eft_amount1_value = list(self.price_to_ascii(price))
            tag_eft_amount1_full = tag_eft_amount1 + tag_eft_amount1_length + tag_eft_amount1_value

            tag_eft_amount1_label = [0x05, 0x00, 0x02, 0x00]
            tag_eft_amount1_label_length = [0x07, 0x00, 0x00, 0x00]
            tag_eft_amount1_label_value = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x31]
            tag_eft_amount1_label_full = tag_eft_amount1_label + tag_eft_amount1_label_length + tag_eft_amount1_label_value

            tag_eft_transaction_type = [0x09, 0x00, 0x02, 0x00]
            tag_eft_transaction_type_length = [0x02, 0x00, 0x00, 0x00]
            tag_eft_transaction_type_value = [0x30, 0x30]
            tag_eft_transaction_type_full = tag_eft_transaction_type + tag_eft_transaction_type_length + tag_eft_transaction_type_value

            tag_eft_amount2 = [0x02, 0x00, 0x02, 0x00]
            tag_eft_amount2_length = [0x0C, 0x00, 0x00, 0x00]
            tag_eft_amount2_value = [0x30] * 12
            tag_eft_amount2_full = tag_eft_amount2 + tag_eft_amount2_length + tag_eft_amount2_value

            tag_eft_amount3 = [0x03, 0x00, 0x02, 0x00]
            tag_eft_amount3_length = [0x0C, 0x00, 0x00, 0x00]
            tag_eft_amount3_value = [0x30] * 12
            tag_eft_amount3_full = tag_eft_amount3 + tag_eft_amount3_length + tag_eft_amount3_value

            tag_eft_amount4 = [0x04, 0x00, 0x02, 0x00]
            tag_eft_amount4_length = [0x0C, 0x00, 0x00, 0x00]
            tag_eft_amount4_value = [0x30] * 12
            tag_eft_amount4_full = tag_eft_amount4 + tag_eft_amount4_length + tag_eft_amount4_value

            tag_eft_amount2_label = [0x06, 0x00, 0x02, 0x00]
            tag_eft_amount2_label_length = [0x07, 0x00, 0x00, 0x00]
            tag_eft_amount2_label_value = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x32]
            tag_eft_amount2_label_full = tag_eft_amount2_label + tag_eft_amount2_label_length + tag_eft_amount2_label_value

            tag_eft_amount3_label = [0x07, 0x00, 0x02, 0x00]
            tag_eft_amount3_label_length = [0x07, 0x00, 0x00, 0x00]
            tag_eft_amount3_label_value = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x33]
            tag_eft_amount3_label_full = tag_eft_amount3_label + tag_eft_amount3_label_length + tag_eft_amount3_label_value

            tag_eft_amount4_label = [0x08, 0x00, 0x02, 0x00]
            tag_eft_amount4_label_length = [0x07, 0x00, 0x00, 0x00]
            tag_eft_amount4_label_value = [0x41, 0x6D, 0x6F, 0x75, 0x6E, 0x74, 0x34]
            tag_eft_amount4_label_full = tag_eft_amount4_label + tag_eft_amount4_label_length + tag_eft_amount4_label_value

            tag_eft_commercial_code = [0x0C, 0x00, 0x02, 0x00]
            tag_eft_commercial_code_length = [0x02, 0x00, 0x00, 0x00]
            tag_eft_commercial_code_value = [0x20, 0x20]
            tag_eft_commercial_code_full = tag_eft_commercial_code + tag_eft_commercial_code_length + tag_eft_commercial_code_value

            tag_eft_suspect_fraud_indicator = [0x5B, 0x00, 0x02, 0x00]
            tag_eft_suspect_fraud_indicator_length = [0x01, 0x00, 0x00, 0x00]
            tag_eft_suspect_fraud_indicator_value = [0x00]
            tag_eft_suspect_fraud_indicator_full = (tag_eft_suspect_fraud_indicator + 
                                                  tag_eft_suspect_fraud_indicator_length + 
                                                  tag_eft_suspect_fraud_indicator_value)

            tag_eft_return_card_resp_value = [0x7D, 0x00, 0x02, 0x00]
            tag_eft_return_card_resp_value_length = [0x01, 0x00, 0x00, 0x00]
            tag_eft_return_card_resp_value_value = [0x01]
            tag_eft_return_card_resp_value_full = (tag_eft_return_card_resp_value + 
                                                 tag_eft_return_card_resp_value_length + 
                                                 tag_eft_return_card_resp_value_value)

            tag_eft_return_sig_req_value = [0x86, 0x00, 0x02, 0x00]
            tag_eft_return_sig_req_value_length = [0x01, 0x00, 0x00, 0x00]
            tag_eft_return_sig_req_value_value = [0x01]
            tag_eft_return_sig_req_value_full = (tag_eft_return_sig_req_value + 
                                               tag_eft_return_sig_req_value_length + 
                                               tag_eft_return_sig_req_value_value)

            tag_eft_enable_ecr_blik = [0x89, 0x00, 0x02, 0x00]
            tag_eft_enable_ecr_blik_length = [0x01, 0x00, 0x00, 0x00]
            tag_eft_enable_ecr_blik_value = [0x01]
            tag_eft_enable_ecr_blik_full = (tag_eft_enable_ecr_blik + 
                                          tag_eft_enable_ecr_blik_length + 
                                          tag_eft_enable_ecr_blik_value)

            tag_eft_enable_token = [0x8D, 0x00, 0x02, 0x00]
            tag_eft_enable_token_length = [0x01, 0x00, 0x00, 0x00]
            tag_eft_enable_token_value = [0x00]
            tag_eft_enable_token_full = tag_eft_enable_token + tag_eft_enable_token_length + tag_eft_enable_token_value

            tag_eft_enable_return_markup_text_indicator = [0x9B, 0x00, 0x02, 0x00]
            tag_eft_enable_return_markup_text_indicator_length = [0x01, 0x00, 0x00, 0x00]
            tag_eft_enable_return_markup_text_indicator_value = [0x00]
            tag_eft_enable_return_markup_text_indicator_full = (tag_eft_enable_return_markup_text_indicator + 
                                                              tag_eft_enable_return_markup_text_indicator_length + 
                                                              tag_eft_enable_return_markup_text_indicator_value)

            tag_eft_return_apm_data = [0x9D, 0x00, 0x02, 0x00]
            tag_eft_return_apm_data_length = [0x01, 0x00, 0x00, 0x00]
            tag_eft_return_apm_data_value = [0x00]
            tag_eft_return_apm_data_full = (tag_eft_return_apm_data + 
                                          tag_eft_return_apm_data_length + 
                                          tag_eft_return_apm_data_value)

            payload = (tag_eft_message_number_full + tag_eft_amount1_full + 
                      tag_eft_amount1_label_full + tag_eft_transaction_type_full +
                      tag_eft_amount2_full + tag_eft_amount3_full + tag_eft_amount4_full +
                      tag_eft_amount2_label_full + tag_eft_amount3_label_full +
                      tag_eft_amount4_label_full + tag_eft_commercial_code_full +
                      tag_eft_suspect_fraud_indicator_full + tag_eft_return_card_resp_value_full +
                      tag_eft_return_sig_req_value_full + tag_eft_enable_ecr_blik_full +
                      tag_eft_enable_token_full + tag_eft_enable_return_markup_text_indicator_full +
                      tag_eft_return_apm_data_full)

            logging_service.debug("Building payment message...")
            message = bytearray()
            message.extend([len(payload), 0x00, 0x00, 0x00])  # header
            message.extend([0x00, 0x02])  # protocol version
            message.extend([0x00, 0x02])  # message type
            message.extend(payload)
            
            logging_service.debug(f"Sending payment message (length: {len(message)})")
            writer.write(message)
            await writer.drain()

            endstring = ""
            
            try:
                # Implementacja podobna do socket.listen z Dart
                while True:
                    logging_service.debug("Waiting for payment response...")
                    data = await reader.read(1024)
                    
                    if not data:  # Połączenie zostało zamknięte
                        logging_service.debug("Connection closed by terminal")
                        break
                        
                    logging_service.debug(f"Received raw response data: {data.hex()}")
                    
                    i = 8
                    tag = 0
                    tag_length = 0
                    response_code = 0
                    
                    while i < len(data):
                        tag = (data[i] + data[i + 1] * 256 + 
                              data[i + 2] * 65536 + data[i + 3] * 16777216)
                        tag_length = (data[i + 4] + data[i + 5] * 256 + 
                                    data[i + 6] * 65536 + data[i + 7] * 16777216)
                        
                        logging_service.debug(f"Processing tag: {tag}, length: {tag_length}")
                        if tag == 131086:  # 0x20006
                            if tag_length == 1:
                                response_code = self.ascii_to_int(data[i + 8])
                                logging_service.debug(f"Found response code (1 byte): {response_code}")
                            elif tag_length == 2:
                                response_code = self.ascii_to_int(data[i + 8] + data[i + 9])
                                logging_service.debug(f"Found response code (2 bytes): {response_code}")
                            
                            # Jeśli znaleźliśmy kod odpowiedzi, możemy zakończyć
                            if response_code is not None:
                                endstring = str(response_code)
                                logging_service.info(f"Payment completed with response code: {endstring}")
                                return endstring
                                
                        i += 8 + tag_length

                    # Jeśli nie znaleźliśmy kodu odpowiedzi, czekamy na więcej danych
                    await asyncio.sleep(0.1)  # Krótka przerwa przed kolejnym odczytem
                
                if not endstring:
                    logging_service.error("No valid response code received from terminal")
                    return "15"  # Kod błędu dla braku odpowiedzi
                    
                return endstring

            except Exception as e:
                logging_service.error(f"Error while reading response: {str(e)}")
                raise
            finally:
                logging_service.debug("Closing socket connection")
                writer.close()
                await writer.wait_closed()

        except Exception as e:
            logging_service.error(f'Error in start_payment: {str(e)}')
            logging_service.exception("Full stack trace:")
            raise

    async def start_transaction(self, price: float) -> str:
        try:
            logging_service.info(f"Starting new transaction for amount: {price}")
            self.ped_state = 0
            attempt = 1
            
            while True:
                logging_service.info(f"Checking terminal state (attempt {attempt})")
                await self.check_state()
                if self.ped_state == 1:
                    logging_service.info("Terminal ready for transaction")
                    break
                logging_service.debug(f"Terminal not ready (state: {self.ped_state}), waiting 2 seconds...")
                await asyncio.sleep(2)
                attempt += 1
            
            logging_service.info("Starting payment process")
            return await self.start_payment(price)
            
        except Exception as e:
            logging_service.error(f'Error in start_transaction: {str(e)}')
            logging_service.exception("Full stack trace:")
            raise

    def price_to_ascii(self, price: float) -> bytes:
        logging_service.debug(f"Converting price {price} to ASCII format")
        price_str = f"{price:.2f}"
        ascii_bytes = bytearray()
        
        padding_length = 12 - len(price_str)
        logging_service.debug(f"Adding {padding_length} padding zeros")
        
        # Add padding zeros
        for _ in range(padding_length):
            ascii_bytes.append(0x30)
        
        # Convert price digits to ASCII
        for char in price_str:
            if char.isdigit():
                ascii_bytes.append(0x30 + int(char))
        
        logging_service.debug(f"Converted price to ASCII: {ascii_bytes.hex()}")
        return bytes(ascii_bytes)

    @staticmethod
    def ascii_to_int(data: int) -> int:
        ascii_map = {
            0x30: 0, 0x31: 1, 0x32: 2, 0x33: 3, 0x34: 4,
            0x35: 5, 0x36: 6, 0x37: 7, 0x38: 8, 0x39: 9
        }
        result = ascii_map.get(data, 10)
        logging_service.debug(f"Converting ASCII {hex(data)} to int: {result}")
        return result

    def run_sync_transaction(self, price: float) -> str:
        """
        Metoda pomocnicza do uruchamiania asynchronicznej transakcji w synchronicznym kontekście.
        """
        try:
            logging_service.info(f"Starting synchronous transaction wrapper for price: {price}")
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            result = loop.run_until_complete(self.start_transaction(price))
            loop.close()
            return result
        except Exception as e:
            logging_service.error(f"Error in synchronous transaction wrapper: {str(e)}")
            raise

payment_service = Payment()
logging_service.info("Payment service initialized")
