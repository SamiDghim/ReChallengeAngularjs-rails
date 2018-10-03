@app.service 'userService', ($http,$location)->

  this.getLoggedUserInfo = ->
    $http.get('/GetLoggedUserInfo').then (res) ->
      console.log 'res user json', res
      if res.data.data?
        $location.path '/login' if res.data.data.role is "admin"
        return res.data.data
      else
        $location.path '/login'
        return null
    ,(error)->
      console.log error,' User is not logged in'
      $location.path '/login'
      return error

  this.getUserConges = (id) ->
    $http.get('/conge/GetUserConges/'+id).then (conges) ->
      console.log 'conges user ', conges
      return conges.data.data
    ,(error)->
      console.log error,'Conges User not found'
      return error

  this.sendDemande = (id,d1,d2,motifAb) ->
    Indata = {'user_id':id,'date_debut':d2,'date_fin':d1, 'motifAb':motifAb}
    console.log 'INDATA',Indata
    headers = {'Content-Type': 'application/json'}
    $http.post('/conge/saveConge',Indata,headers).then (response) ->
      return response.data.data
    ,(error) ->
      console.log error, 'can not save demand !.'
      return error

  this.getModel = (id) ->
    $http.get('/conge/getUserCongeModel/'+id).then (model) ->
      console.log 'model user ', model
      return model.data.data
    ,(error)->
      console.log error,'model User not found'
      return error
  return this
