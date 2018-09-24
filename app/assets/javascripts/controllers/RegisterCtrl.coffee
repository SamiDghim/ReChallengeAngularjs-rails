@app.controller 'registerCtrl', ($scope,Auth,$location) ->
    $scope.register = ->
        console.log $scope.user,'User register data'
        Auth.register( $scope.user ).then ->
             $location.path '/login'
        ,(error)->
            console.log error,'register failed !'