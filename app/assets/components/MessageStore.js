'use strict'

import riot from 'riot'
export default class  MessageStore {
  constructor() {
    riot.observable(this); // Riot provides our event emitter.
  }
}
