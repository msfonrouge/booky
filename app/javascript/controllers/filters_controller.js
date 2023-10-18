import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {

  static targets = [ "form" ]

  submitForm() {
    this.formTarget.requestSubmit();
  }

  // Real-time search implementation?
  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit();
    }, 600);
  }
}
