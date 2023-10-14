import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
      static targets = [ "date_of_publication" ]
      connect() {
        flatpickr(this.date_of_publication, {});
    };
};
