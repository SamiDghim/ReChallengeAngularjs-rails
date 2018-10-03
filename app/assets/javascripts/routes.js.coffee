
@app.config ( $routeProvider, $locationProvider,$httpProvider ) ->
  token= $('meta[name="csrf-token"]').attr('content')
  commonHeaders = $httpProvider.defaults.headers.common
  commonHeaders[ 'X-CSRF-TOKEN' ] = token
  commonHeaders['Accept'] = 'application/json'

  $routeProvider
  .when "/UserHome",
    controller:  'homeUserCtrl'
    templateUrl: 'views/homeUser.html'

  .when "/AdminHome",
    controller:  'homeAdminCtrl'
    templateUrl: 'views/homeAdmin.html'

  .when "/login",
    controller:  'authCtrl'
    templateUrl: 'views/login.html'

  .when "/register",
    controller:  'registerCtrl'
    templateUrl: 'views/register.html'

  .otherwise redirectTo: "/login"

  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false,
    rewriteLinks: true
  });
