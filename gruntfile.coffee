module.exports = (grunt) ->
  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    assetsRoot: "app/assets" #"assets"
    concat:
      dist:
        #Libraries go Here
        src: [
          "<%= assetsRoot %>/javascripts/libs/jquery-2.0.3.js", 
          '<%= assetsRoot %>/javascripts/libs/lodash.js',
          "<%= assetsRoot %>/javascripts/libs/angular.js",
          '<%= assetsRoot %>/javascripts/libs/angular-ui-router.js',
          '<%= assetsRoot %>/javascripts/libs/angular-resource.js',
          '<%= assetsRoot %>/javascripts/libs/ui-bootstrap-tpls-0.4.0.js',
          '<%= assetsRoot %>/javascripts/libs/bootstrap.js',
          '<%= assetsRoot %>/javascripts/libs/swipe.js',
          '<%= assetsRoot %>/javascripts/libs/store.js',
          "<%= assetsRoot %>/javascripts/app/<%= pkg.name %>.js"
        ]
        dest: "<%= assetsRoot %>/javascripts/application.js"
    uglify:
      options:
        banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
      build:
        src: "<%= assetsRoot %>/javascripts/application.js"
        dest: "<%= assetsRoot %>/javascripts/application.js"
    less:
      development:
        options:
          paths: ["<%= assetsRoot %>/stylesheets"]
        files:
          "<%= assetsRoot %>/stylesheets/application.css": "<%= assetsRoot %>/stylesheets/<%= pkg.name %>.less"
      production:
        options:
          paths: ["<%= assetsRoot %>/stylesheets"]
          yuicompress: true
        files:
          "style.css": "<%= assetsRoot %>/stylesheets/style.less"
    coffee:
      scripts:
        files:    
          "<%= assetsRoot %>/javascripts/app/<%= pkg.name %>.js": [
            #Extra app .coffee files go here
            "<%= assetsRoot %>/javascripts/app/<%= pkg.name %>.coffee",
            "<%= assetsRoot %>/javascripts/app/**/*.coffee"
          ]
      tests:
        files:
          "<%= assetsRoot %>/javascripts/tests/unit/main.js": "<%= assetsRoot %>/javascripts/tests/unit/**/*.coffee"
    karma:
      unit:
        configFile: "assets/javascripts/tests/karma.conf.js"
        singleRun: false
    watch:
      scripts:
        files: "<%= assetsRoot %>/javascripts/**/*.coffee"
        tasks: ["coffee:scripts", "concat"]
      tests:
        files: ["<%= assetsRoot %>/javascripts/tests/**/*.coffee"]
        tasks: ["coffee:tests"]
      styles:
        files: "<%= assetsRoot %>/stylesheets/**/*.less"
        tasks: ["less:development"]
  
  # Load the plugins
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-karma"
  
  # Tasks
  grunt.registerTask "default", ["reset"]
  grunt.registerTask "reset", ["coffee", "concat", "less:development", "watch"]
  grunt.registerTask "launch", ["uglify", "less:production"]