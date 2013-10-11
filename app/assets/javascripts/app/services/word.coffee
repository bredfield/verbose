angular.module("Verbose").factory 'Word', ($resource)->
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
