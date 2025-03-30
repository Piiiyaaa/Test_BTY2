import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "counter"]
  
  connect() {
    this.updateCounter()
  }
  
  updateCounter() {
    const currentLength = this.fieldTarget.value.length
    this.counterTarget.textContent = currentLength
  }
}
