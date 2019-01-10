@app.controller 'homeUserCtrl', ($scope,Auth,$location,$http,userService,$window) ->
  $scope.showMsgValid = false
  $scope.showMsgError = false
  $scope.orderByField = 'dateD';
  $scope.set = (orderByField ) ->
   $scope.orderByField = orderByField

  $scope.reverseSort = false;

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

  $scope.deleteDemande = (id) ->
      userService.deleteDemande(id).then (res) ->
         console.log 'ok'
      userService.getUserConges($scope.user.id).then (resp) ->
         $scope.conges = resp
      .catch (e) ->
          console.log 'error in delete fuction' ,e
      ,(error) ->
        console.log 'error',error

  $scope.getModel = (id) ->
    userService.getModel(id).then (res) ->
      $scope.myModel = res
    ,(error) ->
      console.log 'error get model',error

  $scope.getAllConges = ->
    userService.getAllDemandsT().then (res) ->
      $scope.demandesT = res.data
      $scope.pagesDT = (num for num in [1..res.total])
    ,(error) ->
      console.log 'error demandsT not found !' ,error

  $scope.updateDemande = ->
    userService.updateDemande($scope.myModel[0].id, $scope.myModel[0])
    .then (res) ->
       console.log 'ok'
    userService.getUserConges($scope.user.id).then (resp) ->
       $scope.conges = resp
    .catch (e) ->
        console.log 'error in update fuction' ,e
    ,(error) ->
      console.log 'error',error

  $scope.showPasswordError = false
  $scope.changeInfo = ->

    if $scope.passwordConfirm isnt $scope.user.password or $scope.user.password.length < 6
      $scope.showPasswordError = true
      console.log 'error error'
      return

    else
      userService.changeInfo($scope.user.id, $scope.user).then (res) ->
        Auth.logout().then (oldUser) ->
          $window.localStorage.clear()
          $location.path '/login'
      .catch (e) ->
          console.log 'error in update fuction' ,e
      ,(error) ->
        console.log 'error',error
