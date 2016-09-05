
<Command class="command">

  <form onsubmit = {sendCommand}>
    <span id='prompt'>{this.prompt}</span>
    <input autofocus id="messageText" autocomplete="off">
  </form>

  <script>
    // import { colorize, escapeHTML } from '../js/lib/html-helpers'
    // import { boldRed, boldGreen, gray } from '../js/lib/colors'
    const self = this
    this.author = opts.author || 'me'
    this.prompt = opts.prompt || '>'
    this.echo = false
    this.inputType = 'text'
    this.inputCallback = null;
    
    riot.messageStore.on('input_from_user', function(data, inputs, done) {
      console.log('input_from_user____'+data)
      console.log('2input_from_user____'+inputs)
      console.log('3input_from_user____'+done)
      
      self.getInputFromUser(data, inputs, done)
    })
    
    this.add = function(msg) {
      console.log("add________")
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
        console.log('calling inputcallback')
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
      console.log('handleClientCommand____'+command)
      switch (command) {
        case '.clear': this.lines([]); return true;
        case '.connect': this.reconnectSocket(); return true;
        case '.disconnect': this.disconnectSocket(); return true;
        case '.echo on': this.echo(true); return true;
        case '.echo off': this.echo(false); return true;
        case '.space on': this.space(true); return true;
        case '.space off': this.space(false); return true;
        case '.new tab': this.parentViewModel.parentViewModel.newClientTab(); return true;
        case '.close tab': this.parentViewModel.close(); return true;
        default: return false;
      }
    }

    this.getInputFromUser = (data, inputs, done) => {
      console.log('1_____'+data)
      if (inputs.length === 0) { done(data); return; }
      console.log('2_____'+inputs)

      const [input, ...restInputs] = inputs;
      console.log('3_____'+input)

      this.setPrompt(input.label || 'input', input.type || 'text');
      console.log('3_____'+input)

      this.inputCallback = userInput => {
        data[input.name || 'input'] = userInput;
        this.getInputFromUser(data, restInputs, done);
      };
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

    this.setPrompt = (str, type) => {
      this.prompt = str;
      if (type) { this.inputType = type; }
    }
  </script>
</Command>
