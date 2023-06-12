import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      locale: French,
      mode: "range",
      dateFormat: "Y-m-d",
      onChange: this.onChange.bind(this)
    });
  }

  onChange(selectedDates, dateStr, instance) {
    let [start_date, end_date] = dateStr.split(" to ");
    this.element.querySelector('input[name="festival_filter[start_time]"]').value = start_date || "";
    this.element.querySelector('input[name="festival_filter[end_time]"]').value = end_date || "";
  }
}
