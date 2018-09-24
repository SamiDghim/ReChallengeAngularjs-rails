@app.controller 'homeUserCtrl', ($scope,Auth,$location,$http) ->
    $scope.isLogedIn=false;
    $http.get('/GetLoggedUserInfo').then (res) ->
        console.log 'res user json', res
        $scope.user=res
        $scope.isLogedIn=true;
    ,(error)->
        $scope.isLogedIn=true
        console.log error,'Home User is not logged in'
        $location.path '/login'
    $scope.logout = ->
        Auth.logout().then (oldUser) ->
            console.log oldUser," logout  !"
            $location.path '/login'
        ,(error) ->
            console.log error