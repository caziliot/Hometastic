import { Controller } from "stimulus"
import { initFlatpickr } from "../plugins/flatpickr";

export default class extends Controller {
  static targets = ["month", "form", "displayer", "input", "dates"]
  static classes = ['hide']

  connect() {
    console.log("connected");
  }

  display() {
    this.monthTarget.classList.toggle(this.hideClass);
    if (this.displayerTarget.textContent == 'Add available dates') {
      this.displayerTarget.textContent = 'Hide form';
    } else {
      this.displayerTarget.textContent = 'Add available dates';
    }
  }

  update(event) {
    event.preventDefault();
    let url = this.formTarget.action;
    if (this.inputTarget.value != "") {
      console.log(this.inputTarget.value);
    }

    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.formTarget)
    }).then(response => response.text())
      .then((data) => {
        if (data[1] == 'p'){
          this.datesTarget.insertAdjacentHTML('beforeend', data);}
        else {
          this.monthTarget.innerHTML = data;
          initFlatpickr();
        }
      })
  }
}
