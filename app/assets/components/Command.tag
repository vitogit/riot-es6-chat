
<Command class="command">

  <form onsubmit={add}>
    <span id='prompt'>{this.prompt}</span>
    <input autofocus="true" id="messageText" autocomplete="off">
  </form>

  <script>
    // import { colorize, escapeHTML } from '../js/lib/html-helpers'
    // import { boldRed, boldGreen, gray } from '../js/lib/colors'

    this.author = opts.author || 'me'
    this.prompt = opts.prompt || '>'

    this.add = function(e) {
      e.preventDefault()
      var messageText = this.messageText.value.trim()
      if (messageText && this.author) {
        console.log('thismess____'+messageText)
        riot.messageStore.trigger('add_message', {author: this.author, text: messageText})
        this.messageText.value = ''
      }
    }

    // this.promptFormatted = (optionalStr = '') => {
    //   console.log('optionalStr__'+optionalStr)
    //   return colorize(escapeHTML(this.composedPrompt()));
    // }
    //
    // this.composedPrompt = (optionalStr = '') => {
    //   return `${this.promptStr} > ${optionalStr}`.trim();
    // }

  </script>
</Command>
