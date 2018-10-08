@app.directive 'gridScreen' , (adminService)->
  restrict: 'E'
  controller: ($scope)->
    setEditor: () ->
    setColumns: (cols) ->
      $scope.cols = cols
  link: (scope, element, attributes)->
    adminService.getAllUsers().then (res) ->
      scope.rows = res.data
      scope.pagesUsers = (num for num in [1..res.total])
      scope.$broadcast('ready-to-render', scope.rows, scope.cols , scope.pagesUsers)
    console.log 'linked gridScreen'

@app.directive 'gridColumns' , ->
  restrict: 'E'
  require: ['^gridScreen', 'gridColumns']
  controller: ->
    columns = []
    addColumn: (col) ->
      columns.push(col)
    getColumns: ->
      return columns
  link: (scope, element, attributes, controllers) ->
    gridScreenCtrl = controllers[0]
    gridColumnsCtrl = controllers[1]
    gridScreenCtrl.setColumns(gridColumnsCtrl.getColumns())
    console.log 'linked gridColumns'

@app.directive 'gridColumn' , ->
  restrict: 'E'
  require:'^gridColumns'
  link: (scope, element, attributes, gridColumnsCtrl) ->
    gridColumnsCtrl.addColumn({title: attributes.title,field: attributes.field})
    console.log 'linked gridColumn'

@app.directive 'grid' , ->
  restrict: 'E'
  replace: true
  templateUrl: 'users_table_admin.html'
  controller: ($scope,$http)->
    $scope.$on('ready-to-render',(e, rows, cols, pagesUsers)->
      $scope.rows = rows
      $scope.cols = cols
      $scope.pagesUsers = pagesUsers
      )
    $scope.reloadUserPage = (p)->
      $scope.ActivePageUser = p
      $http.get('/GetAllUsers/'+p).then (res) ->
        $scope.rows = res.data.data
      ,(error)->
        console.log error,'page users not found'  

@app.directive 'withInlineEditor' , ->
  restrict: 'A'
  link: ->
    console.log 'linked withInlineEditor'
