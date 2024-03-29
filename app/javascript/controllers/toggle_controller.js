import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]
  static values = { class: String }
  toogle() {
    this.itemTarget.classList.toggle(this.classValue)
  }
}