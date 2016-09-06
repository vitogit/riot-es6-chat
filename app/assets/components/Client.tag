<Client class="client">
  <Screen />
  <Command />

  <script>
    import { colorize, escapeHTML } from '../js/lib/html-helpers'
    import { boldRed, boldGreen, gray } from '../js/lib/colors'
    import { clientConfig } from './ClientConfig.js'

    const self = this

    this.space = false
    this.loggedIn = false
    this.playing = false

    // client config
    // todo: maybe move this to the command component
    this.maxLines = clientConfig.read('maxLines') || 1000
    this.maxHistory = clientConfig.read('maxHistory') || 1000
    this.echo = clientConfig.read('echo') || false
    this.space = clientConfig.read('space') || false
    //todo: implement watching the client config changes


    this.on('mount', function() {
      this.addLine(gray('Connecting...'))
    })

    this.addLine = (line) => {
      riot.messageStore.trigger('add_message', {author: '', text: colorize(escapeHTML(line))})
    }

    //socket event handlers
    this.onConnect = () => {
      self.addLine(boldGreen('Connected!'))
    }

    this.onConnecting = () => {
      self.addLine(gray('Connecting...'))
    }

    this.onDisconnect = () => {
      self.addLine(boldRed('Disconnected from server.'));
      self.setPrompt('');
      self.inputCallback = null;
      self.loggedIn(false);
      self.playing(false);
    }

    this.onConnectFailed = () => {
      self.addLine(boldRed('Connection to server failed.'))
    }

    this.onError = () => {
      self.addLine(boldRed('An unknown error occurred.'));
    }

    this.onReconnectFailed = () => {
      self.addLine(boldRed('Unable to reconnect to server.'));
    }

    this.onReconnect = () => {
    }

    this.onReconnecting = () => {
    }

    this.onOutput = (msg) => {
      if (msg && msg.toString) {
        self.addLine(msg.toString());
        if (self.space) { self.addLine(' '); }
      }
    }

    this.onSetPrompt = (str) => {
      riot.messageStore.trigger('set_prompt', str)
    }

    this.onRequestInput = (inputs, fn) => {
      riot.messageStore.trigger('input_from_user', {}, inputs, fn)
    }

    this.onLogin = () => {
      this.loggedIn = true;
    }

    this.onLogout = () => {
      this.loggedIn = false;
    }

    this.onPlaying = () => {
      this.playing = true;
    }

    this.onQuit = () => {
      this.playing = false ;
    }

    // Socket event handlers
    riot.socket.on('connect', self.onConnect.bind(this));
    riot.socket.on('connecting', self.onConnecting.bind(this));
    riot.socket.on('disconnect', self.onDisconnect.bind(this));
    riot.socket.on('connect_failed', self.onConnectFailed.bind(this));
    riot.socket.on('error', self.onError.bind(this));
    riot.socket.on('reconnect_failed', self.onReconnectFailed.bind(this));
    riot.socket.on('reconnect', self.onReconnect.bind(this));
    riot.socket.on('reconnecting', self.onReconnecting.bind(this));
    riot.socket.on('output', self.onOutput.bind(this));
    riot.socket.on('set-prompt', self.onSetPrompt.bind(this));
    riot.socket.on('request-input', self.onRequestInput.bind(this));
    // riot.socket.on('edit-verb', self.onEditVerb.bind(this));
    // riot.socket.on('edit-function', self.onEditFunction.bind(this));
    riot.socket.on('login', self.onLogin.bind(this));
    riot.socket.on('logout', self.onLogout.bind(this));
    riot.socket.on('playing', self.onPlaying.bind(this));
    riot.socket.on('quit', self.onQuit.bind(this));


  </script>
</Client>
