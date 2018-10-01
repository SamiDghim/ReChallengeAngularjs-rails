@app.controller 'registerCtrl', ($scope,Auth,$location) ->
  $scope.showPasswordError = false
  $scope.showEmailError = false
  $scope.register = ->
    if $scope.passwordConfirm isnt $scope.user.password or $scope.user.password.length <6
      $scope.showEmailError = false
      $scope.showPasswordError = true
      return
    else
    console.log $scope.user,'User register data'

    Auth.register( $scope.user ).then ->
      $location.path '/login'
    ,(error)->
      $scope.showPasswordError = true
      $scope.showEmailError = true if error.data.errors.email[0] is "has already been taken"
      console.log error,'register failed !'
