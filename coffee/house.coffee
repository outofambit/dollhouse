scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 2000)

controls = new THREE.OrbitControls(camera)

renderer = new THREE.WebGLRenderer()
renderer.setSize(window.innerWidth, window.innerHeight)
document.body.appendChild(renderer.domElement)

# lighting
ambientLight = new THREE.AmbientLight( 0x000000 )
scene.add(ambientLight)
lights = []
lights[0] = new THREE.PointLight( 0xffffff, 1, 0 )
lights[1] = new THREE.PointLight( 0xffffff, 1, 0 )
lights[2] = new THREE.PointLight( 0xffffff, 1, 0 )

lights[0].position.set( 0, 500, 0 )
lights[1].position.set( 1000, 2000, 100 )
lights[2].position.set( -1000, -2000, -1000 )

scene.add( lights[0] )
scene.add( lights[1] )
scene.add( lights[2] )

up = new THREE.Vector3( 0, 1, 0 )

# ALL MEASUREMENTS IN CM

# floor of the room
floor_geom = new THREE.PlaneGeometry(1000, 1000)
floor_mat = new THREE.MeshLambertMaterial({
                  color: 0x202020,
                  side: THREE.DoubleSide,
                  shading: THREE.FlatShading,
                })
floor_mesh = new THREE.Mesh( floor_geom, floor_mat );
floor_mesh.lookAt up
scene.add floor_mesh

# make the displays (boxes)
geometry = new THREE.BoxGeometry(122.7, 71.9, 5.1)
material = new THREE.MeshLambertMaterial({
            color: 0x101010,
            specular: 0x414141,
            shininess: 10,
            side: THREE.FrontSide,
            shading: THREE.FlatShading
          })

# for the actual screen part of the display
screen_geom = new THREE.PlaneGeometry(121.6, 68.6)
screen_mat = new THREE.MeshPhongMaterial({
              color: 0x101010,
              shininess: 90,
              side: THREE.FrontSide,
              shading: THREE.FlatShading
            })

ring_vertices_num = 15
ring_center = new THREE.Vector3( 0, 163.8, 0 )
ring_focus = new THREE.Vector3().copy(ring_center)
# ring_focus.sub(ring_focus)
ray = new THREE.Vector3( 0, 0, 1 )
ring_radius = 586/2

for step in [0..ring_vertices_num]
  cube = new THREE.Mesh(geometry, material)
  scene.add(cube)

  flat = new THREE.Mesh(screen_geom, screen_mat)
  flat.translateZ(3)
  cube.add flat

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
