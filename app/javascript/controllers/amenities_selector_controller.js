import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["a0", "a1", "a2"]

  connect() {
    console.log(this.a0Target);
  }
}
