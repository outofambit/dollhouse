# assumes threejs

window.addEventListener('keydown', () ->
  console.log(camera.position)
  console.log(camera.rotation)
)

# here's our different positions
locales = [
  # middle eye level
  {
    position: [1, 140, 1]
    rotation: [0, 0, 0]
  }
  # looking down from corner
  {
    position: [419, 352, 319]
    rotation: [-.625, .847, .459]
  }
  # top looking down
  {
    position: [1, 856.9524999999999, 1]
    rotation: [-1.6043950065654842, 0, 0]
  }
]

adoptLocale = (cam, locale) ->
  if locale.position? then cam.position.set(locale.position[0], locale.position[1], locale.position[2])
  if locale.rotation? then cam.setRotationFromEuler(new THREE.Euler(locale.rotation[0], locale.rotation[1], locale.rotation[2]))

setTimeout(()->
  adoptLocale(camera, locales[0])
, 5000)
