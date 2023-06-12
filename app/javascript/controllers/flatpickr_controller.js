import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"

export default class extends Controller {

  static targets = ["flatpicker"]

  connect() {
    flatpickr(this.element, {
      locale: French,
      mode: "range",
      dateFormat: "d/m/Y",
      onChange: this.onChange.bind(this),
    });
  }

  onChange(selectedDates, dateStr, instance) {
    let [start_date, end_date] = dateStr.split(" au ");
    this.element.querySelector('input[name="festival_filter[start_time]"]').value = start_date || "";
    this.element.querySelector('input[name="festival_filter[end_time]"]').value = end_date || "";
    this.flatpickerTarget.value = dateStr;
  }
}
