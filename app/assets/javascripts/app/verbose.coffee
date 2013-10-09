Verbose = angular.module('Verbose',['ui.router.state','ui.bootstrap', 'ngResource'])
  .config ($routeProvider, $httpProvider, $stateProvider, $urlRouterProvider)->
    if !store.get('words')
      store.set('words',[])

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
      .state 'quiz',
        url:'/quiz'
        templateUrl:"#{templateRoot}/quiz.html"
        controller:"quizCtrl"

    # $httpProvider.defaults.headers.common.useXDomain = true
    delete $httpProvider.defaults.headers.common['X-Requested-With']
