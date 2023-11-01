import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static Values = {
    content: String
  }

  connect() {
    this.originalText = this.element.textContent
  }
  copy () {
    navigator.clipboard.writeText(this.contentValue).then(
      () => {
        this.element.textContent = "Copied!" /* clipboard successfully set */
        setTimeout(() => {
            this.element.textContent =  this.originalText
        }, 1000);
      },
      () => {
        /* clipboard write failed */
      },
    );
    
  }
}
