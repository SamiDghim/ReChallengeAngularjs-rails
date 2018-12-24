@app.service 'adminService', ($http,$q)->

  this.getAllDemandsNonT = ->
    deffered = $q.defer()
    $http.get('/conge/GetAllDemandsNonT').then (res) ->
      demandsNonT = res.data
      deffered.resolve(demandsNonT)
    ,(error)->
      console.log error,'Users not found'
      deffered.reject(error)
    return deffered.promise

  this.getAllDemandsT = ->
    deffered = $q.defer()
    $http.get('/conge/GetAllDemandsT').then (res) ->
      demandsT = res.data
      deffered.resolve(demandsT)
    ,(error)->
      console.log error,'Users not found'
      deffered.reject(error)
     return deffered.promise

  this.getAllUsers = ->
    deffered = $q.defer()
    $http.get('/GetAllUsers').then (users) ->
      users = users.data
      deffered.resolve(users)
    ,(error)->
      console.log error,'Users not found'
      deffered.reject(error)
     return deffered.promise

  this.editUser = (id,data)->
    deffered = $q.defer()
    $http.put('/updateUser/'+id,data).then (users) ->
      users = users.data
      deffered.resolve(users)
    ,(error)->
      console.log error,'User update failed'
      deffered.reject(error)
     return deffered.promise

  this.findByMc = (mc,Indata)->
    $http.get('/conge/search/'+mc,Indata).then (res) ->
      return res.data
    ,(error)->
      console.log error,'Search error'
      return error

  this.sendReject = (Indata) ->
    deffered = $q.defer()
    headers = {'Content-Type': 'application/json'}
    $http.post('/conge/RejectConge/',Indata,headers).then (response) ->
      angular.element('#exampleModal').modal('hide')
      res = response.data
      deffered.resolve(res)
    ,(error) ->
      console.log error , 'Error reject demand'
      deffered.reject(error)
    return deffered.promise

  this.sendAccept = (id,user_id,db,df,solde) ->
    deffered = $q.defer()
    _MS_PER_DAY = 1000 * 60 * 60 * 24
    a = moment(db)
    b = moment(df)
    utc1 = Date.UTC(a.year(), a.month(), a.date())
    utc2 = Date.UTC(b.year(), b.month(), b.date())
    res = Math.floor((utc2 - utc1) / _MS_PER_DAY)
    resF = solde-res
    Indata = {id : id,etat :'Accepté',user_id : user_id,solde : resF}
    headers = {'Content-Type': 'application/json'}
    $http.post('/conge/AcceptConge/',Indata,headers).then (response) ->
        angular.element('#exampleModal').modal('hide')
        res = response.data
        deffered.resolve(res)
    ,(error) ->
        console.log error , 'Error reject demand'
        deffered.reject(error)
     return deffered.promise
     
  this.getModel = (id) ->
    deffered = $q.defer()
    $http.get('/conge/getUserCongeModel/'+id).then (model) ->
      res = model.data.data
      deffered.resolve(res)
    ,(error)->
      console.log error,'model User not found'
      deffered.reject(error)
    return deffered.promise
  return this
