module.exports = function (config) {
  config.set({
    basePath: '../',

    files: [
      //libs
      'vendor/assets/javascripts/angular.js',
      'vendor/assets/javascripts/angular-*.js',
      'vendor/assets/javascripts/jquery-2.0.3.js',
      'vendor/assets/javascripts/lodash.js',
      'vendor/assets/javascripts/ui-bootstrap-tpls-0.4.0.js',
      'vendor/assets/javascripts/bootstrap.js',

      'app/assets/javascripts/application.coffee',
      'app/assets/javascripts/app/**/*.coffee',

      // and our tests
      'spec/javascripts/libs/angular-mocks.js',
      'spec/javascripts/unit/**/*.coffee'
    ],

    frameworks: ['jasmine'],

    autoWatch: true,

    browsers: ['Chrome'],

    proxies: {
      '/': 'http://localhost:3000/'
    },

    junitReporter: {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    }
  });
};
