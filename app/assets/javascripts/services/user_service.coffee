@app.service 'userService', ($http,$q)->

  this.getUserConges = (id) ->
    deffered = $q.defer()
    $http.get('/conge/GetUserConges/'+id).then (conges) ->
      res = conges.data.data
      deffered.resolve(res)
    ,(error)->
      console.log error,'Conges User not found'
      deffered.reject(error)
    return deffered.promise

  this.sendDemande = (id,d1,d2,motifAb) ->
    deffered = $q.defer()
    Indata = {'user_id':id,'date_debut':d2,'date_fin':d1, 'motifAb':motifAb}
    headers = {'Content-Type': 'application/json'}
    $http.post('/conge/saveConge',Indata,headers).then (response) ->
      res = response.data.data
      deffered.resolve(res)
    ,(error) ->
      console.log error, 'can not save demand !.'
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
