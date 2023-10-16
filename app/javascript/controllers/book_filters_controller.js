import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-filters"
export default class extends Controller {

  static targets = [ "form" ]

  connect() {
    console.log("test");
  }

  submitForm() {
    console.log("test2")
    this.formTarget.requestSubmit();
    //clearTimeout(this.timeout);
    //this.timeout = setTimeout(() => {
    //  this.formTarget.requestSubmit();
    //}, 200);
  }
}
