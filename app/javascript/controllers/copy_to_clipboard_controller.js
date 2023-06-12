import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-to-clipboard"
export default class extends Controller {
  connect() {

  }

  copy() {
    const url = window.location.href
    navigator.clipboard.writeText(url);
    alert("Le lien du festival à bien été copié");
  }
}
