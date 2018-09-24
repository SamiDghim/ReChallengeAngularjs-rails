@app.controller 'homeUserCtrl', ($scope,Auth,$location,$http) ->
    $scope.isLogedIn=false;

    $http.get('/GetLoggedUserInfo').then (res) ->
        console.log 'res user json', res
        if res.data.data?
            $scope.isLogedIn=true;
            $scope.user=res
        else
            $location.path '/login'
    ,(error)->
        console.log error,'Home User is not logged in'
        $location.path '/login'

    $scope.logout = ->
        Auth.logout().then (oldUser) ->
            $scope.isLogedIn=false;
            console.log oldUser," logout  !"
            $location.path '/login'
        ,(error) ->
            console.log error