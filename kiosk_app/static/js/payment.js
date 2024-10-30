class PaymentPage {
    constructor(orderId, orderTotal) {
        this.orderId = orderId;
        this.orderTotal = orderTotal;
        this.paymentStatus = document.getElementById('payment-status');
        this.finalizePaymentButton = document.getElementById('finalize-payment');
        this.cancelPaymentButton = document.getElementById('cancel-payment');
        this.inactivityTimer = null;
        this.inactivityTimeout = 900000; // 15 minutes

        this.initializeEventListeners();
        this.startInactivityMonitoring();
    }

    initializeEventListeners() {
        this.finalizePaymentButton.addEventListener('click', () => {
            this.finalizePaymentButton.disabled = true;
            this.initializePayment();
        });
        this.cancelPaymentButton.addEventListener('click', () => this.handleCancelOrder());
        document.addEventListener('touchstart', () => this.resetInactivityTimer());
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
            
            if (data.success && data.result === "0") {
                this.updateStatus(this._('Payment successful!'), 'success');
                await this.processPayment();
            } else {
                let errorMessage;
                switch(data.result) {
                    case "1":
                        errorMessage = this._('Payment cancelled by user');
                        break;
                    case "2":
                        errorMessage = this._('Payment timeout');
                        break;
                    case "3":
                        errorMessage = this._('Card error');
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
                // Krótkie opóźnienie przed przekierowaniem
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