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
            fetch('/api/create_new_order', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({}),
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.redirect) {
                    window.location.href = data.redirect;
                } else if (data.error) {
                    showError(data.error);
                }
            })
            .catch(error => {
                showError("Wystąpił błąd. Prosimy spróbować ponownie.");
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
