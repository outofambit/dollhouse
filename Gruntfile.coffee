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

  grunt.registerTask('default', ['coffee', 'jade', 'connect:keepalive'])
  grunt.registerTask('dev', ['concurrent:dev'])
