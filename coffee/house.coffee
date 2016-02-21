scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)

controls = new THREE.OrbitControls(camera)

renderer = new THREE.WebGLRenderer()
renderer.setSize(window.innerWidth, window.innerHeight)
document.body.appendChild(renderer.domElement)


zee = new THREE.Vector3( 0, 0, 1 )
up = new THREE.Vector3( 0, 1, 0 )
geometry = new THREE.BoxGeometry(1, 1, 1)
material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })

ring_vertices_num = 15

for step in [0..ring_vertices_num]
  cube = new THREE.Mesh(geometry, material)
  scene.add(cube)
  zee.applyAxisAngle(up, Math.PI*2/ring_vertices_num)  
  cube.translateOnAxis(zee, 10)

camera.position.z = 5;

render = () ->
  requestAnimationFrame(render)

  renderer.render(scene, camera)

render()
