@app.controller 'homeAdminCtrl', ($scope,Auth,$location,$http,$window,adminService) ->
    $scope.showMsgValid = false
    $scope.showMsgError = false
    $scope.ActivePageUser = 1
    $scope.ActivePageDNT = 1
    $scope.ActivePageDT = 1
    $scope.editorState = true
    $scope.showMsgValidEditUser = false
    $scope.orderByField = 'nom';
    $scope.set = (orderByField ) ->
      $scope.orderByField = orderByField
    $scope.reverseSort = false;

    $scope.user = JSON.parse($window.localStorage.getItem("currentUser"))
    if $scope.user?
      $location.path '/login' if $scope.user.role isnt "admin"

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


    $scope.complete = (mc) ->
      $scope.filterList = []
      if mc?
        if mc.length > 0
          mc = mc.replace(/\s/g,'')
          console.log "MC === ",mc
          myList = []
          username = ''
          angular.forEach $scope.demandesNonT, (name) ->
            username = name.user.nom+name.user.prenom
            console.log 'USERNAME !',username
            myList.push(name.user.nom + ' ' + name.user.prenom) if(name.user.nom.toLowerCase().indexOf(mc.toLowerCase()) >= 0 ) or
            (name.user.prenom.toLowerCase().indexOf(mc.toLowerCase()) >= 0 ) or (username.toLowerCase().indexOf(mc.toLowerCase()) >= 0 )
          console.log 'myList' , myList

          $scope.filterList = myList
    $scope.find = ->
        $scope.motCle = "" if !$scope.motCle?
        Indata = {p : $scope.ActivePageDNT }
        $http.get('/conge/search/'+$scope.motCle,Indata).then (res) ->
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

    $scope.sendReject = ->
            Indata = {motifR : $scope.motifR, etat :'Réfusé', id : $scope.idCongeDemand }
            adminService.sendReject(Indata).then (res) ->
              angular.element('#exampleModal').modal('hide')
              $scope.showMsgValid = true
              $scope.demandesNonT = res.data
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
            ,(error) ->
                console.log error , 'Error reject demand'
                $scope.showMsgError = true

    $scope.sendAccept = (event,id,user_id,db,df,solde) ->
            event.preventDefault()
            adminService.sendAccept(id,user_id,db,df,solde).then (res) ->
              $scope.showMsgValid = true
              $scope.demandesNonT = res.data
              $scope.pagesDNT = (num for num in [1..res.total])
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
            ,(error) ->
                console.log error , 'Error reject demand'
                $scope.showMsgError = true
            ,(error) ->
              console.log error , 'Error reject demand'
              $scope.showMsgError = true


    $scope.getModelInfo = (id) ->
            $http.get('/conge/getUserCongeModel/'+id).then (model) ->
                 $scope.myModel = model.data.data
            ,(error)->
                console.log error,'model not found'

    $scope.reloadDNTPage = (p) ->
            if $scope.motCle
              $scope.ActivePageDNT = p
              $http.get('/conge/search/'+$scope.motCle+'/'+p).then (res) ->
                console.log 'search ', res
                $scope.demandesNonT = res.data.data
                $scope.pagesDNT = (num for num in [1..res.data.total])
              ,(error)->
                console.log error,'Search error'
            else
              $scope.ActivePageDNT = p
              $http.get('conge/GetAllDemandsNonT/'+p).then (res) ->
                $scope.demandesNonT = res.data.data
              ,(error)->
                console.log error,'page demandsNonT not found'

    $scope.reloadDTPage = (p) ->
            $scope.ActivePageDT = p
            $http.get('conge/GetAllDemandsT/'+p).then (res) ->
                 $scope.demandesT = res.data.data
            ,(error)->
                console.log error,'page demandsNonT not found'
    $scope.addUser = ->
      console.log 'her' , $scope.u
      if $scope.passwordConfirm isnt $scope.u.password or $scope.u.password.length <6
        $scope.showEmailError = false
        $scope.showPasswordError = true
        return
      else
      console.log $scope.u,'User register data'
      adminService.addUser( $scope.u ).then ->
        angular.element('#addUserModale').modal('hide');
      ,(error)->
        $scope.showPasswordError = false
        $scope.showEmailError = true if error.data.errors.email[0] is "has already been taken"
        console.log error,'register failed !'
