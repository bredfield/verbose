angular.module("Verbose").controller 'listCtrl', ($scope, Word, Suggestion)->
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
		Word.remove(word)

	$scope.toggleLearned = (word)->
		Word.toggleLearned(word)
