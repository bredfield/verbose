describe 'VERBOSE SERVICES', ()->
  console.log "=========Starting Service Specs============"
  #SETUP
  beforeEach ()->
    module('Verbose')

    @addMatchers
      toEqualData: (expected)->
        angular.equals(@actual, expected)
  
  #WORD SERVICE
  describe "WORD",()->
    Word = ""
    $httpBackend = ""

    beforeEach inject (_$httpBackend_, $injector)->
      ##Set up necessary mocks
      $httpBackend = _$httpBackend_
      Word = $injector.get('Word')

    it 'Should pull words index', ()->
      data = [
        created_at: "2013-10-09T01:33:38Z"
        name: "earlierWord"
      ,
        created_at: "2013-10-09T01:33:55Z"
        name: "laterWord"
      ]
      $httpBackend.expectGET('/words.json').respond(data)
      words = Word.index()

      $httpBackend.flush()

      expect(words[1].name).toBe("laterWord")

    it 'Should pull a word', ()->
      data = 
        created_at: "2013-10-09T01:33:38Z"
        name: "earlierWord"

      $httpBackend.expectGET('/words/:id.json').respond(data)
      word = Word.get(id:":id")

      $httpBackend.flush()

      expect(word.name).toBe("earlierWord")

    it 'Should search for words', ()->
      data = [
        name: "Test"
        definition: "A test"
      , 
        name: "Test"
        definition: "Another test"
      ]

      $httpBackend.expectGET('/words/search.json?word=Test').respond(data)
      words = Word.search(word:"Test")

      $httpBackend.flush()

      expect(words[1].definition).toBe("Another test")

    it 'Should add a word', ()->
      data = 
        name:"Ball"
        definition:"Spherical thing"

      $httpBackend.expectPOST('/words.json',{word:data}).respond(data)
      newWord = new Word(word:data)
      newWord.$save()

      $httpBackend.flush()
      expect(newWord.name).toBe('Ball')

    it 'Should remove a word', ()->
      data = "word successfully destroyed"
      $httpBackend.expectDELETE('/words/1.json').respond(data)
      deleted = Word.remove({id:1})

      $httpBackend.flush()
      expect(deleted).not.toBeUndefined()


