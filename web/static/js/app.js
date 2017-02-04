// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
//
import Vue from "vue/dist/vue.common";

//show group
new Vue({
  el: "#show-user",
  data: {
    show_token: false,
    token_message: 'Show token'
  },
  methods:{
    showToken: function (e) {
      this.show_token = !this.show_token;
      if(this.show_token)
        this.token_message = "Hide token";
      else
        this.token_message = "Show token";
    }
  }
});

new Vue({
  el: "#vk_app-list",
  data: {
    show_token: false,
    token_message: 'Show key'
  },
  methods:{
    showToken: function (e) {
      this.show_token = !this.show_token;
      if(this.show_token)
        this.token_message = "Hide key";
      else
        this.token_message = "Show key";
    }
  }
});

