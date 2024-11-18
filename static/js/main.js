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

// Globalne zmienne dla kolejki komunikatów
const messageQueue = [];
let isProcessingQueue = false;
let currentMessageTimeout = null;
let currentFadeTimeout = null;

function showFlashMessage(message, category) {
    // Wyczyść wszystkie istniejące timeouty
    if (currentMessageTimeout) {
        clearTimeout(currentMessageTimeout);
    }
    if (currentFadeTimeout) {
        clearTimeout(currentFadeTimeout);
    }

    // Funkcja do płynnego usuwania komunikatu
    function removeMessage(messageDiv) {
        messageDiv.style.animation = 'fadeOut 0.3s ease-in forwards';
        setTimeout(() => messageDiv.remove(), 300);
    }

    // Usuń wszystkie istniejące komunikaty z animacją
    const existingMessages = document.querySelectorAll('.flash-message');
    existingMessages.forEach(removeMessage);

    // Poczekaj na zakończenie animacji usuwania
    setTimeout(() => {
        // Upewnij się, że kontener istnieje
        let flashContainer = document.querySelector('.flash-messages');
        if (!flashContainer) {
            flashContainer = document.createElement('div');
            flashContainer.className = 'flash-messages';
            document.body.appendChild(flashContainer);
        } else {
            // Wyczyść kontener
            flashContainer.innerHTML = '';
        }

        // Stwórz nowy komunikat
        const messageDiv = document.createElement('div');
        messageDiv.className = `flash-message ${category}`;
        messageDiv.textContent = message;

        // Dodaj przycisk zamknięcia
        const closeButton = document.createElement('button');
        closeButton.innerHTML = '×';
        closeButton.className = 'close-button';
        
        closeButton.onclick = (e) => {
            e.stopPropagation();
            clearTimeout(currentMessageTimeout);
            clearTimeout(currentFadeTimeout);
            removeMessage(messageDiv);
        };

        messageDiv.appendChild(closeButton);
        flashContainer.appendChild(messageDiv);

        // Animacja wejścia
        messageDiv.style.animation = 'slideIn 0.5s ease-out forwards';

        // Ustaw nowe timeouty dla automatycznego znikania
        currentMessageTimeout = setTimeout(() => {
            removeMessage(messageDiv);
        }, 8000);
    }, 300);
}

function processMessageQueue() {
    if (messageQueue.length === 0) {
        isProcessingQueue = false;
        return;
    }

    isProcessingQueue = true;
    const { message, category } = messageQueue.shift();
    showFlashMessage(message, category);

    // Kontynuuj przetwarzanie kolejki po określonym czasie
    setTimeout(processMessageQueue, 8500);
}

// Funkcja pomocnicza do obsługi błędów fetch
function handleFetchError(error, defaultMessage = null) {
    console.error('Fetch error:', error);
    // Używamy komunikatu błędu z serwera, jeśli jest dostępny
    if (error.message && error.message.startsWith('HTTP error')) {
        // Dla błędów HTTP czekamy na odpowiedź z serwera
        return;
    }
    showFlashMessage(error.message || defaultMessage || error, 'error');
}

// Funkcja pomocnicza do wykonywania zapytań fetch
async function fetchWithErrorHandling(url, options = {}) {
    try {
        const response = await fetch(url, options);
        const data = await response.json();
        
        if (!response.ok) {
            // Jeśli serwer zwrócił błąd, używamy przetłumaczonego komunikatu z serwera
            throw new Error(data.error || response.statusText);
        }
        
        // Jeśli jest komunikat o błędzie w danych, wyświetl go
        if (data.error) {
            showFlashMessage(data.error, 'error');
        }
        // Jeśli jest komunikat sukcesu, wyświetl go
        if (data.message) {
            showFlashMessage(data.message, 'success');
        }
        
        return data;
    } catch (error) {
        handleFetchError(error);
        throw error;
    }
}

// Dodaj style CSS do head dokumentu
document.head.insertAdjacentHTML('beforeend', `
    <style>
        .flash-messages {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            width: 80%;
            max-width: 600px;
        }

        .flash-message {
            padding: 15px 40px 15px 20px;
            margin-bottom: 10px;
            border-radius: 4px;
            color: white;
            position: relative;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .flash-message.error {
            background-color: #ff4444;
        }

        .flash-message.success {
            background-color: #00C851;
        }

        .flash-message.warning {
            background-color: #ffbb33;
        }

        .flash-message.info {
            background-color: #33b5e5;
        }

        .close-button {
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
        }

        @keyframes slideIn {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
            }
            to {
                opacity: 0;
            }
        }
    </style>
`);
