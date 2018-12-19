@app.controller 'stateCtrl', ($scope,Auth,$location,$http,userService,$window) ->
  $scope.user = JSON.parse($window.localStorage.getItem("currentUser"))
