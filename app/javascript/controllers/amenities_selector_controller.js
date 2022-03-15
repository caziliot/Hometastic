import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["amenity", "button", "form"]
  static classes = ['amenity', 'selected']

  connect() {
    console.log(this.amenityTarget);
  }

  select(event) {
    event.currentTarget.classList.toggle(this.amenityClass)
    event.currentTarget.classList.toggle(this.selectedClass)
  }

  update(event) {
    event.preventDefault();
    let url = this.formTarget.action;
    console.log(url);
    let dat = [];
    console.log(this.buttonTarget)
    this.amenityTargets.forEach(amenity => {
      if (amenity.classList.contains(this.selectedClass)) {
        console.log(amenity.id);
        dat.push(new Number(amenity.id));

      }
    });
    var data = new FormData();
    data.append("json", JSON.stringify(dat));
    console.log(data);
    fetch(url, {
      method: 'POST',
      headers: { 'Accept': 'text/plain' },
      body: data
    }).then(response => response.text())
      .then((data) => {
        console.log(data);
        window.alert("Amenities edited successfully");
      })
  }
}
