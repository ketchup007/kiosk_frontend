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