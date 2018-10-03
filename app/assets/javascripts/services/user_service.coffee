@app.service 'userService', ($http,$location)->

  this.getUserConges = (id) ->
    $http.get('/conge/GetUserConges/'+id).then (conges) ->
      return conges.data.data
    ,(error)->
      console.log error,'Conges User not found'
      return error

  this.sendDemande = (id,d1,d2,motifAb) ->
    Indata = {'user_id':id,'date_debut':d2,'date_fin':d1, 'motifAb':motifAb}
    headers = {'Content-Type': 'application/json'}
    $http.post('/conge/saveConge',Indata,headers).then (response) ->
      return response.data.data
    ,(error) ->
      console.log error, 'can not save demand !.'
      return error

  this.getModel = (id) ->
    $http.get('/conge/getUserCongeModel/'+id).then (model) ->
      return model.data.data
    ,(error)->
      console.log error,'model User not found'
      return error
  return this
