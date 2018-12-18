@app.controller 'profileAdminCtrl', ($scope,Auth,$location,$http,adminService,$window) ->

  $scope.user = JSON.parse($window.localStorage.getItem("currentUser"));
  $scope.showMsgValid = false ;
  $scope.newPwd =''
  $scope.CnewPwd =''
  $scope.parameters = {
            password: ''
        };
        
  $scope.u ={
    nom :'',
    prenom :'',
    role : '' ,
    email:'',
    password : '',
    passwordConfirm :''
  }

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

  $scope.updatePassword = ->
   if $scope.parameters.password_confirmation isnt $scope.parameters.password or $scope.parameters.password.length <6
      $scope.showEmailError = false
      $scope.showPasswordError = true
      return
    else
    adminService.updatePassword($scope.user.id,  $scope.parameters ).then ->
    console.log 'ok'

return true ;
