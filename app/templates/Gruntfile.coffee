'use strict';

module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig
    # include package.json
    pkg: grunt.file.readJSON 'package.json'

    # Watching File chages, moves, deletes, and run appropriate tasks
    watch:
      options:
        livereload: true
        # interval: 5007
        # interrupt: true
      html:
        files: ['develop/*.html', 'release/*.html']
      image:
        files: ['develop/**/*.{gif,jpeg,jpg,png,svg,webp}']
      sass:
        files: ['develop/sass/*.{sass,scss}']
        tasks: ['sass:develop']
      coffee:
        files: ['develop/coffee/*.coffee']
        tasks: ['coffee:release']
      css:
        files: ['develop/css/*.css','!develop/css/<%= pkg.name %>.css']
        tasks: ['concat:css','autoprefixer:develop','csscomb:develop']
      js:
        files: ['develop/js/*.js','!develop/js/<%= pkg.name %>.js']
        tasks: ['concat:js']

    # Launch local server. Root folder is /develop and /release
    connect:
      dev:
        options:
          hostname: '*'
          port: 9001,
          base: 'develop'
      openDev:
        options:
          hostname: '*'
          port: 9001,
          base: 'develop'
          open: 'http://localhost:9001/'
      release:
        options:
          hostname: '*'
          port: 9002,
          base: 'release'
      openRelease:
        options:
          hostname: '*'
          port: 9002,
          base: 'release'
          open: 'http://localhost:9002/'

    # Add to vendor-prefixed CSS properties following your setting
    autoprefixer:
      options:
        browsers: ['last 3 version','android 4']
      develop:
        src: 'develop/css/<%= pkg.name %>.css'
        dest: 'develop/css/<%= pkg.name %>.css'
      release:
        src: 'release/css/<%= pkg.name %>.css'
        dest: 'release/css/<%= pkg.name %>.css'

    # Sort CSS properties
    csscomb:
      options:
        config: '.csscombrc'
      develop:
        files:
          'develop/css/<%= pkg.name %>.css': ['develop/css/<%= pkg.name %>.css']
      release:
        files:
          'release/css/<%= pkg.name %>.css': ['release/css/<%= pkg.name %>.css']

    # Minify CSS files with CSSO
    csso:
      release:
        files:
          'release/css/<%= pkg.name %>.min.css': ['release/css/<%= pkg.name %>.css']

    # Compile SCSS to CSS using compass library
    compass:
      develop:
        options:
          config: 'config.rb'
          environment: 'development'

    sass:
      develop:
        options:
          sourceComments: 'normal'
        files: [
          expand: true
          cwd: 'develop/sass/'
          src: ['**/*.{sass,scss}']
          dest: 'develop/css/'
          ext: '.css'
        ]
      release:
        options:
          sourceComments: 'none'
          outputStyle: 'compressed'
        files: [
          expand: true
          cwd: 'develop/sass/'
          src: ['**/*.{sass,scss}']
          dest: 'release/css/'
          ext: '.css'
        ]

    # Compile Coffeescript to Javascript
    coffee:
      release:
        files: [
          expand: true
          cwd: 'develop/coffee/'
          src: ['**/*.coffee']
          dest: 'develop/js/'
          ext: '.js'
        ]

    # Minify js file
    uglify:
      js:
        src: 'release/js/<%= pkg.name %>.js',
        dest: 'release/js/<%= pkg.name %>.min.js'


    # Combine some js files to one files
    concat:
      css:
        src: ['develop/css/*.css','!develop/css/<%= pkg.name %>.css'],
        dest: 'develop/css/<%= pkg.name %>.css'
      js:
        #Options:
        #separator: ';'
        src: ['develop/js/*.js','!develop/js/<%= pkg.name %>.js'],
        dest: 'develop/js/<%= pkg.name %>.js'
      release:
        src: ['release/css/*.css','!release/css/<%= pkg.name %>.css'],
        dest: 'release/css/<%= pkg.name %>.css'

    # Copy all files when release command run
    copy:
      release:
        files: [
          expand: true
          cwd: 'develop/'
          src: ['**','!sass/*','!coffee/*','!*.html','!*.rb','!.*','!.*/**','!*.bak']
          dest: 'release/'
        ]

    # Change include css and js file name in html when compile release build
    processhtml:
      release:
        options:
          process: false
        files: [
          expand: true
          cwd: 'develop/'
          src: ['**/*.html']
          dest: 'release/'
          ext: '.html'
        ]



    # Clean /release folder
    clean:
      release:
        'release/*'
      afterClean: [
        'release/{coffee,sass,scss}'
        'release/css/*.css'
        '!release/css/*<%= pkg.name %>*.css'
        'release/js/*.js'
        '!release/js/*<%= pkg.name %>*.js'
      ]

    # Project configuration end

  # Loading plugins
  # Remember your installed grunt plugins must be written here
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-csscomb'
  grunt.loadNpmTasks 'grunt-csso'
  grunt.loadNpmTasks 'grunt-sass'
  grunt.loadNpmTasks 'grunt-processhtml'

  # Regist grunt tasks
  grunt.registerTask 'default', ['connect:openDev','watch']
  grunt.registerTask 'keep', ['watch']
  grunt.registerTask 'k', ['watch']

  # Manual compile
  grunt.registerTask 'sc', ['sass:develop','concat:css','autoprefixer:develop','csscomb:develop']
  grunt.registerTask 'co', ['coffee:release','concat:js']
  grunt.registerTask 'compile', ['sass','concat:css','autoprefixer:develop','csscomb:develop','coffee:release','concat:js']
  grunt.registerTask 'c', ['sass:develop','concat:css','autoprefixer:develop','csscomb:develop','coffee:release','concat:js']

  # Useful command when you modyfy css or js file directly
  grunt.registerTask 'css', ['concat:css','autoprefixer:develop','csscomb:develop']
  grunt.registerTask 'js', ['concat:js']

  # Open a local server page
  grunt.registerTask 'web', ['connect:openDev','connect:openRelease','watch']
  grunt.registerTask 'webd', ['connect:openDev','watch']
  grunt.registerTask 'webr', ['connect:openRelease','watch']

  # Release command
  grunt.registerTask 'release', ['clean:release','copy:release','processhtml','sass:release','concat:release','autoprefixer:release','csso','uglify:js','clean:afterClean']

  # Delete all files related to release
  grunt.registerTask 'swipe', ['clean:release']