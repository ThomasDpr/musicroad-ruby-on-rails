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

    this.element.insertAdjacentHTML( "beforebegin" , `
    <div class="flash notice fadein" data-controller="flash" data-flash-target="flash">
      Ajouté à vos favoris ✅<button data-action="click->flash#quit"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg></button>
    </div>
    `);
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

    this.element.insertAdjacentHTML( "beforebegin" , `
    <div class="flash notice fadein" data-controller="flash" data-flash-target="flash">
      Supprimé de vos favoris ❌<button data-action="click->flash#quit"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg></button>
    </div>
    `);
  }
}
