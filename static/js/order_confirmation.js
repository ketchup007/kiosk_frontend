function loadConfirmationDetails() {
    fetch('/get_confirmation_details')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('order-number').textContent = data.kds_order_number;
                document.getElementById('estimated-time').textContent = data.estimated_time;
                document.getElementById('pickup-number').textContent = data.pickup_number;
            } else {
                alert(data.message);
            }
        });
}

function returnToMain() {
    fetch('/finish_order', { method: 'POST' })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                window.location.href = '/';
            } else {
                alert(data.message);
            }
        });
}

document.addEventListener('DOMContentLoaded', function() {
    loadConfirmationDetails();
    
    document.getElementById('return-to-main').addEventListener('click', returnToMain);
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