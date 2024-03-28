import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form"];

    showForm(event) {
    event.preventDefault();
    this.formTarget.classList.toggle("hidden");
  }
}