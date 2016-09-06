
<Command class="command">

  <form onsubmit = {sendCommand}>
    <span type={this.prompt.type} id="prompt"> {this.prompt.label}</span>
    <input autofocus id="messageText" autocomplete="off" onkeydown={historyHandler} type={inputType}>
  </form>

  <script>
    import { colorize, escapeHTML } from '../js/lib/html-helpers'
    // import { boldRed, boldGreen, gray } from '../js/lib/colors'
    import { history } from './History'
    
    const self = this
    this.author = opts.author || 'me'
    this.prompt = {label: '>', type: 'text'}
    this.promptStr = opts.prompt || '>'
    this.echo = false
    this.inputType = 'text' //todo: this needs to change to password sometime
    this.inputCallback = null;
    
    //todo: should refactor interaction between fn and getinputfromuser
    riot.messageStore.on('input_from_user', function(data, inputs, fn) {
      const promptWas = self.prompt
      self.getInputFromUser({}, inputs, formData => {
        self.setPrompt(promptWas, 'text');
        fn(formData);
      })
      //restore original prompt
      self.prompt = promptWas
    })
    
    riot.messageStore.on('set_prompt', function(str) {
      self.setPrompt(str)
    })    
    
    this.add = function(msg) {
      riot.messageStore.trigger('add_message', {author: this.author, text: msg})
    }

    this.sendCommand = (e) => {
      e.preventDefault()
      
      var command = this.messageText.value.trim()

      if (!command) { return; }
      this.echoCommand(command)
      history.add(command, this.inputType)
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

    this.historyHandler = (event) => {
      const key = typeof event.which === 'undefined' ? event.keyCode : event.which
      if (history.size === 0) { return true; }
      switch (key) {
        case 38: { // up key
          if (history.position < history.size- 1) {
            history.position++;
          }
          this.messageText.value = history.get(history.position)
          this.update()
          return false;
        }
        case 40: { // down key
          if (history.position > -1) {
            history.position--;
          }
          if (history.position >= 0) {
            this.messageText.value = history.get(history.position)
          } else {
            this.messageText.value = ''
          }
          this.update()
          
          break;
        }
        default: {
          break;
        }
      }
      return true;
    }
    
    //todo: move this functions to a lib.js ?
    this.echoCommand = (command) => {
      if (!this.echo || this.inputType === 'password') { return; }
      this.add(this.composedPrompt(command));
      if (this.space) { this.add(' '); }
    }
  
    this.handleClientCommand = (command) => {
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

    this.handleInputCallback = command => {
      const callback = this.inputCallback;
      this.inputCallback = null;
      callback(command);
    }
  
    this.getInputFromUser = (data, inputs, done) => {
      if (inputs.length === 0) {done(data); return;}

      const [input, ...restInputs] = inputs;
      this.setPrompt(input.label || 'input', input.type || 'text');
      data[input.name || 'input'] = input;
      
      
      this.inputCallback = userInput => {
        data[input.name || 'input'] = userInput;
        this.getInputFromUser(data, restInputs, done);
      };
    }
  
    this.composedPrompt = (promptStr, optionalStr = '') => {
      return `${promptStr} > ${optionalStr}`.trim();
    }

    this.setPrompt = (label, type) => {
      this.prompt.label = label + '>' //todo: use composedPrompt(label)
      this.prompt.type = type || 'text'
      this.update()

    }
  </script>
</Command>
