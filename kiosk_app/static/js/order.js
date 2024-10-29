class OrderPage {
    constructor(orderId) {
        this.orderId = orderId;
        this.total = 0;
        this.orderItems = {};
        this.inactivityTimer = null;
        this.inactivityTimeout = 10 * 60 * 1000; // 10 minutes
        this.availabilityCheckInterval = 1000; // 1 second
        this.initializeEventListeners();
        this.startMonitoring();
        
        // Set initial active category
        const firstCategoryButton = document.querySelector('.category-button');
        if (firstCategoryButton) {
            this.handleCategoryClick(firstCategoryButton);
        }

        // Initialize language handlers
        this.initializeLanguageHandlers();
    }

    updateTotal(newTotal) {
        this.total = newTotal;
        const totalButton = document.getElementById('proceed-to-summary');
        const template = totalButton.dataset.template;
        totalButton.textContent = template.replace('0.00', this.total.toFixed(2));
    }

    async updateQuantity(itemId, change) {
        try {
            const endpoint = change > 0 ? '/add_to_order' : '/remove_from_order';
            const response = await fetchWithErrorHandling(endpoint, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    order_id: this.orderId,
                    item_id: itemId,
                    quantity: Math.abs(change)
                })
            });

            if (response.success) {
                // Update quantity display
                const quantityElement = document.querySelector(`.quantity[data-item-id="${itemId}"]`);
                const currentQuantity = parseInt(quantityElement.textContent) || 0;
                const newQuantity = Math.max(0, currentQuantity + change);
                quantityElement.textContent = newQuantity;

                // Update total
                const orderTotal = await fetchWithErrorHandling(`/get_order_total?order_id=${this.orderId}`);
                this.updateTotal(orderTotal.total);

                // Check availability and update buttons
                this.checkItemAvailability();
            }
        } catch (error) {
            console.error('Error updating quantity:', error);
        }
    }

    async checkItemAvailability() {
        try {
            const data = await fetchWithErrorHandling(`/get_available_items?order_id=${this.orderId}`);
            if (data.available_items) {
                this.updateProductAvailability(data.available_items);
            }
        } catch (error) {
            console.error('Error checking availability:', error);
        }
    }

    updateProductAvailability(availableItems) {
        availableItems.forEach(item => {
            const productItem = document.querySelector(`.product-item[data-item-id="${item.item_id}"]`);
            const quantityControl = productItem?.querySelector('.order-quantity-control');
            const quantityDisplay = productItem?.querySelector('.quantity');
            
            if (productItem) {
                const currentQuantity = parseInt(quantityDisplay?.textContent) || 0;

                if (item.available_quantity > 0) {
                    // Restore buttons if available
                    if (!quantityControl.querySelector('.increase-quantity')) {
                        quantityControl.innerHTML = `
                            <button class="decrease-quantity" data-item-id="${item.item_id}" ${currentQuantity <= 0 ? 'disabled' : ''}>-</button>
                            <span class="quantity" data-item-id="${item.item_id}">${currentQuantity}</span>
                            <button class="increase-quantity" data-item-id="${item.item_id}">+</button>
                        `;
                        this.initializeEventListeners(); // Re-initialize event listeners for new buttons
                    }
                    productItem.classList.remove('unavailable');
                    productItem.title = '';
                } else {
                    // Replace buttons with out of stock message
                    quantityControl.innerHTML = `<span class="out-of-stock-message">${_('Out of stock')}</span>`;
                    productItem.classList.add('unavailable');
                    productItem.title = _('Product temporarily unavailable');
                    
                    // If item is in cart, show warning
                    if (currentQuantity > 0) {
                        showFlashMessage(_('Some selected items are no longer available'), 'warning');
                    }
                }
            }
        });
    }

    handleCategoryClick(button) {
        // Remove active class from all buttons
        document.querySelectorAll('.category-button').forEach(btn => {
            btn.classList.remove('active');
        });
        
        // Add active class to clicked button
        button.classList.add('active');
        
        const category = button.dataset.category;
        const productList = document.querySelector('.product-list');
        
        // Add transition class for smooth animation
        productList.classList.add('changing');
        
        setTimeout(() => {
            document.querySelectorAll('.product-item').forEach(item => {
                if (category === 'sum' || item.dataset.category === category) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
            
            // Remove transition class
            productList.classList.remove('changing');
        }, 300);
    }

    resetInactivityTimer() {
        console.log('Resetting inactivity timer');
        // Clear existing timer
        if (this.inactivityTimer) {
            clearTimeout(this.inactivityTimer);
        }
    
        // Set new timer
        this.inactivityTimer = setTimeout(() => {
            console.log('Inactivity timeout reached, canceling order');
            this.cancelOrder(true); // Automatic cancellation
        }, this.inactivityTimeout);
    }

    async cancelOrder(isAutomatic = false) {
        const cancelButton = document.getElementById('cancel-order');
        const successMessage = cancelButton.dataset.successMessage;
        const errorMessage = cancelButton.dataset.errorMessage;

        try {
            // Disable button during cancellation
            cancelButton.disabled = true;

            const response = await fetchWithErrorHandling('/cancel_order', {
                method: 'POST',
                headers: { 
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ 
                    order_id: this.orderId,
                    aps_id: document.body.dataset.apsId,
                    is_automatic: isAutomatic
                })
            });

            if (response.success) {
                if (!isAutomatic) {
                    showFlashMessage(successMessage, 'success');
                    // Short delay only for manual cancellation
                    await new Promise(resolve => setTimeout(resolve, 1000));
                }
                // Redirect to home page
                window.location.href = '/';
            } else {
                throw new Error(response.error || errorMessage);
            }
        } catch (error) {
            console.error('Error canceling order:', error);
            if (!isAutomatic) {
                showFlashMessage(error.message || errorMessage, 'error');
            }
            // Re-enable button in case of error
            cancelButton.disabled = false;
        }
    }

    initializeEventListeners() {
        // Quantity controls
        document.querySelectorAll('.increase-quantity').forEach(button => {
            button.addEventListener('click', () => this.updateQuantity(button.dataset.itemId, 1));
        });

        document.querySelectorAll('.decrease-quantity').forEach(button => {
            button.addEventListener('click', () => this.updateQuantity(button.dataset.itemId, -1));
        });

        // Category buttons
        document.querySelectorAll('.category-button').forEach(button => {
            button.addEventListener('click', () => this.handleCategoryClick(button));
        });

        // Action buttons
        const cancelButton = document.getElementById('cancel-order');
        if (cancelButton) {
            cancelButton.addEventListener('click', (e) => {
                e.preventDefault();
                this.cancelOrder();
            });
        }

        const proceedButton = document.getElementById('proceed-to-summary');
        proceedButton.addEventListener('click', () => {
            if (this.total > 0) {
                window.location.href = `/order/summary/${this.orderId}`;
            } else {
                showFlashMessage(proceedButton.dataset.emptyCartMessage, 'error');
            }
        });

        // Add listeners for all relevant events
        const events = ['touchstart', 'click', 'scroll', 'mousemove', 'keypress'];
        events.forEach(eventType => {
            document.addEventListener(eventType, () => {
                this.resetInactivityTimer();
            });
        });

        // Call restoreState after initialization
        this.restoreState();
    }

    startMonitoring() {
        this.checkItemAvailability();
        setInterval(() => this.checkItemAvailability(), this.availabilityCheckInterval);
        this.resetInactivityTimer(); // Initial timer setup
    }

    // Add new method for handling language change
    initializeLanguageHandlers() {
        document.querySelectorAll('.order-flag-button').forEach(button => {
            button.addEventListener('click', (e) => {
                e.preventDefault(); // Prevent default button action
                const lang = button.querySelector('img').alt.toLowerCase();
                this.changeLanguage(lang);
            });
        });
    }

    // Add method for changing language
    changeLanguage(lang) {
        fetch('/set_language/' + lang, {
            method: 'POST',
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Save current order state before refreshing
                const currentState = {
                    orderId: this.orderId,
                    total: this.total,
                    orderItems: this.orderItems
                };
                
                // Save state in sessionStorage
                sessionStorage.setItem('orderState', JSON.stringify(currentState));
                
                // Refresh page
                location.reload();
            }
        })
        .catch(error => {
            console.error('Error changing language:', error);
            showFlashMessage(_('Failed to change language'), 'error');
        });
    }

    // Add method for restoring state after refresh
    restoreState() {
        const savedState = sessionStorage.getItem('orderState');
        if (savedState) {
            const state = JSON.parse(savedState);
            if (state.orderId === this.orderId) {
                this.total = state.total;
                this.orderItems = state.orderItems;
                this.updateDisplay();
            }
            // Clear saved state
            sessionStorage.removeItem('orderState');
        }
    }

    // Add method for updating display
    updateDisplay() {
        // Update displayed product quantities
        Object.entries(this.orderItems).forEach(([itemId, quantity]) => {
            const quantityElement = document.querySelector(`.quantity[data-item-id="${itemId}"]`);
            if (quantityElement) {
                quantityElement.textContent = quantity;
            }
        });

        // Update order total
        this.updateTotal(this.total);
    }
}

// Initialize on DOM load
document.addEventListener('DOMContentLoaded', () => {
    const orderContainer = document.querySelector('.order-container');
    if (orderContainer) {
        const orderId = orderContainer.dataset.orderId;
        new OrderPage(orderId);
    }
});
