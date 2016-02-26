
# A screen in the dollhouse
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
    material = new THREE.MeshPhongMaterial({
                color: 0x000000,
                specular: 0x434343,
                shininess: 40,
                side: THREE.FrontSide,
                shading: THREE.SmoothShading,
              })

    @mesh = new THREE.Mesh(geometry, material)
    @mount.add @mesh

    # for the actual screen part of the screen
    screen_geom = new THREE.PlaneGeometry(121, 68)
    screen_mat = new THREE.MeshPhongMaterial({
                  color: 0xffffff,
                  specular: 0x1e1e1e,
                  shininess: 10,
                  side: THREE.FrontSide,
                  shading: THREE.FlatShading
                })

    @screen = new THREE.Mesh(screen_geom, screen_mat)
    @screen.translateZ(1.5)
    @mesh.add @screen

  setupPosition: (@_group_center, radius, @_rotation_in_group) ->
    @mount.translateX @_group_center.x
    @mount.translateY @_group_center.y
    @mount.translateZ @_group_center.z
    @_group_center_ray = new THREE.Vector3(0, 0, -1)
    @_group_center_ray.applyAxisAngle(new THREE.Vector3(0, 1, 0), @_rotation_in_group)
    @mount.translateOnAxis(@_group_center_ray, ring_radius)
    @mount.lookAt @_group_center
    @tween_load = {
      s: @,
      p: @mesh.rotation.x,
      h: @mesh.position.y
      d: @mesh.position.z
    }

  setupTexture: (path) ->
    loader = new THREE.TextureLoader()
    @screen.material.map = loader.load(path)

  setScreenDepth: (amount) -> @mesh.position.z = amount

  setScreenHeight: (amount) -> @mesh.position.y = amount

  setScreenYaw: (amount) -> @mesh.rotation.y = amount

  setScreenPitch: (amount) -> @mesh.rotation.x = amount

# tweens for DollScreens

retreat = (screen) ->

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: Math.PI*5/6, h: 40, d:-100 }, 3000)
    .onUpdate(() ->
      @s.setScreenPitch @p
      @s.setScreenHeight @h
      @s.setScreenDepth @d
      )
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(Math.random()*250)

  tween

enclose = (screen) ->

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: 0, h: -10, d: 0 }, 1000)
    .onUpdate(() ->
      @s.setScreenPitch @p
      @s.setScreenHeight @h
      @s.setScreenDepth @d
      )
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(300 + Math.random()*500)

  tween
