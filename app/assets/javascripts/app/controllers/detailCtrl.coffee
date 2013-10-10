angular.module("Verbose").controller 'detailCtrl', ($scope, $state, Word)->
	
	console.log $scope.word = Word.get(id:$state.params.wordId)
	$scope.dateLearned = $scope.word.date_learned ? "Not yet learned"

	$scope.$watch "word.learned", (val)=>
		$scope.learnedText = if val then "Whoops, forgot" else "Learned it!"
		$scope.dateLearned = $scope.word.date_learned ? "Not yet learned"

	$scope.remove = (word)->
		Word.remove(word)

	$scope.toggleLearned = (word)->
		Word.toggleLearned(word)