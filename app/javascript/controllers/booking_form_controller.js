import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["form"];

    showForm(event) {
      console.log("===show form");
    // event.preventDefault();
    // this.formTarget.classList.toggle("hidden");
  }
}