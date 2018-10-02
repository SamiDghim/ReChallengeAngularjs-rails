@app.controller 'homeUserCtrl', ($scope,Auth,$location,$http,userService) ->
  $scope.showMsgValid = false
  $scope.showMsgError = false

  userService.getLoggedUserInfo().then (res)->
    $scope.user =  res
    userService.getUserConges($scope.user.id).then (res) ->
      $scope.conges = res
    .catch (e) ->
      console.log 'reject conges for user' ,e
  .catch (e) ->
    console.log 'reject logged user' ,e


  $scope.logout = ->
    Auth.logout().then (oldUser) ->
      $location.path '/login'
    ,(error) ->
      console.log error

  $scope.sendDemande = ->
    d1 = new Date($scope.dateF)
    d1.setMinutes(d1.getMinutes() + 60)
    d2 = new Date($scope.dateD)
    d2.setMinutes(d2.getMinutes() + 60)
    userService.sendDemande($scope.user.id,d1,d2,$scope.motifAb).then (res)->
      $scope.dateF = ''
      $scope.dateD = ''
      $scope.motifAb = ''
      $scope.showMsgValid = true
      userService.getUserConges($scope.user.id).then (resp) ->
        $scope.conges = resp
      .catch (e) ->
        console.log 'reject conges for user' ,e
    ,(error) ->
      console.log 'error send demand',error
      $scope.showMsgError = true

  $scope.sendModel = (id) ->
    $http.get('/conge/getUserCongeModel/'+id).then (model) ->
      console.log 'model user ', model
      $scope.myModel = model.data.data
    ,(error)->
      console.log error,'model User not found'
