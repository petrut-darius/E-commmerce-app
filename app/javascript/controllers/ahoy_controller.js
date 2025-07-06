import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (window.ahoy) {
      ahoy.trackView();
    }
  }
}