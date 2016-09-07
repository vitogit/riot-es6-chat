<Autocomplete>
  <input name="acinput" onkeyup="{ complete }" search={search}/>
  <div class="results">
    <ol show={ filtered.length }>
      <li each={ c, i in filtered } onclick="{ parent.selected }" class="{ active: parent.active==i}">{ c }</li>
    </ol>
  </div>

  <style scoped>
    /* Search Box */

    .search {
      position: fixed;
      top: 20vh;
      left: 50%;
      z-index: 9999;
      box-sizing: border-box;
      width: 680px;
      margin-left: -340px;
      border: 1px solid #2c2e30;
    }

    .search .searchbox {
      background-color: black;
      padding: 0.5em;
    }

    .search .searchbox input {
      font-family: 'Fira Mono', monospace;
      font-size: 18pt;
      color: white;
      background-color: black;
      border: none;
      width: 100%;
    }

    .search .searchbox input:focus {
      outline: none;
    }

    .search .results {
      border-top: 1px solid #2c2e30;
      max-height: 300px;
      overflow: auto;
    }

    .search .results ol {
      margin: 0;
      padding: 0;
    }

    .search .results ol li {
      list-style-type: none;
      padding: 1em 0.5em;
      color: #545657;
      background-color: black;
    }

    .search .results ol li.active {
      color: white;
      background-color: #141516;
    }
  </style>

  <script>
      // this.choices = opts.choices.map(option => option.searchStr) //todo: pass this as an option
      this.choices = []
      this.min = opts.min || 2
      this.filtered  = []
      this.active = -1
      this.mode = opts.mode || 'start'
      this.search = opts.search
        
      var self = this

      this.complete = (e) => {
          this.choices = this.search(e.target.value)

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
