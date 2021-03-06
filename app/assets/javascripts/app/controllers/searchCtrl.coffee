angular.module("Verbose").controller "searchCtrl", ($scope, $http, $state, Word)->
	
	$scope.searchWord = (wordSearch)->
		##pull definitions
		$scope.definitions = Word.search {word:wordSearch}, (data)->
			  ##if no words, display text
				$scope.noWords = if data.length == 0 then true else false

	$scope.addWord = (definition)->
		newWord = new Word 
			word:
				name:definition.word
				definition:definition.text
				part_of_speech:definition.partOfSpeech
				learned:false
		newWord.$save()
		$state.transitionTo('index')