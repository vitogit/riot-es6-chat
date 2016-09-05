<Client class="client">
  <Screen />
  <Command />

  <script>

    riot.socket.on('disconnect', function(data) {  
        console.log('discon___'+data);
    });

  </script>
</Client>
