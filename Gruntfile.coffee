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
        tasks: ['coffee'],
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
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-coffee-jshint')
  grunt.loadNpmTasks('grunt-concurrent')

  grunt.registerTask('default', ['coffee', 'connect:keepalive'])
  grunt.registerTask('dev', ['concurrent:dev'])
