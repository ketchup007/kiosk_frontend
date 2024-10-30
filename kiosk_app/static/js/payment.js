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
        this.finalizePaymentButton.addEventListener('click', () => this.initializePayment());
        this.cancelPaymentButton.addEventListener('click', () => this.handleCancelOrder());
        document.addEventListener('touchstart', () => this.resetInactivityTimer());
    }

    async initializePayment() {
        this.paymentStatus.textContent = this._('Initializing payment...');
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
            
            if (data.success) {
                await this.processPayment();
            } else {
                this.paymentStatus.textContent = this._('Payment initialization failed. Please try again.');
            }
        } catch (error) {
            console.error('Payment initialization error:', error);
            this.paymentStatus.textContent = this._('Payment initialization failed. Please try again.');
        }
    }

    async processPayment() {
        this.paymentStatus.textContent = this._('Processing payment...');
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
                this.paymentStatus.textContent = this._('Payment successful!');
                window.location.href = `/order/confirmation/${data.kds_number}`;
            } else {
                this.paymentStatus.textContent = this._('Payment failed. Please try again.');
            }
        } catch (error) {
            console.error('Payment processing error:', error);
            this.paymentStatus.textContent = this._('Payment failed. Please try again.');
        }
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