// Zmienna globalna dla interwału
let apsUpdateInterval;

// Dodaj funkcję changeLanguage na początku pliku
function changeLanguage(lang) {
    fetch('/set_language/' + lang, {
        method: 'POST',
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            console.log('Language changed to: ' + lang); // Dodaj debugowanie
            location.reload();
        }
    });
}

function updatePageTranslations(translations) {
    // Aktualizacja tekstu czasu oczekiwania
    const estimatedTimeDiv = document.querySelector('.estimated-time');
    if (estimatedTimeDiv) {
        const waitingTime = document.getElementById('waiting-time').textContent;
        estimatedTimeDiv.innerHTML = `${translations.estimated_waiting_time}<span id="waiting-time">${waitingTime}</span> ${translations.min}`;
    }

    // Aktualizacja tekstu przycisku
    const startOrderBtn = document.getElementById('start-order-btn');
    if (startOrderBtn) {
        // Aktualizacja atrybutów data-
        startOrderBtn.dataset.defaultText = translations.touch_screen;
        startOrderBtn.dataset.inactiveText = translations.kiosk_unavailable;
        startOrderBtn.dataset.malfunctionText = translations.kiosk_malfunction;
        startOrderBtn.dataset.duringDeliveryText = translations.kiosk_restocking;
        startOrderBtn.dataset.defaultErrorText = translations.kiosk_not_available;

        // Aktualizacja wyświetlanego tekstu
        if (!startOrderBtn.disabled) {
            startOrderBtn.textContent = translations.touch_screen;
        }
    }
}

// Funkcja inicjalizująca stronę główną
function initializeHomePage() {
    function updateApsState() {
        fetch('/get_aps_state')
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                const startOrderBtn = document.getElementById('start-order-btn');
                
                if (!startOrderBtn) {
                    return;
                }

                if (data.state !== 'active') {
                    startOrderBtn.disabled = true;
                    startOrderBtn.textContent = getApsStateMessage(data.state);
                } else {
                    startOrderBtn.disabled = false;
                    startOrderBtn.textContent = startOrderBtn.dataset.defaultText;
                }
            })
            .catch(error => {
                console.error('Error in updateApsState:', error);
            });
    }

    function getApsStateMessage(state) {
        const startOrderBtn = document.getElementById('start-order-btn');
        const messages = {
            'inactive': startOrderBtn.dataset.inactiveText,
            'malfunction': startOrderBtn.dataset.malfunctionText,
            'during_delivery': startOrderBtn.dataset.duringDeliveryText,
            'default': startOrderBtn.dataset.defaultErrorText
        };
        return messages[state.toLowerCase()] || messages.default;
    }

    function showError(message) {
        const errorDiv = document.createElement('div');
        errorDiv.className = 'error-message';
        errorDiv.textContent = message;
        document.body.appendChild(errorDiv);
        setTimeout(() => {
            errorDiv.remove();
        }, 10000);
    }

    // Initialize order button click handler
    const startOrderBtn = document.getElementById('start-order-btn');
    if (startOrderBtn) {
        startOrderBtn.addEventListener('click', function() {
            fetch('/create_order', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({}),
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if (data.order_id) {
                        window.location.href = `/order/${data.order_id}`;
                    }
                } else {
                    // Wyświetl komunikat błędu
                    showFlashMessage(data.error || 'Failed to create order', 'error');
                }
            })
            .catch(error => {
                showFlashMessage("Wystąpił błąd. Prosimy spróbować ponownie.", 'error');
            });
        });
    }

    // Inicjalne sprawdzenie stanu APS
    updateApsState();

    // Ustawiamy interwał i zapisujemy jego ID
    apsUpdateInterval = setInterval(updateApsState, 10000);

    // Initial waiting time check and interval
    updateWaitingTime();
    setInterval(updateWaitingTime, 10000);

    // Initial product check and interval
    checkProductAvailability();
    setInterval(checkProductAvailability, 10000);
}

function updateWaitingTime() {
    fetch('/calculate_estimated_waiting_time')
        .then(response => response.json())
        .then(data => {
            const waitingTimeSpan = document.getElementById('waiting-time');
            if (waitingTimeSpan) {
                const waitingTime = parseInt(data.waiting_time) || 0;
                waitingTimeSpan.textContent = waitingTime.toString();
            }
        })
        .catch(error => {
            const waitingTimeSpan = document.getElementById('waiting-time');
            if (waitingTimeSpan) {
                waitingTimeSpan.textContent = '0';
            }
        });
}

function checkProductAvailability() {
    fetch('/get_product_availability')
        .then(response => response.json())
        .then(data => {
            const startOrderBtn = document.getElementById('start-order-btn');
            if (!data.snacks_available && !data.drinks_available && !data.coffee_available) {
                startOrderBtn.disabled = true;
                startOrderBtn.textContent = "Przepraszamy, obecnie wszystkie produkty są niedostępne. Prosimy spróbować później.";
            }
        })
        .catch(error => {
            console.error('Error checking product availability:', error);
        });
}

// Dodaj na początku pliku
const messageQueue = [];
let isProcessingQueue = false;

// Zmienna globalna dla timeoutów
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
        
        closeButton.onclick = (e) => {
            e.stopPropagation();
            clearTimeout(currentMessageTimeout);
            clearTimeout(currentFadeTimeout);
            removeMessage(messageDiv);
        };

        messageDiv.style.position = 'relative';
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
    const { message, category } = messageQueue[0];

    const flashContainer = document.querySelector('.flash-messages');
    if (!flashContainer) {
        const newFlashContainer = document.createElement('div');
        newFlashContainer.className = 'flash-messages';
        document.body.appendChild(newFlashContainer);
    }

    const messageDiv = document.createElement('div');
    messageDiv.className = `flash-message ${category}`;
    messageDiv.textContent = message;

    // Dodaj przycisk zamknięcia
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
    
    closeButton.onclick = () => {
        messageDiv.remove();
        messageQueue.shift(); // Usuń wiadomość z kolejki
        processMessageQueue(); // Przetwórz następną wiadomość
    };

    messageDiv.style.position = 'relative';
    messageDiv.appendChild(closeButton);

    const container = document.querySelector('.flash-messages');
    container.appendChild(messageDiv);

    // Animacja wejścia
    messageDiv.style.animation = 'slideIn 0.5s ease-out';
    messageDiv.style.opacity = '1';

    // Automatyczne usuwanie po dłuższym czasie (np. 8 sekund)
    setTimeout(() => {
        // Animacja wyjścia
        messageDiv.style.animation = 'fadeOut 0.5s ease-in';
        setTimeout(() => {
            messageDiv.remove();
            messageQueue.shift(); // Usuń wiadomość z kolejki
            processMessageQueue(); // Przetwórz następną wiadomość
        }, 500);
    }, 8000);
}

// Nasłuchiwanie na załadowanie DOM
document.addEventListener('DOMContentLoaded', function() {
    initializeHomePage();
});

// Czyszczenie interwału przy opuszczaniu strony
window.addEventListener('beforeunload', function() {
    if (apsUpdateInterval) {
        clearInterval(apsUpdateInterval);
    }
});
