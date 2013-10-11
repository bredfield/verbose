##= require jquery-2.0.3
##= require lodash
##= require angular.js
##= require angular-ui-router
##= require angular-resource
##= require ui-bootstrap-tpls-0.4.0
##= require bootstrap
##= require swipe
##= require store
##= require_self
##= require_tree ./app

Verbose = angular.module('Verbose',['ui.router.state','ui.bootstrap', 'ngResource'])
  .config ($stateProvider, $urlRouterProvider)->

    templateRoot = "assets/templates"

    $urlRouterProvider.otherwise("/")

    $stateProvider
      .state 'index',
        url:'/'
        templateUrl:"#{templateRoot}/wordList.html"
        controller:'listCtrl'
      .state 'detail',
        url:'/words/:wordId'
        templateUrl:"#{templateRoot}/wordDetail.html"
        controller:'detailCtrl'
      .state 'search',
        url:'/search'
        templateUrl:"#{templateRoot}/search.html"
        controller:"searchCtrl"

