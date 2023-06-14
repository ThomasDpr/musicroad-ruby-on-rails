import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = [ "flash" ]

  connect() {
    console.log("hello");
  }

  quit() {
    console.log("quit");
    console.log(this.flashTarget);
    this.flashTarget.classList.remove("fadein");
    this.flashTarget.classList.add("fadeout");
    setTimeout(() => {
      this.element.remove();
    }, 300);
  }
}
