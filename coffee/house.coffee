
# assumes threejs and tween js have been included prior

clock = new THREE.Clock()
scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 2000)

controls = new THREE.FlyControls(camera)
controls.movementSpeed = 500
controls.rollSpeed = Math.PI / 12
controls.dragToLook = true

renderer = new THREE.WebGLRenderer({antialias: true})
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
floor_geom = new THREE.PlaneGeometry(1000, 1000)
floor_mat = new THREE.MeshLambertMaterial({
                  color: 0x202020,
                  side: THREE.DoubleSide,
                })
floor_mesh = new THREE.Mesh( floor_geom, floor_mat )
floor_mesh.lookAt up
floor_mesh.receiveShadow = true
scene.add floor_mesh

ceil_mesh = new THREE.Mesh( floor_geom, floor_mat )
ceil_mesh.position.y = 350
floor_mesh.receiveShadow = true
ceil_mesh.lookAt up
scene.add ceil_mesh

# make the displays (boxes)
displays = []
ring_vertices_num = 15
# default height
# ring_center = new THREE.Vector3( 0, 163.8, 0 )
ring_center = new THREE.Vector3( 0, 200, 0 )
ring_focus = new THREE.Vector3(0, 0, 0)
ring_focus.copy(ring_center)
ring_radius = 360

for step in [0..ring_vertices_num-1]

  ds = new DollScreen()
  scene.add ds.mount
  displays.push ds
  ds.setupPosition(ring_center, ring_radius, Math.PI*2/ring_vertices_num*step)
  ds.setupTexture('media/neko.png')
  # ds.setupTexture('media/slice' + (step+1) + '.png')

  # kick off an animation
  tween_load = {p: Math.PI/8, h: 0, step: step}
  tween = new TWEEN.Tween(tween_load)
    .to({p: -Math.PI/8, h: -20 }, 2000)
    .onUpdate(() ->
      displays[this.step].setScreenPitch @p
      displays[this.step].setScreenHeight @h
      )
    .easing(TWEEN.Easing.Cubic.InOut)
    .repeat(Infinity)
    .yoyo(true)
    .start(1000 + step*500)

camera.position.y = 100

render = () ->
  requestAnimationFrame(render)
  renderer.render(scene, camera)

animate = (time) ->
  requestAnimationFrame(animate)
  TWEEN.update(time)

  delta = clock.getDelta()
  controls.update(delta)

animate()
render()
