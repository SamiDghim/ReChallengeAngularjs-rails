@app.controller 'homeUserCtrl', ($scope,Auth,$location,$http,userService,$window) ->
  $scope.showMsgValid = false
  $scope.showMsgError = false
  $scope.orderByField = 'dateD';
  $scope.set = (orderByField ) ->
    $scope.orderByField = orderByField
  $scope.reverseSort = false;
  $scope.showEmailError = false
  $scope.showPasswordError = false

  $scope.user = JSON.parse($window.localStorage.getItem("currentUser"))
  if $scope.user?
    $location.path '/login' if $scope.user.role isnt "user"
    userService.getUserConges($scope.user.id).then (res) ->
      $scope.conges = res
    .catch (e) ->
      console.log 'reject conges for user' ,e
  else
    $location.path '/login'
  $scope.logout = ->
    Auth.logout().then (oldUser) ->
      $window.localStorage.clear()
      $location.path '/login'
    ,(error) ->
      console.log error
  $scope.sendDemande = ->
    d1 = moment($scope.dateF)
    d2 = moment($scope.dateD)
    userService.sendDemande($scope.user.id,d1.format(),d2.format(),$scope.motifAb).then (res)->
      console.log ("here")
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
  $scope.getModel = (id) ->
    userService.getModel(id).then (res) ->
      $scope.myModel = res
    ,(error) ->
      console.log 'error get model',error

  $scope.deletDemande = (id) ->
    userService.deletDemande(id).then (res)-> console.log ('ok')
    userService.getUserConges($scope.user.id).then (resp) ->
      $scope.conges = resp
      .catch (e) ->
        console.log 'error' ,e
    ,(error) ->
    console.log 'error delete demand',error

    $scope.register = ->
      if $scope.passwordConfirm isnt $scope.user.password or $scope.user.password.length <6
        $scope.showEmailError = false
        $scope.showPasswordError = true
        return
      else
      Auth.register( $scope.user ).then ->
        console.log 'ok'
      ,(error)->
        $scope.showPasswordError = false
        $scope.showEmailError = true if error.data.errors.email[0] is "has already been taken"
        console.log error,'register failed !'
