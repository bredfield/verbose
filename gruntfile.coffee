module.exports = (grunt) ->
  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    karma:
      unit:
        configFile: "config/karma.conf.js"
        singleRun: false
    watch:
      tests:
        files: ["app/assets/javascripts/tests/**/*.coffee"]
        tasks: ["coffee:tests"]
  
  # Load the plugins
  grunt.loadNpmTasks "grunt-karma"
  
  # Tasks
  grunt.registerTask "default", ["watch"]