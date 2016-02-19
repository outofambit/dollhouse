module.exports = (grunt) ->

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
      compile: {
        options: {
          bare: true,
          sourceMap: true,
        },
        files: {'compiled.js': '*.coffee'}
      }
    },

    connect: {
      server: {
        options: {
          port: 9001,
          # open: true,
          keepalive: true
        }
      }
    },

    watch: {
      scripts: {
        files: ['*.js', '*.html'],
        tasks: ['default'],
        options: {
          spawn: false,
          interrupt: true,
          debounceDelay: 200,
          atBegin: true
        },
      },
    },
  })

  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', ['coffee', 'connect'])
