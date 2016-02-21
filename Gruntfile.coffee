module.exports = (grunt) ->

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
      compile: {
        options: {
          bare: true,
          sourceMap: true,
        },
        files: {'compiled.js': 'coffee/*.coffee'}
      }
    },

    connect: {
      server: {
        options: {
          port: 9001,
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
        files: ['coffee/*.coffee', '*.html'],
        tasks: ['coffee', 'connect:server'],
        options: {
          spawn: true,
          interrupt: true,
          debounceDelay: 200,
          atBegin: true
        },
      },
    },

    coffee_jshint: {
      options: {
        
      },
      check: {
        src: ['coffee/*.coffee']
      }
    }

  })

  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-coffee-jshint');

  grunt.registerTask('default', ['coffee', 'connect:keepalive'])
