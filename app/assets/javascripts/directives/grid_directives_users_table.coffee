@app.directive 'gridScreen' , (adminService)->
  restrict: 'E'
  controller: ($scope)->
    setEditor: (editor) ->
      $scope.cols.unshift(editor)
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
  require: '^gridScreen'
  link: (scope, element, attributes, gridScreenCtrl) ->
    gridScreenCtrl.setEditor({
      title: 'Editer',
      field: ''
      })
    console.log 'linked withInlineEditor'

@app.directive 'editorInitializer' , ($compile,$templateCache,adminService)->
  restrict: 'E'
  templateUrl: 'editor_initializer_users_table.html'
  controller: ($scope)->
    $scope.changeState = ->
      $scope.editorState = false
    clickButton = true
    $scope.edit = (row) ->
      $scope.editorState = true
      $scope.$broadcast('edit',row) if clickButton is true
      clickButton = false
    $scope.editUser = () ->
      console.log $scope.row.id,'F'
      adminService.editUser($scope.row.id,$scope.row).then (res) ->
        $scope.rows = res.data
        $scope.pagesUsers = (num for num in [1..res.total])
        $scope.$broadcast('ready-to-render', $scope.rows, $scope.cols , $scope.pagesUsers)
        $scope.editorState = false
  link: (scope, element, attributes) ->
    scope.$on('edit', (e,row) ->
      editor = $compile($templateCache.get('editor.html'))(scope)
      $(editor).insertAfter(element.parents("tr"))
      )
    console.log 'linked editorInitializer'
