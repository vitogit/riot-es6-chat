<Screen class="screen">
  <div class="messageList"  >
    <Message author='{message.author}' text='{message.text}' each={message in messages}/>
  </div>

  <script>
    this.messages = opts.messages || []
    var self = this
    riot.messageStore.on('add_message', function(message) {
      self.messages.push(message)
      self.update()
      // this.lines.push(colorize(escapeHTML(line)));
      // this.scrollToBottom();      
    })
  </script>
</Screen>

<Message>
  <div class="message">
    <span class="messageAuthor"> {opts.author}</span><br/>
    <span> <RawHtml content={opts.text}/></RawHtml> </span>
  </div>

  <style>
    .messageAuthor {
      font-weight: bold;
    }
    .message {
      margin: 10px 0px;
    }
  </style>
</Message>
