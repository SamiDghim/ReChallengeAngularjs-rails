@app.controller 'stateCtrl', ($scope,Auth,$location,$http,userService,$window) ->
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

  $scope.getAllConges = ->
    userService.getAllConges().then (res) ->
      $scope.conges = res.data
      $scope.pagesDT = (num for num in [1..res.total])
    ,(error) ->
      console.log 'error demandsT not found !' ,error
