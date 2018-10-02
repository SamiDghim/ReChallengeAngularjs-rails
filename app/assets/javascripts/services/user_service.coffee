@app.service 'userService', ($http,$location,Auth)->

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
      return null

  this.getUserConges = (id) ->
    $http.get('/conge/GetUserConges/'+id).then (conges) ->
      console.log 'conges user ', conges
      return conges.data.data
    ,(error)->
      console.log error,'Conges User not found'
      return null

  this.sendDemande = (id,d1,d2,motifAb) ->
    Indata = {'user_id':id,'date_debut':d2,'date_fin':d1, 'motifAb':motifAb}
    console.log 'INDATA',Indata
    headers = {'Content-Type': 'application/json'}
    $http.post('/conge/saveConge',Indata,headers).then (response) ->
      return response.data.data
    ,(error) ->
      console.log error, 'can not save demand !.'
      return null


  return this
