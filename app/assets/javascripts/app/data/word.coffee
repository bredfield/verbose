angular.module("Verbose").factory 'Word', ($resource, $rootScope)->
  Word = $resource "/words/:id.json",
    id: "@id"
  ,
    index:
      method: "GET"
      isArray: true
    search:
      method: "GET"
      isArray:true
      url:"/words/search.json"
    update:
      method: "PUT"

  Word.toggleLearned = (word)->
    word.learned = !word.learned
    word.date_learned = if word.learned then new Date() else null
    word.$update()

  return Word
# angular.module("Verbose").factory 'Word', ($rootScope)->
# 	wordService = {}
# 	words = []
# 	# user = $rootScope.user

# 	wordService.getAll = ()->
# 		words = store.get('words')
# 		return words

# 	wordService.getWord = (name)->
# 		allWords = wordService.getAll()
# 		word = _.find(allWords, {name:name})
# 		return word

# 	wordService.getRandomWord = ()->
# 		allWords = wordService.getAll()
# 		randomIndex = Math.floor(Math.random()*allWords.length)
# 		return allWords[randomIndex]

# 	wordService.toggleLearned = (word)->
# 		word.learned = !word.learned
# 		word.dateLearned = if word.learned then new Date() else null

# 		updateLocal()

# 	wordService.add = (newWord)->
# 		words.push newWord
# 		updateLocal()

# 	wordService.remove = (which)->
# 		pos = words.indexOf(which)
# 		words.splice(pos,1)
# 		updateLocal()

# 	updateLocal = ()->
# 		store.set('words', words)

# 	return wordService
