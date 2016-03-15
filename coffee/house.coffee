
# assumes threejs and tweenjs have been included prior

clock = new THREE.Clock()
scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(90, window.innerWidth / window.innerHeight, 0.1, 2000)

controls = new THREE.FlyControls(camera)
controls.movementSpeed = 500
controls.rollSpeed = Math.PI / 3
controls.dragToLook = true

orient_controls = new THREE.DeviceOrientationControls(camera)
orient_controls_update = false

renderer = new THREE.WebGLRenderer({antialias: true})
renderer.setClearColor(0xeeeeee, 1)
renderer.setSize(window.innerWidth, window.innerHeight)
document.body.appendChild(renderer.domElement)

# lighting
ambientLight = new THREE.AmbientLight( 0xffffff )
scene.add(ambientLight)
lights = []
lights[0] = new THREE.PointLight( 0xffffff, 0.25, 0 )
lights[0].position.set( 0, 340, 0 )
scene.add( lights[0] )

up = new THREE.Vector3( 0, 1, 0 )

# ALL MEASUREMENTS IN CM

# floor of the room
floor_geom = new THREE.PlaneGeometry(100000, 100000)
floor_mat = new THREE.MeshLambertMaterial({
                  color: 0xcccccc,
                  side: THREE.DoubleSide,
                })
floor_mesh = new THREE.Mesh( floor_geom, floor_mat )
floor_mesh.lookAt up
floor_mesh.receiveShadow = true
scene.add floor_mesh

ring_radius = 257

rail_geom = new THREE.TorusGeometry( ring_radius, 3, 6, 120 )
rail_mat = new THREE.MeshPhongMaterial({
                  color: 0x909090,
                  specular: 0xdddddd,
                  shininess: 60,
                  side: THREE.FrontSide,
                  shading: THREE.SmoothShading,
                })
rail_mesh = new THREE.Mesh(rail_geom, rail_mat)
rail_mesh.position.y = 260
rail_mesh.receiveShadow = true
rail_mesh.castShadow = true
rail_mesh.lookAt up
scene.add rail_mesh

# make the displays (boxes)
displays = []
ring_vertices_num = 15
# default height
# ring_center = new THREE.Vector3( 0, 163.8, 0 )
ring_center = new THREE.Vector3( 0, 200, 0 )
ring_focus = new THREE.Vector3(0, 0, 0)
ring_focus.copy(ring_center)

for step in [0..ring_vertices_num-1]

  ds = new DollScreen()
  scene.add ds.mount
  displays.push ds
  ds.setupPosition(ring_center, ring_radius, Math.PI*2/ring_vertices_num*step)
  # ds.setupTexture('media/neko.png')
  ds.setupTexture('media/slice' + (step+1) + '.png')

for display in displays
  enclose(display).start()

camera.position.y = 140

# event handlers

document.getElementById('surround-btn').onclick = () ->
  for display in displays
    surround_leader(display).start()

document.getElementById('enclose-btn').onclick = () ->
  for display in displays
    enclose(display).start()

document.getElementById('retreat-btn').onclick = () ->
  for display in displays
    retreat_leader(display).start()

document.getElementById('alcen-btn').onclick = () ->
  for display in displays
    alcove_verticals(display).start()

document.getElementById('alcsur-btn').onclick = () ->
  for display in displays
    alcove_horizontals(display).start()

document.getElementById('alt-btn').onclick = () ->
  for display in displays
    alternating(display).start()

document.getElementById('shake-btn').onclick = () ->
  for display in displays
    quick_shake(display).start()

document.getElementById('wave-btn').onclick = () ->
  for display in displays
    quick_wave_hi(display).start()

document.getElementById('look-btn').onclick = () ->
  for display in displays
    quick_look(display).start()

window.addEventListener( 'deviceorientation', () ->
    orient_controls_update = true
  , false );

render = () ->
  requestAnimationFrame(render)
  renderer.render(scene, camera)

animate = (time) ->
  requestAnimationFrame(animate)
  TWEEN.update(time)

  delta = clock.getDelta()
  controls.update(delta)
  if orient_controls_update then orient_controls.update()

animate()
render()
