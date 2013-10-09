Verbose = angular.module("Verbose")
Verbose.filter "capitalize", ()->
	return (text)->
		if text? then text.charAt(0).toUpperCase() + text.slice(1)