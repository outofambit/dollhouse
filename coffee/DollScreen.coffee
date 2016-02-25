class DollScreen

  mesh = null
  screen = null
  _group_center = new THREE.Vector3(0, 0, 0)
  _focal_point = new THREE.Vector3(0, 0, 0)
  _group_center_ray = new THREE.Vector3(0, 0, 0)

  constructor: () ->
    # our rotational mount
    @mount = new THREE.Object3D()

    # for the main chunk of the screen
    geometry = new THREE.BoxGeometry(123, 70, 2)
    material = new THREE.MeshLambertMaterial({
                color: 0x101010,
                side: THREE.FrontSide,
              })

    @mesh = new THREE.Mesh(geometry, material)
    @mount.add @mesh

    # for the actual screen part of the screen
    screen_geom = new THREE.PlaneGeometry(121, 68)
    screen_mat = new THREE.MeshPhongMaterial({
                  color: 0xffffff,
                  side: THREE.FrontSide,
                  shading: THREE.FlatShading
                })

    @screen = new THREE.Mesh(screen_geom, screen_mat)
    @screen.translateZ(1.5)
    @mesh.add @screen

  setupPosition: (@_group_center, radius, rotation) ->
    @mount.translateX @_group_center.x
    @mount.translateY @_group_center.y
    @mount.translateZ @_group_center.z
    @_group_center_ray = new THREE.Vector3(0, 0, -1)
    @_group_center_ray.applyAxisAngle(new THREE.Vector3(0, 1, 0), rotation)
    @mount.translateOnAxis(@_group_center_ray, ring_radius)
    @mount.lookAt @_group_center

  setupTexture: (path) ->
    loader = new THREE.TextureLoader()
    @screen.material.map = loader.load(path)

  setScreenDepth: (amount) -> @mesh.position.z = amount

  setScreenHeight: (amount) -> @mesh.position.y =  amount

  setScreenYaw: (amount) -> @mesh.rotation.y = amount

  setScreenPitch: (amount) -> @mesh.rotation.x = amount
