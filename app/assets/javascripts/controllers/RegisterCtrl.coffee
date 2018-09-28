@app.controller 'registerCtrl', ($scope,Auth,$location) ->
  $scope.showPasswordError = false
  $scope.register = ->
    if $scope.passwordConfirm isnt $scope.user.password or $scope.user.password.length <6
      $scope.showPasswordError = true
      return
    else
    console.log $scope.user,'User register data'

    Auth.register( $scope.user ).then ->
      $location.path '/login'
    ,(error)->
      console.log error,'register failed !'
