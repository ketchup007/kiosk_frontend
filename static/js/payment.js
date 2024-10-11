let selectedPaymentMethod = null;
let orderTotal = 0;

function loadOrderSummary() {
    fetch('/get_order_summary')
        .then(response => response.json())
        .then(data => {
            displayOrderSummary(data.order_items);
            orderTotal = data.order_total;
            document.getElementById('order-summary').innerHTML += `<h2>Suma: ${orderTotal.toFixed(2)} PLN</h2>`;
        });
}

function displayOrderSummary(orderItems) {
    const orderSummaryContainer = document.getElementById('order-summary');
    orderSummaryContainer.innerHTML = '<h2>Podsumowanie zamówienia</h2>';
    
    orderItems.forEach(item => {
        const itemElement = document.createElement('div');
        itemElement.className = 'order-item';
        itemElement.innerHTML = `
            <span>${item.name}</span>
            <span>${item.quantity} x ${item.price} PLN</span>
        `;
        orderSummaryContainer.appendChild(itemElement);
    });
}

function selectPaymentMethod(method) {
    selectedPaymentMethod = method;
    const paymentForm = document.getElementById('payment-form');
    paymentForm.innerHTML = '';

    switch(method) {
        case 'blik':
            paymentForm.innerHTML = `
                <input type="text" placeholder="Kod BLIK" maxlength="6">
            `;
            break;
        case 'card':
            paymentForm.innerHTML = `
                <input type="text" placeholder="Numer karty" maxlength="16">
                <input type="text" placeholder="Data ważności" maxlength="5">
                <input type="text" placeholder="CVV" maxlength="3">
            `;
            break;
        case 'apple_pay':
        case 'google_pay':
            paymentForm.innerHTML = `<p>Kliknij "Potwierdź płatność", aby kontynuować z ${method === 'apple_pay' ? 'Apple Pay' : 'Google Pay'}.</p>`;
            break;
    }
}

function cancelPayment() {
    fetch('/cancel_payment', { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                window.location.href = '/order/summary';
            } else {
                alert(data.message);
            }
        });
}

function confirmPayment() {
    if (!selectedPaymentMethod) {
        alert('Proszę wybrać metodę płatności.');
        return;
    }

    const paymentData = {
        method: selectedPaymentMethod,
        amount: orderTotal
    };

    // Dodaj dodatkowe dane w zależności od metody płatności
    switch(selectedPaymentMethod) {
        case 'blik':
            paymentData.blikCode = document.querySelector('input[placeholder="Kod BLIK"]').value;
            break;
        case 'card':
            paymentData.cardNumber = document.querySelector('input[placeholder="Numer karty"]').value;
            paymentData.expiryDate = document.querySelector('input[placeholder="Data ważności"]').value;
            paymentData.cvv = document.querySelector('input[placeholder="CVV"]').value;
            break;
    }

    fetch('/process_payment', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(paymentData),
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            window.location.href = '/order/confirmation';
        } else {
            alert(data.message);
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    loadOrderSummary();
    
    document.getElementById('cancel-payment').addEventListener('click', cancelPayment);
    document.getElementById('confirm-payment').addEventListener('click', confirmPayment);
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