class OrderPage {
    constructor(orderId) {
        this.orderId = orderId;
        this.total = 0;
        this.orderItems = {};
        this.inactivityTimer = null;
        this.inactivityTimeout = 10 * 60 * 1000; // 10 minutes
        this.availabilityCheckInterval = 30 * 1000; // 30 seconds
        this.initializeEventListeners();
        this.startMonitoring();
        
        // Set initial active category
        const firstCategoryButton = document.querySelector('.order-category-button');
        if (firstCategoryButton) {
            this.handleCategoryClick(firstCategoryButton);
        }

        // Initialize language handlers
        this.initializeLanguageHandlers();

        this.loadImages();
    }

    updateTotal(newTotal) {
        this.total = newTotal;
        const totalButton = document.getElementById('proceed-to-summary');
        const template = totalButton.dataset.template;
        totalButton.textContent = template.replace('0.00', this.total.toFixed(2));
    }

    async updateQuantity(itemId, change) {
        try {
            // Sprawdź aktualną ilość i dostępność przed zmianą
            const quantityElement = document.querySelector(`.quantity[data-item-id="${itemId}"]`);
            const currentQuantity = parseInt(quantityElement.textContent) || 0;
            
            // Pobierz dostępną ilość
            const queryParams = `item_ids=${itemId}`;
            const availabilityData = await fetchWithErrorHandling(`/get_available_quantities?${queryParams}`);
            const availableQuantity = availabilityData.available_items?.[0]?.available_quantity || 0;

            // Sprawdź czy zmiana nie przekroczy limitu
            if (change > 0 && currentQuantity + change > availableQuantity) {
                showFlashMessage(_('Maximum available quantity reached'), 'warning');
                return;
            }

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
                const newQuantity = Math.max(0, currentQuantity + change);
                quantityElement.textContent = newQuantity;

                // Update total
                const orderTotal = await fetchWithErrorHandling(`/get_order_total?order_id=${this.orderId}`);
                this.updateTotal(orderTotal.total);

                // Check availability
                await this.checkItemAvailability();
            }
        } catch (error) {
            console.error('Error updating quantity:', error);
        }
    }

    async checkItemAvailability() {
        try {
            // Get all visible items regardless of category
            const visibleItems = document.querySelectorAll('.order-product-item');
            const itemIds = Array.from(visibleItems).map(item => item.dataset.itemId);

            // Only make the request if we have items to check
            if (itemIds.length > 0) {
                const queryParams = itemIds.map(id => `item_ids=${id}`).join('&');
                const data = await fetchWithErrorHandling(`/get_available_quantities?${queryParams}`);
                if (data.available_items) {
                    this.updateProductAvailability(data.available_items);
                }
            }
        } catch (error) {
            console.error('Error checking availability:', error);
        }
    }

    updateProductAvailability(availableItems) {
        // Create a map of available quantities for easier lookup
        const availabilityMap = new Map(
            availableItems.map(item => [item.item_id.toString(), parseInt(item.available_quantity)])
        );

        // Update each product individually
        document.querySelectorAll('.order-product-item').forEach(productItem => {
            const itemId = productItem.dataset.itemId;
            const availableQuantity = availabilityMap.get(itemId) || 0;
            
            const increaseButton = productItem.querySelector('.increase-quantity');
            const decreaseButton = productItem.querySelector('.decrease-quantity');
            const quantityDisplay = productItem.querySelector('.quantity');
            
            if (!quantityDisplay) return;
            
            const currentQuantity = parseInt(quantityDisplay.textContent) || 0;

            // Aktualizacja przycisku zmniejszania ilości (-)
            if (decreaseButton) {
                const canDecrease = currentQuantity > 0;
                decreaseButton.disabled = !canDecrease;
                decreaseButton.classList.toggle('active', canDecrease);
                decreaseButton.classList.toggle('disabled', !canDecrease);
            }

            // Aktualizacja przycisku zwiększania ilości (+)
            if (increaseButton) {
                const canIncrease = currentQuantity < availableQuantity;
                increaseButton.disabled = !canIncrease;
                increaseButton.classList.toggle('active', canIncrease);
                increaseButton.classList.toggle('disabled', !canIncrease);
            }
        });
    }

    handleCategoryClick(button) {
        // Remove active class from all buttons
        document.querySelectorAll('.order-category-button').forEach(btn => {
            btn.classList.remove('active');
        });
        
        // Add active class to clicked button
        button.classList.add('active');
        
        const selectedCategory = button.dataset.category;
        const productList = document.querySelector('.order-product-list');
        
        console.log('Selected category:', selectedCategory);
        
        // Add transition class for smooth animation
        productList.classList.add('changing');
        
        setTimeout(() => {
            if (selectedCategory === 'sum') {
                // Handle summary view
                this.showOrderSummary();
            } else {
                // Show only products from selected category
                const products = document.querySelectorAll('.order-product-item');
                console.log('Total products found:', products.length);
                
                products.forEach(item => {
                    const itemCategory = item.dataset.category;
                    console.log('Product:', {
                        id: item.dataset.itemId,
                        category: itemCategory,
                        selectedCategory: selectedCategory,
                        matches: itemCategory === selectedCategory,
                        element: item,
                        display: item.style.display
                    });
                    
                    // Convert both to lowercase for comparison
                    const normalizedItemCategory = itemCategory.toLowerCase();
                    const normalizedSelectedCategory = selectedCategory.toLowerCase();
                    
                    if (normalizedItemCategory === normalizedSelectedCategory) {
                        console.log('Showing product:', item.dataset.itemId);
                        item.style.display = 'flex';
                    } else {
                        console.log('Hiding product:', item.dataset.itemId);
                        item.style.display = 'none';
                    }
                });
            }
            
            // Remove transition class
            productList.classList.remove('changing');
        }, 300);
    }

    // Add new method to handle summary view
    async showOrderSummary() {
        try {
            const response = await fetchWithErrorHandling(`/get_order_summary?order_id=${this.orderId}`);
            if (response.summary) {
                const productList = document.querySelector('.order-product-list');
                
                // Create summary HTML
                let summaryHTML = '<div class="order-summary">';
                summaryHTML += '<h2>' + _('Order Summary') + '</h2>';
                
                // Group items by category
                const itemsByCategory = {};
                response.summary.items.forEach(item => {
                    if (!itemsByCategory[item.category]) {
                        itemsByCategory[item.category] = [];
                    }
                    itemsByCategory[item.category].push(item);
                });
                
                // Display items grouped by category
                for (const [category, items] of Object.entries(itemsByCategory)) {
                    summaryHTML += `<div class="summary-category">`;
                    summaryHTML += `<h3>${_(category)}</h3>`;
                    for (const item of items) {
                        const quantity = document.querySelector(`.quantity[data-item-id="${item.item_id}"]`)?.textContent || '0';
                        if (parseInt(quantity) > 0) {
                            const imageUrl = `${window.SUPABASE_URL}/storage/v1/object/public/images/${item.image}`;
                            
                            summaryHTML += `
                                <div class="summary-item">
                                    <img src="${imageUrl}" alt="${item['name_' + document.documentElement.lang]}" class="summary-item-image" onerror="this.onerror=null; this.src='/static/images/placeholder.png';">
                                    <div class="summary-item-details">
                                        <h4>${item['name_' + document.documentElement.lang]}</h4>
                                        <p>${_('Quantity')}: ${quantity}</p>
                                        <p>${_('Price')}: ${(item.price * parseInt(quantity)).toFixed(2)}</p>
                                    </div>
                                </div>
                            `;
                        }
                    }
                    summaryHTML += `</div>`;
                }
                
                summaryHTML += `
                    <div class="summary-total">
                        <h3>${_('Total')}: ${this.total.toFixed(2)}</h3>
                    </div>
                </div>`;
                
                // Update the product list with summary
                productList.innerHTML = summaryHTML;
            }
        } catch (error) {
            console.error('Error showing order summary:', error);
            showFlashMessage(_('Failed to load order summary'), 'error');
        }
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
        document.querySelectorAll('.order-category-button').forEach(button => {
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

    async loadImages() {
        const images = document.querySelectorAll('.order-product-image');
        for (const img of images) {
            const filename = img.dataset.imageFilename;
            try {
                const response = await fetch(`/get_public_image_url?filename=${filename}`);
                const data = await response.json();
                if (data.url) {
                    img.src = data.url;
                }
            } catch (error) {
                console.error('Error loading image:', error);
                img.src = img.getAttribute('onerror').match(/this\.src='([^']+)'/)[1];
            }
        }
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
