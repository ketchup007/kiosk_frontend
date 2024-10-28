function changeLanguage(lang) {
    fetch('/set_language/' + lang, {
       method: 'POST',
    })
    .then(response => response.json())
    .then(data => {
       if (data.success) {
          location.reload();
       }
    });
 }

// Dodaj to do istniejącego pliku main.js
document.addEventListener('DOMContentLoaded', function() {
    const flashMessages = document.querySelectorAll('.flash-message');
    
    flashMessages.forEach(message => {
        // Usuń wiadomość po 5 sekundach
        setTimeout(() => {
            message.remove();
        }, 5000);

        // Opcjonalnie: dodaj przycisk zamknięcia
        const closeButton = document.createElement('button');
        closeButton.innerHTML = '×';
        closeButton.style.cssText = `
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
            padding: 0 5px;
        `;
        
        closeButton.onclick = () => message.remove();
        message.style.position = 'relative';
        message.appendChild(closeButton);
    });
});
