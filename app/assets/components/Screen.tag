<Screen class="screen">
  <div class="messageList" each={message in messages} >
    <Message author='{message.author}' text='{message.text}'/>
  </div>

  <script>
    this.messages = opts.messages || []
    var self = this
    riot.messageStore.on('add_message', function(message) {
      self.messages.push(message)
      self.update()
    })      
  </script>
</MessageList>

<Message>
  <div class="message">
    <span class="messageAuthor"> {opts.author}</span><br/>
    <span>{opts.text} </span>
  </div>
  
  <style>
    .messageAuthor {
      font-weight: bold;
    }
    .message {
      margin: 10px 0px;
    }
  </style>  
</Screen>
