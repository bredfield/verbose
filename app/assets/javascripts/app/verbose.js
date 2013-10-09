(function() {
  var Verbose;

  Verbose = angular.module('Verbose', ['ui.router.state', 'ui.bootstrap', 'ngResource']).config(function($routeProvider, $httpProvider, $stateProvider, $urlRouterProvider) {
    var templateRoot;
    if (!store.get('words')) {
      store.set('words', []);
    }
    templateRoot = "assets/templates";
    $urlRouterProvider.otherwise("/");
    $stateProvider.state('index', {
      url: '/',
      templateUrl: "" + templateRoot + "/wordList.html",
      controller: 'listCtrl'
    }).state('detail', {
      url: '/words/:wordId',
      templateUrl: "" + templateRoot + "/wordDetail.html",
      controller: 'detailCtrl'
    }).state('search', {
      url: '/search',
      templateUrl: "" + templateRoot + "/search.html",
      controller: "searchCtrl"
    }).state('quiz', {
      url: '/quiz',
      templateUrl: "" + templateRoot + "/quiz.html",
      controller: "quizCtrl"
    });
    return delete $httpProvider.defaults.headers.common['X-Requested-With'];
  });

}).call(this);

(function() {
  angular.module("Verbose").factory('Auth', function($rootScope) {
    return function(getUser) {
      var auth, fb;
      console.log("asd");
      fb = new Firebase("https://verbose.firebaseio.com");
      return auth = new FirebaseSimpleLogin(fb, function(error, user) {
        if (getUser) {
          return user;
        }
        if (user) {
          $rootScope.user = user;
          return $rootScope.$emit("login", user);
        } else if (error) {
          return $rootScope.$emit("error", error);
        } else {
          return $rootScope.$emit("logout");
        }
      });
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").factory('Dictionary', function($resource) {
    var apiKey, baseUrl;
    baseUrl = "http://api.wordnik.com/v4";
    apiKey = 'c3b45323cb219cf66c5420b4aaa035b8bb6773d9ca99edf7f';
    return function(word, query, type) {
      var url;
      if (type === "words") {
        url = "" + baseUrl + "/words.json/" + query + "/" + word;
      } else {
        url = "" + baseUrl + "/word.json/" + word + "/" + query;
      }
      return $resource(url, {
        api_key: apiKey,
        useCanonical: true,
        caseSensitive: false
      });
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").factory('Suggestion', function($http) {
    var action, apiKey, baseUrl;
    baseUrl = "https://www.macmillandictionary.com/api/v1";
    action = "/dictionaries/american/search/didyoumean";
    apiKey = '3iqW5S1yG1zl2qieARWLforJROD31OKi1Z39KQdpnVKakGWEPXpeS3wy8JihlFcZ';
    return function(word) {
      return $http.jsonp(baseUrl + action + '/', {
        data: {
          accessKey: "3iqW5S1yG1zl2qieARWLforJROD31OKi1Z39KQdpnVKakGWEPXpeS3wy8JihlFcZ",
          q: word,
          entryNumber: 10
        },
        headers: {
          accessKey: apiKey
        }
      });
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").factory('Word', function($resource, $rootScope) {
    var Word;
    Word = $resource("/words/:id.json", {
      id: "@id"
    }, {
      index: {
        method: "GET",
        isArray: true
      },
      search: {
        method: "GET",
        isArray: true,
        url: "/words/search.json"
      },
      update: {
        method: "PUT"
      }
    });
    Word.toggleLearned = function(word) {
      word.learned = !word.learned;
      word.date_learned = word.learned ? new Date() : null;
      return word.$update();
    };
    return Word;
  });

}).call(this);

(function() {
  angular.module("Verbose").controller('detailCtrl', function($scope, $state, Word) {
    var _ref,
      _this = this;
    $scope.word = Word.get({
      id: $state.params.wordId
    });
    $scope.dateLearned = (_ref = $scope.word.date_learned) != null ? _ref : "Not yet learned";
    $scope.$watch("word.learned", function(val) {
      var _ref1;
      $scope.learnedText = val ? "Whoops, forgot" : "Learned it!";
      return $scope.dateLearned = (_ref1 = $scope.word.date_learned) != null ? _ref1 : "Not yet learned";
    });
    $scope.remove = function(word) {
      return Word.remove(word);
    };
    return $scope.toggleLearned = function(word) {
      return Word.toggleLearned(word);
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").directive("activeLink", function($location) {
    return {
      restrict: "A",
      link: function(scope, node) {
        var path;
        path = $(node).find('a').attr("href");
        path = path.substring(1);
        scope.location = $location;
        return scope.$watch("location.path()", function(newPath) {
          var method;
          method = path === newPath ? 'add' : 'remove';
          return node["" + method + "Class"]('active');
        });
      }
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").directive("focused", function($timeout) {
    return {
      restrict: "A",
      link: function(scope, node) {
        return $timeout(function() {
          return $(node).focus();
        });
      }
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").directive("linedItem", function() {
    return {
      restrict: "A",
      link: function(scope, node) {
        node.addClass('li-lined');
        return node.append("<div class='border-bottom'/>");
      }
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").directive("swipe", function($timeout) {
    return {
      restrict: "E",
      link: function(scope, node) {
        var swipeNode;
        swipeNode = $("<div class='swipe'><div class='swipe-wrap'></div></div>");
        $(node).wrapInner(swipeNode);
        scope.swipe = Swipe($(node).find(".swipe")[0], {
          continuous: false
        });
        return $timeout(function() {
          var height;
          height = $(node).find(".swipe").height();
          return $(node).find('.padding-wrapper').height(height);
        });
      }
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").directive("vCenter", function($timeout) {
    return {
      restrict: "A",
      link: function(scope, node) {
        return setTimeout(function() {
          var child, nodeHeight, _i, _len, _ref, _results;
          node = $(node);
          nodeHeight = node.height();
          _ref = node.children();
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            child = _ref[_i];
            child = $(child);
            _results.push(child.css({
              "margin-top": (nodeHeight - child.height()) / 2
            }));
          }
          return _results;
        }, 100);
      }
    };
  });

}).call(this);

(function() {
  var Verbose;

  Verbose = angular.module("Verbose");

  Verbose.filter("capitalize", function() {
    return function(text) {
      if (text != null) {
        return text.charAt(0).toUpperCase() + text.slice(1);
      }
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").controller('listCtrl', function($scope, Word, Suggestion) {
    var _this = this;
    $scope.words = Word.index();
    $scope.orderProp = {
      $: "-created_at"
    };
    $scope.query = {
      learned: false
    };
    $scope.$watch("query.learned", function(val) {
      return $scope.learnedText = $scope.query.learned ? "Whoops, forgot" : "Learned it!";
    });
    $scope.remove = function(word) {
      return Word.remove(word);
    };
    return $scope.toggleLearned = function(word) {
      return Word.toggleLearned(word);
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").controller('loginCtrl', function($scope, $rootScope, Auth, Word) {
    var auth;
    auth = Auth();
    $scope.login = function() {
      return auth.login("password", {
        email: $scope.loginForm.email,
        password: $scope.loginForm.password
      });
    };
    $scope.logout = function() {
      return auth.logout();
    };
    $rootScope.$on("login", function(e, user) {
      return $rootScope.user = user;
    });
    return $rootScope.$on("error", function(e, error) {
      return console.log(error);
    });
  });

}).call(this);

(function() {
  angular.module("Verbose").controller('quizCtrl', function($scope, Word) {
    $scope.newQuestion = function() {
      return $scope.word = Word.getRandomWord();
    };
    return $scope.submitAnswer = function() {
      console.log("asd");
      return console.log($scope.word.synonyms.indexOf($scope.guess));
    };
  });

}).call(this);

(function() {
  angular.module("Verbose").controller("searchCtrl", function($scope, $http, $state, Word) {
    $scope.searchWord = function(wordSearch) {
      return $scope.definitions = Word.search({
        word: wordSearch
      }, function(data) {
        return $scope.noWords = data.length === 0 ? true : false;
      });
    };
    return $scope.addWord = function(definition) {
      var newWord;
      newWord = new Word({
        word: {
          name: definition.word,
          definition: definition.text,
          part_of_speech: definition.partOfSpeech,
          learned: false
        }
      });
      newWord.$save();
      return $state.transitionTo('index');
    };
  });

}).call(this);
