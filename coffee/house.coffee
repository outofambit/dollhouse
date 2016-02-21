scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)

controls = new THREE.OrbitControls(camera)

renderer = new THREE.WebGLRenderer()
renderer.setSize(window.innerWidth, window.innerHeight)
document.body.appendChild(renderer.domElement)

# make the displays (boxes)
geometry = new THREE.BoxGeometry(4, 3, 0.2)
material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })

up = new THREE.Vector3( 0, 1, 0 )
ring_vertices_num = 15
ring_center = new THREE.Vector3( 0, 2, 0 )
ring_focus = new THREE.Vector3().copy(ring_center)
ring_focus.sub(ring_focus)
ray = new THREE.Vector3( 0, 0, 1 )
ring_radius = 10

for step in [0..ring_vertices_num]
  cube = new THREE.Mesh(geometry, material)
  scene.add(cube)

  step_ray = new THREE.Vector3()
  step_ray.copy ray
  step_ray.applyAxisAngle(up, Math.PI*2/ring_vertices_num*step)
  cube.translateX ring_center.x
  cube.translateY ring_center.y
  cube.translateZ ring_center.z
  cube.translateOnAxis(step_ray, ring_radius)
  cube.lookAt ring_focus

camera.position.z = 5;

render = () ->
  requestAnimationFrame(render)

  renderer.render(scene, camera)

render()
