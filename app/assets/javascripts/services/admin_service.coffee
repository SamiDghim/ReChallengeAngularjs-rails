@app.service 'adminService', ($http,$location)->

  this.getAllDemandsNonT = ->
      $http.get('/conge/GetAllDemandsNonT').then (res) ->
               return res.data
          ,(error)->
              console.log error,'Users not found'
              return error

  this.getAllDemandsT = ->
      $http.get('/conge/GetAllDemandsT').then (res) ->
               return res.data
          ,(error)->
              console.log error,'Users not found'
              return error

  this.getAllUsers = ->
      $http.get('/GetAllUsers').then (users) ->
           return users.data
      ,(error)->
          console.log error,'Users not found'
          return error

  this.findByMc = (mc,Indata)->
    $http.get('/conge/search/'+mc,Indata).then (res) ->
      return res.data
    ,(error)->
      console.log error,'Search error'
      return error

  return this
