  document.addEventListener("DOMContentLoaded", function() {
    setTimeout(function() {
      let flashMessages = document.querySelectorAll(".alert, .notice");
      flashMessages.forEach(function(flash) {
        flash.remove();
      });
    }, 3000);
  });
  