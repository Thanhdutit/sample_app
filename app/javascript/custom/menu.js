document.addEventListener("turbo:load", function() {
  let account = document.querySelector(".dropdown-toggle");

  if (account) { // Check if account element exists
    account.addEventListener("click", function(event) {
      event.preventDefault();
      let menu = document.querySelector(".dropdown-menu");
      if (menu) { // Check if menu element exists
        menu.classList.toggle("active");
      }
    });
  }
});
