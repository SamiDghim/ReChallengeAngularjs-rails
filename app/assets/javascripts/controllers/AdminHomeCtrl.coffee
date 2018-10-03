@app.controller 'homeAdminCtrl', ($scope,Auth,$location,$http,$window,adminService) ->
    $scope.showMsgValid = false
    $scope.showMsgError = false
    $scope.ActivePageUser=1
    $scope.ActivePageDNT=1
    $scope.ActivePageDT=1

    $scope.user = JSON.parse($window.localStorage.getItem("currentUser"))
    if $scope.user?
      $location.path '/login' if $scope.user.role isnt "admin"

      adminService.getAllUsers().then (res) ->
        $scope.users = res.data
        $scope.pages = (num for num in [1..res.total])
      ,(error) ->
        console.log 'error users not found !' ,error

      adminService.getAllDemandsT().then (res) ->
        $scope.demandesT = res.data
        $scope.pagesDT = (num for num in [1..res.total])
      ,(error) ->
        console.log 'error demandsT not found !' ,error

      adminService.getAllDemandsNonT().then (res) ->
        $scope.demandesNonT = res.data
        $scope.pagesDNT = (num for num in [1..res.total])
      ,(error) ->
        console.log 'error users not found !' ,error
     else
       $location.path '/login'

    $scope.find = ->
        $scope.motCle = "" if !$scope.motCle?
        console.log $scope.motCle, 'MOTCLE'
        Indata = {p : $scope.ActivePageDNT }
        $http.get('/conge/search/'+$scope.motCle,Indata).then (res) ->
          console.log 'search ', res
          $scope.demandesNonT = res.data.data
          $scope.pagesDNT = (num for num in [1..res.data.total])
        ,(error)->
          console.log error,'Search error'

    $scope.logout = ->
        Auth.logout().then (oldUser) ->
            $window.localStorage.clear()
            $location.path '/login'
        ,(error) ->
            console.log error

    $scope.saveIdCongeDemand = (id) ->
        $scope.idCongeDemand = id
        console.log $scope.idCongeDemand , 'ID CongeDemand'

    $scope.sendReject = ->
            Indata = {motifR : $scope.motifR, etat :'Réfusé', id : $scope.idCongeDemand }
            headers = {'Content-Type': 'application/json'}
            $http.post('/conge/RejectConge/',Indata,headers).then (response) ->
                angular.element('#exampleModal').modal('hide')
                $scope.showMsgValid = true
                $scope.demandesNonT = response.data.data
                GetAllDemandsT()
                GetAllUsers()
            ,(error) ->
                console.log error , 'Error reject demand'
                $scope.showMsgError = true

    $scope.sendAccept = (event,id,user_id,db,df,solde) ->
            event.preventDefault()
            _MS_PER_DAY = 1000 * 60 * 60 * 24
            a=new Date(db)
            b=new Date(df)
            utc1 = Date.UTC(a.getFullYear(), a.getMonth(), a.getDate())
            utc2 = Date.UTC(b.getFullYear(), b.getMonth(), b.getDate())
            res = Math.floor((utc2 - utc1) / _MS_PER_DAY)
            resF = solde-res
            Indata = {id : id,etat :'Accepté',user_id : user_id,solde : resF}
            headers = {'Content-Type': 'application/json'}
            $http.post('/conge/AcceptConge/',Indata,headers).then (response) ->
                $scope.showMsgValid = true
                $scope.demandesNonT = response.data.data
                GetAllDemandsT()
                GetAllUsers()
            ,(error) ->
                console.log error , 'Error reject demand'
                $scope.showMsgError = true

    $scope.getModelInfo = (id) ->
            $http.get('/conge/getUserCongeModel/'+id).then (model) ->
                 $scope.myModel = model.data.data
            ,(error)->
                console.log error,'model not found'

    $scope.reloadUserPage = (p) ->
            $scope.ActivePageUser=p
            $http.get('/GetAllUsers/'+p).then (res) ->
                 $scope.users = res.data.data
            ,(error)->
                console.log error,'page users not found'

    $scope.reloadDNTPage = (p) ->
            $scope.ActivePageDNT=p
            $http.get('conge/GetAllDemandsNonT/'+p).then (res) ->
                 $scope.demandesNonT = res.data.data
            ,(error)->
                console.log error,'page demandsNonT not found'

    $scope.reloadDTPage = (p) ->
            $scope.ActivePageDT=p
            $http.get('conge/GetAllDemandsT/'+p).then (res) ->
                 $scope.demandesT = res.data.data
            ,(error)->
                console.log error,'page demandsNonT not found'
