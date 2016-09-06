'use strict'
//todo: move this from components to another place?
class ClientConfig {
  constructor() {
  }

  read(key) {
    return window.localStorage ? JSON.parse(window.localStorage.getItem(key)) : null;
  }

  write(key, value) {
    if (window.localStorage) {
      window.localStorage.setItem(key, JSON.stringify(value));
    }
  }
}

export let clientConfig = new ClientConfig();
