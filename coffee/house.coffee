scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)

controls = new THREE.OrbitControls(camera)

renderer = new THREE.WebGLRenderer()
renderer.setSize(window.innerWidth, window.innerHeight)
document.body.appendChild(renderer.domElement)

geometry = new THREE.BoxGeometry(1, 1, 1)
material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
cube = new THREE.Mesh(geometry, material)
scene.add(cube)

geometry2 = new THREE.BoxGeometry(1, 1, 1)
material2 = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
cube2 = new THREE.Mesh(geometry2, material2)
scene.add(cube2)

zee = new THREE.Vector3( 0, 0, 1 );
up = new THREE.Vector3( 0, 1, 0 );
zee.applyAxisAngle(up, Math.PI/2)
cube2.translateOnAxis(zee, 10)

camera.position.z = 5;

render = () ->
  requestAnimationFrame(render)

  cube.rotation.x += 0.1
  cube.rotation.y += 0.1

  renderer.render(scene, camera)

render()
