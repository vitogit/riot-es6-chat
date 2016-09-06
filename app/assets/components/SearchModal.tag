<SearchModal class="search">
  <div class='searchbox'>
    <input id="searchStr" type='text' onKeyDown={search}>
  </div>
  <div class='results' if={this.results.length>0}
    <ol>
      <SearchResult name={result.searchStr} objectid={result.objectid} each={result in results}/>
    </ol>
  </div>
  
  <script>
    this.results = []
    this.selectedIndex = 0
    this.selectionDirection = 0
    
    this.search = (event) => {
      let str = this.searchStr.value
      riot.socket.emit('search', str, results => {
        this.selectedIndex = 0
        this.results = results
      });
      return true
    }
    
    this.close = () => {
      console.log('close modal____')
    }
    
    this.openActiveResult = () => {
      console.log('openActiveResult___')
    }    
      
    this.onKeyDown = event => {
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
          return false;
        }
        case 40: { // down key
          if (selectedIndex < this.results.length - 1) {
            this.selectedIndex++
          } else {
            this.selectedIndex = 0
          }
          this.selectionDirection = 1
          return false;
        }
        default: {
          return true;
        }
      }
    }  
  </script>

</SearchModal>

<SearchResult>
  <li class={this.active}>
    {this.name}
  </li>
  
  <script>
    this.name = opts.name
    this.active = false
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
