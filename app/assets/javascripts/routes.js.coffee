
@app.config ( $routeProvider, $locationProvider,$httpProvider ) ->
  token= $('meta[name="csrf-token"]').attr('content')
  commonHeaders = $httpProvider.defaults.headers.common
  commonHeaders[ 'X-CSRF-TOKEN' ] = token
  commonHeaders['Accept'] = 'application/json'

  $routeProvider
  .when "/UserHome",
    controller:  'homeUserCtrl'
    templateUrl: 'views/users/homeUser.html'

  .when "/AdminHome",
    controller:  'homeAdminCtrl'
    templateUrl: 'views/users/homeAdmin.html'

  .when "/login",
    controller:  'authCtrl'
    templateUrl: 'views/login.html'

  .when "/change",
    controller:  'homeUserCtrl'
    templateUrl: 'views/users/profil.html'

  .when "/listDemands",
    controller:  'homeUserCtrl'
    templateUrl: 'views/users/listDemands.html'

  .when "/register",
    controller:  'registerCtrl'
    templateUrl: 'views/register.html'

  .when "/profil",
    controller:  'homeUserCtrl'
    templateUrl: 'views/users/profil.html'


  .otherwise redirectTo: "/login"

  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false,
    rewriteLinks: true
  });
# @app.run(($templateRequest) ->
  # $templateRequest('editor.html'))
