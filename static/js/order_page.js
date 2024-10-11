let products = [];
let cart = {};

function loadProducts() {
    fetch('/get_products')
        .then(response => response.json())
        .then(data => {
            products = data;
            displayProducts(products);
        });
}

function displayProducts(productsToDisplay) {
    const productList = document.getElementById('product-list');
    productList.innerHTML = '';
    
    productsToDisplay.forEach(product => {
        const productElement = document.createElement('div');
        productElement.className = 'product-item';
        productElement.innerHTML = `
            <img src="${product.image}" alt="${product.name}">
            <h3>${product.name}</h3>
            <p>${product.description}</p>
            <p>Cena: ${product.price} PLN</p>
            <div class="quantity-control">
                <button onclick="changeQuantity(${product.id}, -1)">-</button>
                <span class="quantity" id="quantity-${product.id}">0</span>
                <button onclick="changeQuantity(${product.id}, 1)">+</button>
            </div>
        `;
        productList.appendChild(productElement);
    });
}

function filterProducts(category) {
    if (category === 'all') {
        displayProducts(products);
    } else {
        const filteredProducts = products.filter(product => product.category === category);
        displayProducts(filteredProducts);
    }
}

function changeQuantity(productId, change) {
    if (!cart[productId]) {
        cart[productId] = 0;
    }
    
    const newQuantity = cart[productId] + change;
    if (newQuantity >= 0) {
        cart[productId] = newQuantity;
        updateQuantityDisplay(productId);
        updateCartTotal();
    }
}

function updateQuantityDisplay(productId) {
    const quantityElement = document.getElementById(`quantity-${productId}`);
    quantityElement.textContent = cart[productId] || 0;
}

function updateCartTotal() {
    let total = 0;
    for (const [productId, quantity] of Object.entries(cart)) {
        const product = products.find(p => p.id === parseInt(productId));
        if (product) {
            total += product.price * quantity;
        }
    }
    document.getElementById('cart-total').textContent = `Suma: ${total.toFixed(2)} PLN`;
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

function checkout() {
    fetch('/update_order', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(cart),
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            window.location.href = '/order/summary';
        } else {
            alert(data.message);
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    loadProducts();
    
    document.getElementById('cancel-order').addEventListener('click', cancelOrder);
    document.getElementById('checkout').addEventListener('click', checkout);
});

// Funkcja do zmiany języka (taka sama jak w start_screen.js)
function changeLanguage(lang) {
    fetch(`/set_language/${lang}`, { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload();
            }
        });
}