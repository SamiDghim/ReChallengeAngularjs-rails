@app.controller 'profileAdminCtrl', ($scope,Auth,$location,$http,adminService,$window) ->

  $scope.user = JSON.parse($window.localStorage.getItem("currentUser"));
  $scope.showMsgValid = false ;
  $scope.newPwd =''
  $scope.CnewPwd =''
  $scope.parameters = {
            password: '',
            password_confirmation: '',
            reset_password_token:''
        };

  #modifier profil
  $scope.modifier =   ->
    adminService.editUser($scope.user.id ,$scope.user).then (res)->
      console.log ('ok')
      $window.localStorage.setItem("currentUser", angular.toJson($scope.user))
      $scope.showMsgValid = true ;
    ,(error) ->
    console.log 'update failed',error

  $scope.refreshData = ->
      $scope.showMsgValid = false ;
      $scope.parameters.password =''
      $scope.parameters.password_confirmation =''

  $scope.updatePasswordModal = ->
   if $scope.parameters.password_confirmation isnt $scope.parameters.password or $scope.parameters.password.length <6
      $scope.showEmailError = false
      $scope.showPasswordError = true
      return
    else
    Auth.resetPassword(  $scope.parameters ).then ->
      $location.path '/home'
    ,(error)->
      console.log error,'register failed !'

return true ;
