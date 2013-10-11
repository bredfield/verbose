angular.module("Verbose").controller 'listCtrl', ($scope, Word)->
	##pull word data from backend
	$scope.words = Word.index()

	##setup scopes
	$scope.orderProp = 
		$:"-created_at"

	$scope.query =
		learned:false

	##if on learned pane, change learned button text
	$scope.$watch "query.learned", (val)=>
		$scope.learnedText = if $scope.query.learned then "Whoops, forgot" else "Learned it!"

	$scope.remove = (word)->
		##pos of word in scope
		index = $scope.words.indexOf(word)

		console.log Word.remove {id:word.id},()->
			##if delete is succesful, remove from UI
			$scope.words.splice(index,1)

	$scope.toggleLearned = (word)->
		Word.toggleLearned(word)
