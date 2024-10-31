class PaymentPage {
    constructor(orderId, orderTotal) {
        this.orderId = orderId;
        this.orderTotal = orderTotal;
        this.paymentStatus = document.getElementById('payment-status');
        this.finalizePaymentButton = document.getElementById('finalize-payment');
        this.cancelPaymentButton = document.getElementById('cancel-payment');
        this.phoneInput = document.getElementById('phone');
        this.phoneError = document.getElementById('phoneError');
        this.savePhoneBtn = document.getElementById('savePhone');
        
        // Inicjalizacja modala Bootstrap
        this.phoneModal = new bootstrap.Modal(document.getElementById('phoneModal'));
        
        this.initializeEventListeners();
        this.initializeNumpad();
        this.initializePhoneMask();
    }

    initializeEventListeners() {
        // Obsługa przycisku zapisz w modalu
        this.savePhoneBtn.addEventListener('click', () => {
            this.handlePhoneSubmit();
        });

        // Obsługa klawisza Enter w input
        this.phoneInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                this.handlePhoneSubmit();
            }
        });

        // Reset błędów przy otwieraniu modala
        document.getElementById('phoneModal').addEventListener('show.bs.modal', () => {
            this.hideError();
            this.phoneInput.value = '';
        });

        // Obsługa anulowania płatności
        this.cancelPaymentButton.addEventListener('click', () => this.handleCancelOrder());

        // Obsługa checkboxa "wszystkie zgody"
        document.getElementById('allConsents').addEventListener('change', (e) => {
            const checkboxes = document.querySelectorAll('.consent-group input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                if (checkbox.id !== 'allConsents') {
                    checkbox.checked = e.target.checked;
                }
            });
            this.updateAllConsentsCheckbox();
        });

        // Obsługa pojedynczych checkboxów
        document.querySelectorAll('.consent-group input[type="checkbox"]').forEach(checkbox => {
            if (checkbox.id !== 'allConsents') {
                checkbox.addEventListener('change', () => {
                    this.updateAllConsentsCheckbox();
                });
            }
        });
    }

    hidePhoneModal() {
        this.phoneModal.hide();
    }

    showPhoneModal() {
        this.phoneModal.show();
        this.clearConsentsValidation();
        setTimeout(() => this.phoneInput.focus(), 500);
    }

    showError(message) {
        this.phoneInput.classList.add('is-invalid');
        this.phoneError.textContent = message;
    }

    hideError() {
        this.phoneInput.classList.remove('is-invalid');
        this.phoneError.textContent = '';
    }

    async handlePhoneSubmit() {
        const phoneNumber = this.phoneInput.value.trim();
        
        if (!this.validatePhoneNumber(phoneNumber)) {
            this.showError(this._('Please enter a valid phone number'));
            return;
        }

        if (!this.validateConsents()) {
            return;
        }

        try {
            const response = await fetch('/update_phone_number', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    order_id: this.orderId,
                    phone_number: phoneNumber
                })
            });

            const data = await response.json();
            if (data.success) {
                this.hidePhoneModal();
                this.initializePayment();
            } else {
                this.showError(data.error || this._('Failed to save phone number'));
            }
        } catch (error) {
            console.error('Error saving phone number:', error);
            this.showError(this._('Failed to save phone number'));
        }
    }

    validatePhoneNumber(phone) {
        const unmaskedValue = phone.replace(/[^0-9]/g, '');
        return unmaskedValue.length === 9;
    }

    async initializePayment() {
        this.updateStatus(this._('Initializing payment...'), 'processing');
        try {
            const response = await fetch('/init_payment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    order_id: this.orderId,
                    amount: this.orderTotal
                })
            });
            const data = await response.json();
            
            if (data.success && (data.result === "0" || data.result === "7")) {
                this.updateStatus(this._('Payment successful!'), 'success');
                await this.processPayment();
            } else {
                let errorMessage;
                switch(data.result) {
                    case "0":
                        errorMessage = this._('Payment successful');
                        break;
                    case "1":
                        errorMessage = this._('Payment cancelled by user');
                        break;
                    case "2":
                        errorMessage = this._('Payment timeout');
                        break;
                    case "3":
                        errorMessage = this._('Card error');
                        break;
                    case "4":
                        errorMessage = this._('Invalid amount');
                        break;
                    case "5":
                        errorMessage = this._('Terminal error');
                        break;
                    default:
                        errorMessage = this._('Payment failed. Please try again.');
                }
                this.updateStatus(errorMessage, 'error');
                this.finalizePaymentButton.disabled = false;
            }
        } catch (error) {
            console.error('Payment initialization error:', error);
            this.updateStatus(this._('Payment initialization failed. Please try again.'), 'error');
            this.finalizePaymentButton.disabled = false;
        }
    }

    async processPayment() {
        this.updateStatus(this._('Processing payment...'), 'processing');
        try {
            const response = await fetch('/process_payment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    order_id: this.orderId,
                    amount: this.orderTotal
                })
            });
            const data = await response.json();
            
            if (data.success) {
                this.updateStatus(this._('Payment successful!'), 'success');
                setTimeout(() => {
                    window.location.href = `/order/confirmation/${this.orderId}`;
                }, 1500);
            } else {
                this.updateStatus(this._('Payment failed. Please try again.'), 'error');
                this.finalizePaymentButton.disabled = false;
            }
        } catch (error) {
            console.error('Payment processing error:', error);
            this.updateStatus(this._('Payment failed. Please try again.'), 'error');
            this.finalizePaymentButton.disabled = false;
        }
    }

    updateStatus(message, type) {
        this.paymentStatus.textContent = message;
        this.paymentStatus.className = `payment-status ${type}`;
    }

    async handleCancelOrder() {
        if (confirm(this._('Are you sure you want to cancel your order?'))) {
            try {
                const response = await fetch('/cancel_order', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        order_id: this.orderId
                    })
                });
                const data = await response.json();
                
                if (data.success) {
                    window.location.href = '/';
                } else {
                    alert(this._('Failed to cancel order. Please try again.'));
                }
            } catch (error) {
                console.error('Order cancellation error:', error);
                alert(this._('Failed to cancel order. Please try again.'));
            }
        }
    }

    startInactivityMonitoring() {
        this.resetInactivityTimer();
    }

    resetInactivityTimer() {
        if (this.inactivityTimer) {
            clearTimeout(this.inactivityTimer);
        }
        this.inactivityTimer = setTimeout(() => this.handleInactivity(), this.inactivityTimeout);
    }

    async handleInactivity() {
        if (confirm(this._('You have been inactive for a while. Do you want to continue your payment?'))) {
            this.resetInactivityTimer();
        } else {
            try {
                const response = await fetch('/cancel_order', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        order_id: this.orderId
                    })
                });
                const data = await response.json();
                
                if (data.success) {
                    window.location.href = '/';
                } else {
                    alert(this._('Failed to cancel order. Please try again.'));
                }
            } catch (error) {
                console.error('Order cancellation error:', error);
                alert(this._('Failed to cancel order. Please try again.'));
            }
        }
    }

    initializeNumpad() {
        // Obsługa przycisków numerycznych
        document.querySelectorAll('.numpad-button').forEach(button => {
            button.addEventListener('click', (e) => {
                e.preventDefault();
                const number = button.dataset.number;
                const action = button.dataset.action;

                if (number) {
                    this.appendNumber(number);
                } else if (action === 'delete') {
                    this.deleteNumber();
                } else if (action === 'clear') {
                    this.clearInput();
                }
            });
        });
    }

    appendNumber(number) {
        const currentValue = this.phoneInput.value.replace(/[^0-9]/g, '');
        if (currentValue.length < 9) {  // Limit do 9 cyfr
            const newValue = currentValue + number;
            // Formatowanie XXX-XXX-XXX
            const formattedValue = newValue.replace(/(\d{3})(\d{3})?(\d{3})?/, function(match, p1, p2, p3) {
                let result = p1;
                if (p2) result += '-' + p2;
                if (p3) result += '-' + p3;
                return result;
            });
            this.phoneInput.value = formattedValue;
            this.hideError();
        }
    }

    deleteNumber() {
        const currentValue = this.phoneInput.value.replace(/[^0-9]/g, '');
        if (currentValue.length > 0) {
            const newValue = currentValue.slice(0, -1);
            // Formatowanie XXX-XXX-XXX
            const formattedValue = newValue.replace(/(\d{3})(\d{3})?(\d{3})?/, function(match, p1, p2, p3) {
                let result = p1 || '';
                if (p2) result += '-' + p2;
                if (p3) result += '-' + p3;
                return result;
            });
            this.phoneInput.value = formattedValue;
        }
        this.hideError();
    }

    clearInput() {
        this.phoneInput.value = '';
        this.hideError();
    }

    initializePhoneMask() {
        // Inicjalizacja maski dla numeru telefonu
        $(this.phoneInput).inputmask({
            mask: '999-999-999',
            placeholder: "_",
            showMaskOnHover: false,
            showMaskOnFocus: false,
            clearIncomplete: true,
            oncomplete: () => {
                this.hideError();
            },
            onincomplete: () => {
                this.showError(this._('Please enter a complete phone number'));
            },
            oncleared: () => {
                this.hideError();
            }
        });
    }

    validateConsents() {
        const requiredConsents = document.querySelectorAll('.required-consent');
        const consentError = document.getElementById('consentError');
        const saveButton = document.getElementById('savePhone');
        
        let allRequired = true;
        requiredConsents.forEach(consent => {
            if (!consent.checked) {
                allRequired = false;
                consent.classList.add('is-invalid');
            } else {
                consent.classList.remove('is-invalid');
            }
        });

        if (!allRequired) {
            consentError.style.display = 'block';
            return false;
        } else {
            consentError.style.display = 'none';
            return true;
        }
    }

    updateAllConsentsCheckbox() {
        const allConsentsCheckbox = document.getElementById('allConsents');
        const otherCheckboxes = document.querySelectorAll('.consent-group input[type="checkbox"]:not(#allConsents)');
        const allChecked = Array.from(otherCheckboxes).every(checkbox => checkbox.checked);
        
        allConsentsCheckbox.checked = allChecked;
    }

    // Nowa metoda do czyszczenia błędów zgód
    clearConsentsValidation() {
        const requiredConsents = document.querySelectorAll('.required-consent');
        const consentError = document.getElementById('consentError');
        
        requiredConsents.forEach(consent => {
            consent.classList.remove('is-invalid');
        });
        consentError.style.display = 'none';
    }

    // Helper method for translations
    _(text) {
        // This should be replaced with actual translation logic
        return text;
    }
}

// Initialize the payment page when the DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    const orderId = document.querySelector('[data-order-id]')?.dataset.orderId;
    const orderTotal = document.querySelector('[data-order-total]')?.dataset.orderTotal;
    
    if (orderId && orderTotal) {
        new PaymentPage(parseInt(orderId), parseFloat(orderTotal));
    } else {
        console.error('Missing required order data');
    }
}); 