@app.controller 'teamStateCtrl', ($scope,Auth,$location,$http,adminService,$window) ->
	$scope.user = JSON.parse($window.localStorage.getItem("currentUser"))
	$scope.currentDate = moment();
	$scope.ListeCongeAccepte = [] ;
	$scope.getAllUsers = ->
		adminService.getAllUsers().then (res) ->
			$scope.users = res.data
			$scope.pages = (num for num in [1..res.total])
		,(error) ->
			console.log 'error users not found !' ,error
		adminService.getAllDemandsT().then (res) ->
			$scope.demandesT = res.data
			$scope.pagesDT = (num for num in [1..res.total])
			for conge in $scope.demandesT
				if (conge.etat = "Accepté")
					$scope.ListeCongeAccepte.push(conge)
			console.log 	$scope.ListeCongeAccepte;
		,(error) ->
			console.log 'error demandsT not found !' ,error
	$scope.fnWeekDays  = (dt) ->
		 $scope.currentDate = dt;
		 $scope.weekStart = $scope.currentDate.clone().startOf('week');
		 $scope.weekEnd = $scope.currentDate.clone().endOf('week');
		 $scope.days = [];
		 for i in [1..7]
			 $scope.days.push(moment($scope.weekStart).add(i, 'days').format("Y-M-D"));
		 return $scope.days;
	$scope.weekDays = $scope.fnWeekDays($scope.currentDate);
