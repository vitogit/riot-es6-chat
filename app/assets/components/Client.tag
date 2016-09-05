<Client class="client">
  <Screen />
  <Command />

  <script>
    const SERVER_URI = 'http://localhost:8888'

    // exports global io
    document.write('<script src="' + SERVER_URI + '/socket.io/socket.io.js"><\/script>')
    document.addEventListener('DOMContentLoaded', function() {
      if (typeof io === 'undefined') {
        console.log('Unable to connect to ' + SERVER_URI);
      } else {
        console.log('connected to ' + SERVER_URI);
      }
    });
  </script>
</Client>
