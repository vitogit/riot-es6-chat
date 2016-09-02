'use strict'

import riot from 'riot'
export default class  MessageStore {
  constructor() {
    riot.observable(this); // Riot provides our event emitter.
  }
}
// var riot = require('riot');
// function MessageStore() {
//     riot.observable(this); // Riot provides our event emitter.
// }
// 
// module.exports = MessageStore;
