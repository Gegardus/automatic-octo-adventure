import "../../assets/stylesheets/application.css"

import "@hotwired/turbo-rails"
import "@rails/actiontext"
import "trix"
import 'swiper/css/bundle'
import "preline";

const importAll = (r) => r.keys().forEach(r)

importAll(require.context('../', false, /\.js$/))
importAll(require.context('../controllers', false, /\.js$/))

const renderEvents = ['turbo:load', 'turbo:render', 'turbo:frame-render']

renderEvents.forEach((event) => {
  document.addEventListener(event, HSAccordion.autoInit)
  document.addEventListener(event, HSSelect.autoInit)
});
