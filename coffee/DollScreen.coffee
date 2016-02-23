class DollScreen

  @_mesh = null
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

    @_mesh = new THREE.Mesh(geometry, material)

    # for the actual screen part of the screen
    screen_geom = new THREE.PlaneGeometry(121.6, 68.6)
    screen_mat = new THREE.MeshPhongMaterial({
                  color: 0x101010,
                  shininess: 90,
                  side: THREE.FrontSide,
                  shading: THREE.FlatShading
                })

    flat = new THREE.Mesh(screen_geom, screen_mat)
    flat.translateZ(3)
    console.log(flat)
    @_mesh.add flat

  setupPosition: (@_group_center, radius, rotation) ->
    @_mesh.translateX @_group_center.x
    @_mesh.translateY @_group_center.y
    @_mesh.translateZ @_group_center.z
    @_group_center_ray = new THREE.Vector3(0, 0, 1)
    @_group_center_ray.applyAxisAngle(new THREE.Vector3(0, 1, 0), rotation)
    @_mesh.translateOnAxis(@_group_center_ray, ring_radius)
    @_mesh.lookAt @_group_center

  translateAlongCenterRay: (amount) -> @_mesh.translateOnAxis @_group_center_ray amount
