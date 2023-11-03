import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    content: String
  }

  connect() {
    this.iconElement = this.element.querySelector("svg");
    this.copiedMessageElement = this.element.querySelector(".copied_btn");
  }

  copy() {
    navigator.clipboard.writeText(this.contentValue).then(
      () => {
        // Clipboard write was successful
        this.iconElement.style.display = "none";
        this.copiedMessageElement.classList.remove("hidden");

        setTimeout(() => {
          // Restore the SVG icon and hide the "Copied" message after a delay
          this.iconElement.style.display = "inline";
          this.copiedMessageElement.classList.add("hidden");
        }, 1000);
      },
      () => {
        // Clipboard write failed
      }
    );
  }
}
