<app>
  <p>{ message }</p>
  <time>{ time }</time>
  <script>
    import moment from 'moment'

    this.message = 'hi there'
    this.time = `Today is ${ moment().format('LL') }`
  </script>
</app>