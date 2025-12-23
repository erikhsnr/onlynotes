// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"
import "@rails/activestorage"

//import LocalTime from "local-time"
//LocalTime.start()

//= require rails-ujs
//= require turbolinks
//= require_tree .




document.addEventListener("turbo:load", function() {
    const toggleButton = document.getElementById('toggle-section-button');
    const expandableSection = document.getElementById('expandable-section');

    if (toggleButton && expandableSection) {
        // Set initial display style if not already set
        if (expandableSection.style.display === '') {
            expandableSection.style.display = 'none';
        }

        toggleButton.addEventListener('click', function() {
            if (expandableSection.style.display === 'none') {
                expandableSection.style.display = 'block';
                toggleButton.textContent = 'Wieder ausblenden';
            } else {
                expandableSection.style.display = 'none';
                toggleButton.textContent = 'Weitere Allgemeine Notizen';
            }
        });
    }
});


/*
document.addEventListener("turbolinks:load", () => {
    document.querySelectorAll(".like-button").forEach(button => {
        button.addEventListener("click", event => {
            event.preventDefault();
            const url = button.getAttribute("href");
            if (scrollTop) {
                document.scrollingElement.scrollTo(0, scrollTop);
            }
            fetch(url, {
                method: button.dataset.method,
                headers: {
                    "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content"),
                    "Accept": "application/json"
                }
            }).then(response => response.json()).then(data => {
                if (data.status === 'liked') {
                    button.textContent = 'Unlike';
                    button.dataset.method = 'delete';
                } else if (data.status === 'unliked') {
                    button.textContent = 'Like';
                    button.dataset.method = 'post';
                }
            });
            scrollTop = 0;
        });
    });
});
*/
