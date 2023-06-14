import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["action", "icon"]

  connect() {
  }

  liked(event) {
    event.preventDefault();
    fetch(this.actionTarget.action, {
      method: "POST",
      body: new FormData(this.actionTarget)
    });

    this.iconTarget.classList.add("liked");
    setTimeout(() => {
      this.iconTarget.classList.add("likedsvg");
    }, 100);
  }

  unliked(event) {
    event.preventDefault();
    fetch(this.actionTarget.action, {
      method: "DELETE",
      body: new FormData(this.actionTarget)
    });
    this.iconTarget.classList.add("liked");
    setTimeout(() => {
      this.iconTarget.classList.add("unlikedsvg");
    }, 100);
  }
}
