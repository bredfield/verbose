angular.module("Verbose").controller 'detailCtrl', ($scope, $state, Word)->
	##pull word based on state param
	$scope.word = Word.get(id:$state.params.wordId)

	$scope.dateLearned = $scope.word.date_learned ? "Not yet learned"

	##watch learned toggle for button and date text
	$scope.$watch "word.learned", (val)=>
		$scope.learnedText = if val then "Whoops, forgot" else "Learned it!"
		$scope.dateLearned = $scope.word.date_learned ? "Not yet learned"
	
	$scope.remove = (word)->
		##Delete word & switch to index view
		Word.remove {id:word.id}, ()->
			$state.transitionTo('index')

	$scope.toggleLearned = (word)->
		Word.toggleLearned(word)