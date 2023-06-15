import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    console.log("Connected!")
    this.inputTarget.addEventListener('change', () => this.preview())
  }

  preview() {
    const file = this.inputTarget.files[0]
    if (file) {
      const reader = new FileReader()
      reader.onloadend = (event) => {
        this.previewTarget.style.backgroundImage = `url(${event.target.result})`
        this.previewTarget.dataset.uploadAvatarHasPreview = true
      }
      reader.readAsDataURL(file)
    } else {
      this.clearPreview()
    }
  }

  clearPreview() {
    this.previewTarget.style.backgroundImage = ""
    this.previewTarget.dataset.uploadAvatarHasPreview = false
  }
}
