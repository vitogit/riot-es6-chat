<Client>
  <Command />
  
  
  <p>{ message }</p>
  <time>{ time }</time>
  <script>
      console.log('client____')

  
    import moment from 'moment'

    this.message = 'Hola'
    this.time = `Today is ${ moment().format('LL') }`
  </script>
</Client>
