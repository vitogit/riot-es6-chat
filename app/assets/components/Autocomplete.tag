<Autocomplete>
  <input name="acinput" onkeyup="{ complete }" />
  <ul show={ filtered.length }>
      <li each={ c, i in filtered } onclick="{ parent.selected }" class="{ active: parent.active==i}">{ c }</li>
  </ul>

  <script>
        console.log("1111choices_______"+this.choices)
  
      this.choices = opts.choices.map(option => option.searchStr) //todo: pass this as an option
      this.min = opts.min || 5
      this.filtered  = []
      this.active = -1
      this.mode = opts.mode || 'start'
      this.onkeyup = opts.onkeyup
      var self = this

      this.complete = (e) => {
        console.log("complete________"+e.target.value)
        console.log("choices_______"+this.choices)
          if(e.target.value.length < this.min) {
              this.filtered = []
              this.active = -1
              return
          }

          this.filtered = this.choices.filter(function(c) {
              return c.match(self.re(e))
          })

          if(e.which == 40 && this.filtered.length) { // down
              this.active = Math.min(this.active+1, this.filtered.length-1)
              return
          }

          if(e.which == 38 && this.filtered.length) { // up
              this.active = Math.max(this.active-1, 0)
              return
          }

          if(e.which == 13) { // enter
              this.filtered.length && this.selection(this.filtered[this.active])
          }

          if(e.which == 27) { // escape
              this.selection('')
          }
      }

      this.re = (e) => {
          return this.mode=='start' ?  RegExp('^'+e.target.value,'i') : RegExp(e.target.value,'i')
      }

      this.selected = (s) => {
          this.selection(s.item.c)
      }

      this.selection = (txt) => {
          this.acinput.value=''
          this.active = -1
          this.filtered = []
          this.trigger('selected', txt)
      }
  </script>
</Autocomplete>
