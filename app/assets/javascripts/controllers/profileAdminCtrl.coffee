@app.controller 'profileAdminCtrl', ($scope,Auth,$location,$http,adminService,$window) ->
  $scope.user = JSON.parse($window.localStorage.getItem("currentUser"));
  $scope.showMsgValid = false ;

  $scope.pwd =''
  $scope.newPwd =''
  $scope.CnewPwd =''

  #modifier profil
  $scope.modifier =   ->
    adminService.editUser($scope.user.id ,$scope.user).then (res)->
      console.log ('ok')
      $window.localStorage.setItem("currentUser", angular.toJson($scope.user))
      $scope.showMsgValid = true ;
    ,(error) ->
    console.log 'update failed',error

  $scope.modifier =   ->
