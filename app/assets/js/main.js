'use strict';

import riot from 'riot'
import MessageStore from '../components/MessageStore.js';

import '../components/Client.tag'
import '../components/Command.tag'
import '../components/Screen.tag'
import '../components/RawHtml.tag'

import '../js/lib/linkify'
import '../js/lib/linkify-html'

riot.messageStore = new MessageStore()

var SERVER_URI = 'http://localhost:8888';
var io = require("socket.io-client");



//If connected to server then add global access to riot.socket and mount tags
document.addEventListener('DOMContentLoaded', function() {
  if (typeof io === 'undefined') {
    alert('Unable to connect to ' + SERVER_URI);
  } else {
    riot.socket = io.connect(SERVER_URI);
    riot.mount('*')
  }
});
