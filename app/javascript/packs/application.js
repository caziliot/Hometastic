// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
// import "jquery-ui-bundle";
//= require jquery
//= require jquery_ujs
//= require_tree .

// Internal imports, e.g:
import { rangePlugin } from "flatpickr/dist/plugins/rangePlugin";
import { initFlatpickr } from "../plugins/flatpickr";
import { initFlatRange } from "../plugins/flatpickr";
import { initChatRoomCable } from "../channels/chat_room_channel";
import { initAutocomplete } from "../plugins/init_autocomplete";

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  initFlatpickr();
<<<<<<< HEAD
  initFlatpickr("#month_start", {
    altInput: true
  });
=======
>>>>>>> 5d4e68b9ba0e49c71c6a8623d65ef5fa829e822e
  initFlatRange();
  initChatRoomCable();
  initAutocomplete();
});
