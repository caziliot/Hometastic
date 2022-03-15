import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["month"]
  static classes = ['hide']

  connect() {
    console.log("connected");
  }
}
