'use strict'

class History {
  constructor(maxSize) {
    this.list = [];
    this.position = -1
    this.maxSize = maxSize || 1000
    this.size = 0
  }

  add(command, inputType) {
    if (inputType === 'password') { return; }
    this.list.unshift(command);
    this.size++
    if (this.size > this.maxSize) { 
      this.truncate()
    }
    this.position = -1;
  }
  
  get(position) {
    return this.list[position]
  }

  truncate() {
    this.list = this.list.slice(0, this.maxSize)
  }
}

export let history = new History();
