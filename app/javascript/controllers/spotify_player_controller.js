import { Controller } from "@hotwired/stimulus"
import { left } from "@popperjs/core"

export default class extends Controller {
  static targets = ["trackName", "trackImage", "progressBarFill", "player", "playing", "singleMusic"]

  connect() {
    this.index = 0;
    this.playlist = this.playerTarget.dataset.trackPreview.split(";");
    this.trackName = this.playerTarget.dataset.trackName.split(";");
    this.trackImage = this.playerTarget.dataset.trackImage.split(";");

    this.audio = new Audio(this.playlist[this.index]);

    this.singleMusicTargets[this.index].classList.add("opacity-1");

    setInterval(() => {
      const percentage = (this.audio.currentTime / this.audio.duration) * 100;
      this.progressBarFillTarget.style.width = `${percentage}%`;
    }, 100);
  }

  play_pause(event) {
    if (this.audio.paused) {
      this.#playMusic();
    } else {
      this.#pauseMusic();
    }

    this.#bumpPlayerIcon(event);
  }

  previous(event) {
    this.#hideicon()

    if (this.index === 0) {
      this.index = this.playlist.length - 1;
    } else {
      this.index --;
    }

    this.#showicon();
    this.#bumperImage();
    this.#playMusic();
    this.#bumpPlayerIcon(event);
  }

  next(event) {
    this.#hideicon()

    if (this.index === this.playlist.length - 1) {
      this.index = 0;
    } else {
      this.index ++;
    }

    this.#showicon();
    this.#bumperImage();
    this.#playMusic();
    this.#bumpPlayerIcon(event);
  }

  singleMusic(event) {
    if (parseInt(event.currentTarget.dataset.index, 10) === this.index && !this.audio.paused) {
      this.#pauseMusic();
    } else if (parseInt(event.currentTarget.dataset.index, 10) === this.index && this.audio.paused) {
      this.#playMusic();
    } else {
      this.#hideicon()
      this.index = parseInt(event.currentTarget.dataset.index, 10);
      this.#showicon();
      this.#bumperImage();
      this.#playMusic();
    }
  }

  #playMusic() {
    if (this.audio.src !== this.playlist[this.index] ) {
      this.audio.src = this.playlist[this.index];
    }
    this.audio.play();
    this.trackNameTarget.innerText = this.trackName[this.index];
    this.trackImageTarget.src = this.trackImage[this.index];
    this.playingTarget.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-pause"><rect x="6" y="4" width="4" height="16"></rect><rect x="14" y="4" width="4" height="16"></rect></svg>';
    this.#showicon();
  }

  #hideicon() {
    this.singleMusicTargets[this.index].innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-play"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>';
    this.singleMusicTargets[this.index].classList.remove("opacity-1");
  }

  #showicon() {
    this.singleMusicTargets[this.index].classList.add("opacity-1");
    this.singleMusicTargets[this.index].innerHTML = '<div class="music-wave"><div class="line"></div ><div class="line" ></div ><div class="line"></div ><div class="line"></div ><div class="line"></div ></div>';
  }

  #bumperImage() {
    this.trackImageTarget.classList.add("bump-animation");
    setTimeout(() => {
      this.trackImageTarget.classList.remove("bump-animation");
    }, 400);
  }

  #bumpPlayerIcon(event) {
    event.currentTarget.classList.add("bump-animation");
    const copyevent = event.currentTarget;

    setTimeout(() => {
      copyevent.classList.remove("bump-animation");
    }, 400);
  }

  #pauseMusic() {
    this.audio.pause();
    this.playingTarget.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0  24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-play"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>';
    this.singleMusicTargets[this.index].innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-play"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>';
  }
}
