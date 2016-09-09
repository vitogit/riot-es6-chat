<SearchModal class="search">

  <div class='searchbox'>
    <Autocomplete  search={this.search}/>
  </div>
  
  <script>
    this.results = []
    this.selectedIndex = 0
    this.selectionDirection = 0
    
    this.on('autocomplete_selected', function (txt) {  //autocomplete said that something was selected
      console.log("triggered________"+txt)
    })

    //todo: not the best approach sending as a callback function to autocomplete
    this.search = (str) => {
      const self = this
      riot.socket.emit('search', str, results => {
          self.results = results.map(result => result.searchStr)
      })
      return self.results
    }

    this.close = () => {
      console.log('close modal____')
      //this.root.style.display = 'none'
    }
    
    this.openActiveResult = () => {
      console.log('openActiveResult___')
    }    

    this.computeActiveResult = () => {
      if (this.results.length > 0) {
        this.results.forEach(result => { result.active = false });
        this.results[this.selectedIndex].active = true
        //todo: better way to implement this, to scrolldown?
        // this.scrollActiveResultIntoView()
      }
      this.update()
      return null;
    }

    // this.scrollActiveResultIntoView = () => {
    //   const el = document.querySelector('.search .results li.active');
    //   const container = document.querySelector('.search .results');
    //   if (el && !isElementVisibleIn(el, container)) {
    //     el.scrollIntoView(this.selectionDirection() === -1);
    //   }
    // }
  
    this.keyHandler = event => {
      const key = typeof event.which === 'undefined' ? event.keyCode : event.which
      const selectedIndex = this.selectedIndex
      switch (key) {
        case 13: { // enter key
          this.openActiveResult()
          this.close()
          return false
        }
        case 27: { // esc key
          this.close()
          return false
        }
        case 38: { // up key
          if (selectedIndex > 0) {
            this.selectedIndex--
          } else {
            this.selectedIndex = this.results.length - 1
          }
          this.selectionDirection = -1
          this.computeActiveResult()            
          return false;
        }
        case 40: { // down key
          if (selectedIndex < this.results.length - 1) {
            this.selectedIndex++
          } else {
            this.selectedIndex = 0
          }
          this.selectionDirection = 1
          this.computeActiveResult()  
          return false;
        }
        default: {
          this.search(event)
          return true;
        }
      }
    }  
  </script>

</SearchModal>

<SearchResult>
  <li class='{active}'>
    {this.name}
  </li>
  
  <script>
    this.name = opts.name
    this.active = opts.active
    // this.objectid = opts.objectid
    // 
    // this.openEditor = (socket, tabsViewModel) => {
    //   const params = { objectId: this.objectId, name: this.data.function };
    //   socket.emit('get-function', params, data => {
    //     tabsViewModel.newEditFunctionTab(socket, data);
    //   });
    // }    
  </script>
</SearchResult>
