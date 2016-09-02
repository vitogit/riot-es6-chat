
<Command class="command">
 
  <form onsubmit={add}>
    <!-- <input type="text" placeholder="Say something..."name="input_text"/>
    <input type="submit" value="Post" />
     -->
    <span class='prompt'>></span>
    <input autofocus="true" id="promptStr" autocomplete="off">
    
  </form>

  <script>
    import { colorize, escapeHTML } from '../js/lib/html-helpers'
    import { boldRed, boldGreen, gray } from '../js/lib/colors'
    this.author = 'me'
    this.add = function(e) {
      console.log('_____')
      e.preventDefault()
      var author =  opts.author || this.author
      var promptStr = this.promptFormatted(this.prompt)
      if (promptStr && author) {
        riot.messageStore.trigger('add_message', {author: author, text: promptStr})
        this.promptStr.value = ''
      }
    }    

    this.promptFormatted = (optionalStr = '') => {
      console.log('optionalStr__'+optionalStr)
      return colorize(escapeHTML(this.composedPrompt()));
    }
    
    this.composedPrompt = (optionalStr = '') => {
      return `${this.promptStr} > ${optionalStr}`.trim();
    }

  </script>
</Command>
