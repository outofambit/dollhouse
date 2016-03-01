
# tweens for DollScreens

retreat = (screen) ->

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: Math.PI*5/6, h: 40, d:-100 }, 3000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(1000)
    # .delay(1000 + Math.random()*250)

  tween

enclose = (screen) ->

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: 0, h: -10, d: 0 }, 1000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(300 + Math.random()*500)

  tween

surround = (screen) ->

  uno = new TWEEN.Tween(screen.tween_load)
    .to({d: -100}, 500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  dos = new TWEEN.Tween(screen.tween_load)
    .to({r: -Math.PI/2}, 750)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  tres = new TWEEN.Tween(screen.tween_load)
    .to({p: 0, h: -60, d: [0, -50, 130]}, 3000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  uno.chain(dos)
  dos.chain(tres)

  uno
