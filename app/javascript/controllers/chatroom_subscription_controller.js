import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"
export default class extends Controller {

  static values = { chatroomId: Number, currentUserId: Number }
  static targets = ["messages"]
  connect() {
    console.log('La fonction connect fonctionne')
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) },
      )
  }
  #insertMessageAndScrollDown(data) {
      const currentUserIsSender = this.currentUserIdValue === data.sender_id;
      const messageElement = this.#buildMessageElement(currentUserIsSender, data.message);
      this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
      this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
        <div class="message">
          <div class="${currentUserIsSender ? 'send' : 'recived'}">
            ${message}
          </div>
        </div>
    `
  }
  resetForm(event){
  event.target.reset()
  }
  disconnect() {
    this.channel.unsubscribe();
  }
}
