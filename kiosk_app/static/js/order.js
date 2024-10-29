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

        // Dodaj obsługę zmiany języka
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
            const increaseButton = productItem?.querySelector('.increase-quantity');
            const decreaseButton = productItem?.querySelector('.decrease-quantity');
            const quantityDisplay = productItem?.querySelector('.quantity');
            
            if (productItem) {
                const currentQuantity = parseInt(quantityDisplay?.textContent) || 0;

                if (item.available_quantity > 0) {
                    increaseButton.disabled = false;
                    productItem.classList.remove('unavailable');
                    productItem.title = '';
                } else {
                    increaseButton.disabled = true;
                    productItem.classList.add('unavailable');
                    productItem.title = _('Product temporarily unavailable');
                    
                    // If item is in cart, show warning
                    if (currentQuantity > 0) {
                        showFlashMessage(_('Some selected items are no longer available'), 'warning');
                    }
                }

                // Disable decrease button if quantity is 0
                decreaseButton.disabled = currentQuantity <= 0;
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
        // Wyczyść istniejący timer
        if (this.inactivityTimer) {
            clearTimeout(this.inactivityTimer);
        }
    
        // Ustaw nowy timer
        this.inactivityTimer = setTimeout(() => {
            console.log('Inactivity timeout reached, canceling order');
            this.cancelOrder(true); // Automatyczne anulowanie
        }, this.inactivityTimeout);
    }

    async cancelOrder(isAutomatic = false) {
        const cancelButton = document.getElementById('cancel-order');
        const successMessage = cancelButton.dataset.successMessage;
        const errorMessage = cancelButton.dataset.errorMessage;

        try {
            // Wyłącz przycisk podczas anulowania
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
                    // Krótkie opóźnienie tylko dla manualnego anulowania
                    await new Promise(resolve => setTimeout(resolve, 1000));
                }
                // Przekieruj do strony głównej
                window.location.href = '/';
            } else {
                throw new Error(response.error || errorMessage);
            }
        } catch (error) {
            console.error('Error canceling order:', error);
            if (!isAutomatic) {
                showFlashMessage(error.message || errorMessage, 'error');
            }
            // Włącz z powrotem przycisk w przypadku błędu
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

        // Dodaj nasłuchiwanie na wszystkie istotne zdarzenia
        const events = ['touchstart', 'click', 'scroll', 'mousemove', 'keypress'];
        events.forEach(eventType => {
            document.addEventListener(eventType, () => {
                this.resetInactivityTimer();
            });
        });

        // Dodaj wywołanie restoreState po inicjalizacji
        this.restoreState();
    }

    startMonitoring() {
        this.checkItemAvailability();
        setInterval(() => this.checkItemAvailability(), this.availabilityCheckInterval);
        this.resetInactivityTimer(); // Inicjalne ustawienie timera
    }

    // Dodaj nową metodę do obsługi zmiany języka
    initializeLanguageHandlers() {
        document.querySelectorAll('.order-flag-button').forEach(button => {
            button.addEventListener('click', (e) => {
                e.preventDefault(); // Zapobiegaj domyślnej akcji przycisku
                const lang = button.querySelector('img').alt.toLowerCase();
                this.changeLanguage(lang);
            });
        });
    }

    // Dodaj metodę do zmiany języka
    changeLanguage(lang) {
        fetch('/set_language/' + lang, {
            method: 'POST',
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Zapisz aktualny stan zamówienia przed odświeżeniem
                const currentState = {
                    orderId: this.orderId,
                    total: this.total,
                    orderItems: this.orderItems
                };
                
                // Zapisz stan w sessionStorage
                sessionStorage.setItem('orderState', JSON.stringify(currentState));
                
                // Odśwież stronę
                location.reload();
            }
        })
        .catch(error => {
            console.error('Error changing language:', error);
            showFlashMessage(_('Failed to change language'), 'error');
        });
    }

    // Dodaj metodę do przywracania stanu po odświeżeniu
    restoreState() {
        const savedState = sessionStorage.getItem('orderState');
        if (savedState) {
            const state = JSON.parse(savedState);
            if (state.orderId === this.orderId) {
                this.total = state.total;
                this.orderItems = state.orderItems;
                this.updateDisplay();
            }
            // Wyczyść zapisany stan
            sessionStorage.removeItem('orderState');
        }
    }

    // Dodaj metodę do aktualizacji wyświetlania
    updateDisplay() {
        // Aktualizuj wyświetlane ilości produktów
        Object.entries(this.orderItems).forEach(([itemId, quantity]) => {
            const quantityElement = document.querySelector(`.quantity[data-item-id="${itemId}"]`);
            if (quantityElement) {
                quantityElement.textContent = quantity;
            }
        });

        // Aktualizuj sumę zamówienia
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
