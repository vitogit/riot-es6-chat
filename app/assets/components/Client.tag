<Client class="client">
  <Screen />
  <Command />

  <script>
    import { colorize, escapeHTML } from '../js/lib/html-helpers'
    import { boldRed, boldGreen, gray } from '../js/lib/colors'
    
    const self = this

    this.space =  false
    
    this.addLine = (line) => {
      riot.messageStore.trigger('add_message', {author: '', text: colorize(escapeHTML(line))})
    }
    
    // Socket event handlers to implement
    riot.socket.on('connect', function() {  
      self.addLine(boldGreen('Connected!'))
    });
    
    riot.socket.on('connecting', function() {  
      self.addLine(gray('Connecting...'))
    });
    
    riot.socket.on('disconnect', function() {  
      self.addLine(boldRed('Disconnected from server.'));
      self.setPrompt('');
      self.inputCallback = null;
      self.loggedIn(false);
      self.playing(false);
    }); 
    
    riot.socket.on('connect_failed', function() {  
      self.addLine(boldRed('Connection to server failed.'))
    });
    
    riot.socket.on('error', function() {  
      self.addLine(boldRed('An unknown error occurred.'));
    });
    
    riot.socket.on('output', function(msg) {  
      if (msg && msg.toString) {
        self.addLine(msg.toString());
        if (self.space) { self.addLine(' '); }
      }
    });       
            
    riot.socket.on('set-prompt', function(str) {  
      self.setPrompt(str);
    });


  // Socket event handlers to implement


  // onEditVerb(data) {
  //   this.parentViewModel.parentViewModel.newEditVerbTab(this.socket, data);
  // }
  // 
  // onEditFunction(data) {
  //   this.parentViewModel.parentViewModel.newEditFunctionTab(this.socket, data);
  // }
  // 
  // onLogin() {
  //   this.loggedIn(true);
  // }
  // 
  // onLogout() {
  //   this.loggedIn(false);
  // }
  // 
  // onPlaying() {
  //   this.playing(true);
  // }
  // 
  // onQuit() {
  //   this.playing(false);
  // }
  // 
  // onRequestInput(inputs, fn) {
  //   const promptWas = this.promptStr();
  //   this.getInputFromUser({}, inputs, formData => {
  //     this.setPrompt(promptWas, 'text');
  //     fn(formData);
  //   });
  // }
  </script>
</Client>
