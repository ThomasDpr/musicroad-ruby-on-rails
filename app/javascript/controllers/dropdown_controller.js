import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = [ "menu", "svg" ]

  connect() {
  }

  toggle() {
    this.svgTarget.classList.toggle("rotate");
    this.menuTarget.classList.toggle("hidden");
  }
}
