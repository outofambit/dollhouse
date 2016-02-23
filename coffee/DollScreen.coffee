class DollScreen

  mesh = null
  screen = null
  _group_center = new THREE.Vector3(0, 0, 0)
  _focal_point = new THREE.Vector3(0, 0, 0)
  _group_center_ray = new THREE.Vector3(0, 0, 0)

  constructor: () ->
    # for the main chunk of the screen
    geometry = new THREE.BoxGeometry(122.7, 71.9, 5.1)
    material = new THREE.MeshLambertMaterial({
                color: 0x101010,
                side: THREE.FrontSide,
              })

    @mesh = new THREE.Mesh(geometry, material)

    # for the actual screen part of the screen
    screen_geom = new THREE.PlaneGeometry(121.6, 68.6)
    screen_mat = new THREE.MeshPhongMaterial({
                  color: 0xffffff,
                  side: THREE.FrontSide,
                  shading: THREE.FlatShading
                })

    @screen = new THREE.Mesh(screen_geom, screen_mat)
    @screen.translateZ(3)
    @mesh.add @screen

  setupPosition: (@_group_center, radius, rotation) ->
    @mesh.translateX @_group_center.x
    @mesh.translateY @_group_center.y
    @mesh.translateZ @_group_center.z
    @_group_center_ray = new THREE.Vector3(0, 0, 1)
    @_group_center_ray.applyAxisAngle(new THREE.Vector3(0, 1, 0), rotation)
    @mesh.translateOnAxis(@_group_center_ray, ring_radius)
    @mesh.lookAt @_group_center

  setupTexture: (path) ->
    loader = new THREE.TextureLoader()
    @screen.material.map = loader.load(path)

  translateAlongCenterRay: (amount) -> @mesh.translateOnAxis @_group_center_ray amount
