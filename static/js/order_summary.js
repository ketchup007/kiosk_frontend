let orderItems = [];
let suggestedProducts = [];

function loadOrderSummary() {
    fetch('/get_order_summary')
        .then(response => response.json())
        .then(data => {
            orderItems = data.order_items;
            suggestedProducts = data.suggested_products;
            displayOrderItems();
            displaySuggestedProducts();
            updateTotalAmount();
        });
}

function displayOrderItems() {
    const orderItemsContainer = document.getElementById('order-items');
    orderItemsContainer.innerHTML = '';
    
    orderItems.forEach(item => {
        const itemElement = document.createElement('div');
        itemElement.className = 'order-item';
        itemElement.innerHTML = `
            <img src="${item.image}" alt="${item.name}">
            <div class="item-details">
                <h3>${item.name}</h3>
                <p>${item.price} PLN</p>
            </div>
            <div class="item-quantity">
                <button onclick="changeQuantity(${item.id}, -1)">-</button>
                <span id="quantity-${item.id}">${item.quantity}</span>
                <button onclick="changeQuantity(${item.id}, 1)">+</button>
            </div>
        `;
        orderItemsContainer.appendChild(itemElement);
    });
}

function displaySuggestedProducts() {
    const suggestedProductsContainer = document.getElementById('suggested-products');
    suggestedProductsContainer.innerHTML = '<h2>Sugerowane produkty</h2>';
    
    suggestedProducts.forEach(product => {
        const productElement = document.createElement('div');
        productElement.className = 'suggested-product';
        productElement.innerHTML = `
            <img src="${product.image}" alt="${product.name}">
            <div class="item-details">
                <h3>${product.name}</h3>
                <p>${product.price} PLN</p>
            </div>
            <button onclick="addToOrder(${product.id})">Dodaj</button>
        `;
        suggestedProductsContainer.appendChild(productElement);
    });
}

function changeQuantity(itemId, change) {
    const item = orderItems.find(i => i.id === itemId);
    if (item) {
        item.quantity += change;
        if (item.quantity < 0) item.quantity = 0;
        document.getElementById(`quantity-${itemId}`).textContent = item.quantity;
        updateTotalAmount();
        updateOrder();
    }
}

function addToOrder(productId) {
    const product = suggestedProducts.find(p => p.id === productId);
    if (product) {
        const existingItem = orderItems.find(i => i.id === productId);
        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            orderItems.push({...product, quantity: 1});
        }
        displayOrderItems();
        updateTotalAmount();
        updateOrder();
    }
}

function updateTotalAmount() {
    const total = orderItems.reduce((sum, item) => sum + item.price * item.quantity, 0);
    document.getElementById('total-amount').textContent = total.toFixed(2);
}

function updateOrder() {
    fetch('/update_order', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(orderItems),
    })
    .then(response => response.json())
    .then(data => {
        if (!data.success) {
            alert(data.message);
        }
    });
}

function cancelOrder() {
    fetch('/cancel_order', { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                window.location.href = '/';
            } else {
                alert(data.message);
            }
        });
}

function proceedToPayment() {
    fetch('/proceed_to_payment', { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                window.location.href = '/payment';
            } else {
                alert(data.message);
            }
        });
}

document.addEventListener('DOMContentLoaded', function() {
    loadOrderSummary();
    
    document.getElementById('cancel-order').addEventListener('click', cancelOrder);
    document.getElementById('proceed-to-payment').addEventListener('click', proceedToPayment);
});

function changeLanguage(lang) {
    fetch(`/set_language/${lang}`, { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload();
            }
        });
}