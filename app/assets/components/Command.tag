
<Command class="command">

  <form onsubmit = {sendCommand}>
    <span id='prompt'>{this.prompt}</span>
    <input autofocus id="messageText" autocomplete="off">
  </form>

  <script>
    // import { colorize, escapeHTML } from '../js/lib/html-helpers'
    // import { boldRed, boldGreen, gray } from '../js/lib/colors'

    this.author = opts.author || 'me'
    this.prompt = opts.prompt || '>'
    this.echo = false
    this.inputType = 'text'
    this.inputCallback = null;
    

    this.add = function(msg) {
      console.log("add________")
      
      // e.preventDefault()
      // var messageText = this.messageText.value.trim()
      // if (messageText && this.author) {
      //   console.log('thismess____'+messageText)
      //   riot.messageStore.trigger('add_message', {author: this.author, text: messageText})
      //   this.messageText.value = ''
      // }
      
      riot.messageStore.trigger('add_message', {author: this.author, text: msg})
      
    }

    this.sendCommand = (e) => {
      e.preventDefault()
      console.log('sendcommand____')
      
      var command = this.messageText.value.trim()
      if (!command) { return; }
      this.echoCommand(command)
      // this.addToHistory(command);
      // 
      if (this.handleClientCommand(command)) {
        // done, client handled command
      } else if (!riot.socket.connected) {
        this.add(boldRed('Not connected.'));
      } else if (this.inputCallback) {
        this.handleInputCallback(command);
      } else {
        riot.socket.emit('input', command);
      }

      this.messageText.value = ''

    } 

    //todo: move this functions to a lib.js ?
    this.echoCommand = (command) => {
      console.log('echocommand')
      if (!this.echo || this.inputType === 'password') { return; }
      this.add(this.composedPrompt(command));
      if (this.space) { this.add(' '); }
    }
  
    this.handleClientCommand = (command) => {
      switch (command) {
        case '.clear': this.lines([]); return true;
        case '.connect': this.reconnectSocket(); return true;
        case '.disconnect': this.disconnectSocket(); return true;
        // case '.echo on': this.echo(true); return true;
        // case '.echo off': this.echo(false); return true;
        // case '.space on': this.space(true); return true;
        // case '.space off': this.space(false); return true;
        // case '.new tab': this.parentViewModel.parentViewModel.newClientTab(); return true;
        // case '.close tab': this.parentViewModel.close(); return true;
        default: return false;
      }
    }
      
    // this.promptFormatted = (optionalStr = '') => {
    //   console.log('optionalStr__'+optionalStr)
    //   return colorize(escapeHTML(this.composedPrompt()));
    // }
    //
    
    //todo: not working properly
    this.composedPrompt = (optionalStr = '') => {
      console.log("composedPromp________")
      return `${this.promptStr} > ${optionalStr}`.trim();
    }

  </script>
</Command>
