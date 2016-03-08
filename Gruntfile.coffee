module.exports = (grunt) ->

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    uglify: {
      deps: {
        files: {
          'deps.js': ['bower_components/three.js/build/three.min.js',
                      'bower_components/three.js/examples/js/controls/FlyControls.js',
                      'bower_components/tween.js/src/Tween.js',
                      'compiled.js']
        }
      }
    },

    coffee: {
      compile: {
        options: {
          bare: true,
          sourceMap: true,
        },
        files: {'compiled.js': 'coffee/*.coffee'}
      }
    },

    jade: {
      compile: {
        files: {
          "index.html": ["jade/*.jade"]
        }
      }
    },

    connect: {
      server: {
        options: {
          port: process.env.PORT || 9001,
          keepalive: true
        }
      },
      keepalive: {
        options: {
          port: 9001,
          open: true,
          keepalive: true
        }
      }
    },

    watch: {
      scripts: {
        files: ['coffee/*.coffee', 'jade/*.jade'],
        tasks: ['coffee', 'jade'],
        options: {
          spawn: true,
          interrupt: true,
          atBegin: true
        },
      },
    },

    coffee_jshint: {
      check: {
        src: ['coffee/*.coffee']
      }
    },

    concurrent: {
      dev: ['watch', 'connect:server']
    }

  })

  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-jade');
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-coffee-jshint')
  grunt.loadNpmTasks('grunt-concurrent')
  grunt.loadNpmTasks('grunt-contrib-uglify');

  grunt.registerTask('default', ['coffee', 'uglify', 'jade', 'connect:keepalive'])
  grunt.registerTask('dev', ['concurrent:dev'])
  grunt.registerTask('heroku', ['coffee', 'uglify', 'jade', 'connect:server'])
