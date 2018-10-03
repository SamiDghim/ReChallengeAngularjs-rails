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
  this.sendReject = (Indata) ->
    headers = {'Content-Type': 'application/json'}
    $http.post('/conge/RejectConge/',Indata,headers).then (response) ->
        angular.element('#exampleModal').modal('hide')
        return response.data
    ,(error) ->
        console.log error , 'Error reject demand'
        return error

  this.sendAccept = (id,user_id,db,df,solde) ->
    _MS_PER_DAY = 1000 * 60 * 60 * 24
    a=new Date(db)
    b=new Date(df)
    utc1 = Date.UTC(a.getFullYear(), a.getMonth(), a.getDate())
    utc2 = Date.UTC(b.getFullYear(), b.getMonth(), b.getDate())
    res = Math.floor((utc2 - utc1) / _MS_PER_DAY)
    resF = solde-res
    Indata = {id : id,etat :'Accepté',user_id : user_id,solde : resF}
    headers = {'Content-Type': 'application/json'}
    $http.post('/conge/AcceptConge/',Indata,headers).then (response) ->
        angular.element('#exampleModal').modal('hide')
        return response.data
    ,(error) ->
        console.log error , 'Error reject demand'
        return error

  return this
