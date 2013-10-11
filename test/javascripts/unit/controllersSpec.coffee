describe 'VERBOSE CONTROLLERS', ()->
  console.log "=========Starting Ctrl Specs============"
  #SETUP
  beforeEach ()->
    module('Verbose')

    @addMatchers
      toEqualData: (expected)->
        angular.equals(@actual, expected)
  
  #WORD LIST CONTROLLER
  describe "LIST",()->
    scope = ""
    ctrl = ""
    $httpBackend = ""

    beforeEach inject (_$httpBackend_, $rootScope, $controller, Word)->
      ##Set up necessary mocks
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET('/words.json').respond([
        id:0
        created_at: "2013-10-09T01:33:38Z"
        name: "earlierWord"
      ,
        id:1
        created_at: "2013-10-09T01:33:55Z"
        name: "laterWord"
      ])
      scope = $rootScope.$new()
      ctrl = $controller('listCtrl', {$scope:scope})

    it 'Should load words', ()->
      ##start with empty dataset
      expect(scope.words).toEqualData([])

      ##pull 
      $httpBackend.flush()
      expect(scope.words[1].name).toBe("laterWord")

    it 'Should start with the right queries', ()->
      expect(scope.orderProp.$).toBe("-created_at")
      expect(scope.query.learned).toBe(false)

    it 'Should toggle learned text', ()->
      ##switch query learned, apply watch
      scope.query.learned = false
      scope.$apply()
      expect(scope.learnedText).toBe("Learned it!")

    it 'Should remove words', inject (Word)->
      data = "word successfully destroyed"
      $httpBackend.expectDELETE('/words/1.json').respond(data)

      deleted = Word.remove {id:1}, ()->
        scope.words.splice(1,1)

      $httpBackend.flush()

      expect(scope.words.length).toBe(1)

  #WORD DETAIL CONTROLLER
  describe "DETAIL",()->
    scope = ""
    ctrl = ""
    $httpBackend = ""

    beforeEach inject (_$httpBackend_, $state, $rootScope, $controller)->
      ##Set up necessary mocks
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET('/words/:id.json').respond
        created_at: "2013-10-09T01:33:38Z"
        name: "detailWord"
        date_learned:null
      
      $state.params.wordId = ":id"

      scope = $rootScope.$new()
      ctrl = $controller('detailCtrl', {$scope:scope})

    it 'Should load the word', ()->
      ##start with empty dataset
      expect(scope.word).toEqualData({})

      ##pull 
      $httpBackend.flush()
      expect(scope.word.name).toBe("detailWord")

    it 'Should start with the correct date learned', ()->
      expect(scope.dateLearned).toBe("Not yet learned")

    it 'Should toggle learned text', ()->
      ##switch query learned, apply watch
      scope.word.learned = true
      scope.$apply()
      expect(scope.learnedText).toBe("Whoops, forgot")
      expect(scope.dateLearned).toBe("Not yet learned")

  #WORD SEARCH CONTROLLER
  describe "SEARCH",()->
    scope = ""
    ctrl = ""
    $httpBackend = ""

    beforeEach inject (_$httpBackend_, $state, $rootScope, $controller)->
      ##Set up necessary mocks
      $httpBackend = _$httpBackend_
      $httpBackend.expectGET('/words/search.json?word=Test').respond(
        [
          name: "Test"
          definition: "Lol i dunno"
          part_of_speech:"noun"
        ]
      )

      scope = $rootScope.$new()
      ctrl = $controller('searchCtrl', {$scope:scope})

    it 'Should load the search', ()->
      expect(scope.definitions).toBeUndefined()
      scope.searchWord("Test")

      $httpBackend.flush()
      expect(scope.definitions[0].name).toBe("Test")

    it 'Should properly assign no words', ()->
      expect(scope.definitions).toBeUndefined()
      scope.searchWord("Test")

      $httpBackend.flush()
      expect(scope.noWords).toBe(false)


