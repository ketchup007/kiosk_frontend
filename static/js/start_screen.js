function changeLanguage(lang) {
    fetch('/set_language/' + lang, {
        method: 'POST',
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            console.log('Language changed to: ' + lang); // Dodaj tę linię
            location.reload();
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    const startButton = document.getElementById('start-button');
    if (startButton) {
        startButton.addEventListener('click', function() {
            fetch('/start_order', { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        window.location.href = '/order';
                    } else {
                        alert(data.message);
                    }
                });
        });
    }
});