@app.controller 'homeAdminCtrl', ($scope,Auth,$location,$http,$window,$routeParams) ->
    $scope.isLogedIn = false
    $scope.showMsgValid = false
    $scope.showMsgError = false

    GetAllDemandsNonT = ->
        $http.get('/conge/GetAllDemandsNonT').then (res) ->
                 console.log 'DemandsNonT ', res
                 $scope.demandesNonT=res.data.data
                 $scope.pagesDNT = (num for num in [1..res.data.total])
            ,(error)->
                console.log error,'Users not found'

    GetAllDemandsT = ->
        $http.get('/conge/GetAllDemandsT').then (res) ->
                 console.log 'DemandsT ', res
                 $scope.demandesT=res.data.data
                 $scope.pagesDT = (num for num in [1..res.data.total])
            ,(error)->
                console.log error,'Users not found'

    $http.get('/GetLoggedUserInfo').then (res) ->
        console.log 'res user json', res
        if res.data.data?
            $location.path '/login' if res.data.data.role is "user"
            $scope.user=res.data.data
            $http.get('/conge/GetAllUsers').then (users) ->
                 console.log users , 'Users for Admin'
                 $scope.users=users.data.data
                 $scope.pages = (num for num in [1..users.data.total])
                 GetAllDemandsNonT()
                 GetAllDemandsT()
            ,(error)->
                console.log error,'Users not found'
            
        else
            $location.path '/login'
            return
    ,(error)->
        console.log error,' Admin is not logged in'
        $location.path '/login'
        return


    $scope.find = ->
        $scope.motCle = "" if $scope.motCle is "undefiend"
        console.log $scope.motCle,' MOTCLE'
        $http.get('/conge/search/'+$scope.motCle).then (res) ->
                 console.log 'search ', res
                 $scope.demandesNonT=res.data.data
            ,(error)->
                console.log error,'Search error'

    $scope.logout = ->
        Auth.logout().then (oldUser) ->
            $scope.isLogedIn = false
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
                $scope.showMsgValid = true
                $scope.demandesNonT = response.data.data
                GetAllDemandsT()
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
            res=Math.floor((utc2 - utc1) / _MS_PER_DAY)
            resF=solde-res
            Indata = {id : id,etat :'Accepté',user_id : user_id,solde : resF}
            headers = {'Content-Type': 'application/json'}
            $http.post('/conge/AcceptConge/',Indata,headers).then (response) ->
                $scope.showMsgValid = true
                $scope.demandesNonT = response.data.data
                GetAllDemandsT()
            ,(error) ->
                console.log error , 'Error reject demand'
                $scope.showMsgError = true

    $scope.getModelInfo = (id) ->
            $http.get('/conge/getUserCongeModel/'+id).then (model) ->
                 $scope.myModel=model.data.data
            ,(error)->
                console.log error,'model not found'

    $scope.reloadUserPage = (p) ->
            $location.url('/AdminHome?page='+p)
            $window.location.reload()

    $scope.reloadDNTPage = (p) ->
            $location.url('/AdminHome?DNTPage='+p)
            $window.location.reload()

    $scope.reloadDTPage = (p) ->
            $location.url('/AdminHome?DTPage='+p)
            $window.location.reload()