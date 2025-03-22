import { Controller } from "@hotwired/stimulus"
 
 export default class extends Controller {
   static targets = ["name", "output", "menu"]
 
   connect() {
     console.log("hamburger controller connected!")
     if (this.hasMenuTarget) {
       this.menuTarget.classList.add("hidden")
     }
   }
   
   toggleMenu() {
     this.menuTarget.classList.toggle("hidden")
   }
 }