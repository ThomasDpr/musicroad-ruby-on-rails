import { Controller } from "@hotwired/stimulus"
import { left } from "@popperjs/core"

// Connects to data-controller="spotify-player"
export default class extends Controller {
  static targets = ["trackName", "trackImage", "progressBarFill"]

  connect() {
    this.index = 0;
    this.playlist = this.element.dataset.trackPreview.split(";");
    this.trackName = this.element.dataset.trackName.split(";");
    this.trackImage = this.element.dataset.trackImage.split(";");
    this.audio = new Audio(this.playlist[this.index]);

    setInterval(() => {
      const percentage = (this.audio.currentTime / this.audio.duration) * 100;
      this.progressBarFillTarget.style.width = `${percentage}%`;
    }, 100);
  }

  play_pause() {
    if (this.audio.paused) {
      this.audio.play();
    } else {
      this.audio.pause();
    }
  }

  previous() {
    if (this.index === 0) {
      this.index = this.playlist.length - 1;
    } else {
      this.index = this.index - 1;
    }

    this.audio.src = this.playlist[this.index];
    this.audio.play();
    this.trackNameTarget.innerText = this.trackName[this.index];
    this.trackImageTarget.src = this.trackImage[this.index];
  }

  next() {
    if (this.index === this.playlist.length - 1) {
      this.index = 0;
    } else {
      this.index = this.index + 1;
    }

    this.audio.src = this.playlist[this.index];
    this.audio.play();
    this.trackNameTarget.innerText = this.trackName[this.index];
    this.trackImageTarget.src = this.trackImage[this.index];
  }
}
