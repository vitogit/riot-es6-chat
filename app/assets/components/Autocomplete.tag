<Autocomplete>
  <input id="inputField" onkeyup="{keyHandler}" search={search}/>
  <div class="results">
    <ol show={ filtered.length }>
      <li each={ choice, index in filtered } onclick="{ parent.selected }" class="{ active: parent.active==index}">{ choice }</li>
    </ol>
  </div>

  <style scoped>

   input {
      font-family: 'Fira Mono', monospace;
      font-size: 18pt;
      color: white;
      background-color: black;
      border: none;
      width: 100%;
      border: 1px solid;
    }

    input:focus {
      outline: none;
    }

    .results {
      border-top: 1px solid #2c2e30;
      max-height: 300px;
      overflow: auto;
    }

    .results ol {
      margin: 0;
      padding: 0;
    }

    .results ol li {
      list-style-type: none;
      padding: 1em 0.5em;
      color: #545657;
      background-color: black;
    }

    .results ol li.active {
      color: white;
      background-color: #141516;
    }

  </style>

  <script>
      this.choices = []
      this.min = opts.min || 2
      this.filtered  = []
      this.active = -1
      this.mode = opts.mode || 'start'
      this.search = opts.search
        
      var self = this

      this.keyHandler = (event) => {
        const key = typeof event.which === 'undefined' ? event.keyCode : event.which
        let inputValue = event.target.value

        const upKey = key === 38
        const downKey = key === 40
        const enterKey = key === 13
        const escKey = key === 27
    
        if(inputValue.length < this.min) {
          this.filtered = []
          this.active = -1
          return
        }

        if(downKey && this.filtered.length) { // down
          this.active = Math.min(this.active+1, this.filtered.length-1)
          return
        }

        if(upKey && this.filtered.length) { // up
          this.active = Math.max(this.active-1, 0)
          return
        }

        if(escKey) { // escape
          this.selection('')
          return
        }

        if(enterKey) { // enter
          let selectedChoice = this.filtered[this.active]
          this.selection(selectedChoice)
          return
        }
        
        this.choices = this.search(inputValue)
        
        this.filtered = this.choices.filter(function(choice) {
          return choice.match(self.regExp(inputValue))
        })
      }

      this.regExp = (inputValue) => {
        return this.mode=='start' ?  RegExp('^'+inputValue,'i') : RegExp(inputValue,'i')
      }

      this.selected = (selectedChoice) => {
        this.selection(selectedChoice.item.choice)
      }

      this.selection = (txt) => {
        this.inputField.value = ''
        this.active = -1
        this.filtered = []
        this.parent.trigger('autocomplete_selected', txt) //send trigger to the parent
      }
    //based on http://richardbondi.net/riot/ examples  
  </script>
</Autocomplete>
