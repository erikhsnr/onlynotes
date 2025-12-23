# Pin npm packages by running ./bin/importmap

pin "application", to: "application.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@rails/activestorage", to: "activestorage.js"
pin "local-time", to:
"https://ga.jpsm.io/npm:local-time@2.1.0/app/assets/javascripts/local-time.js"
