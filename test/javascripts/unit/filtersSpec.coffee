describe 'VERBOSE FILTERS', ()->
  console.log "=========Starting filter Specs============"
  #SETUP
  beforeEach ()->
    module('Verbose')

    @addMatchers
      toEqualData: (expected)->
        angular.equals(@actual, expected)
  
  describe "CAPITALIZE",()->
    capitalize = ""

    beforeEach inject ($filter)->
      ##Set up necessary mocks
      capitalize = $filter('capitalize')

    it 'Should capitalize the first letter', ()->
      expect(capitalize("test")).toBe("Test")

    it 'Should gracefully handle undefined', ()->
      expect(capitalize(undefined)).toBe(undefined)