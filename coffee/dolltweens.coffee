
# tweens for DollScreens

retreat = (screen) ->

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: Math.PI*5/6, h: 40, d:-100 }, 3000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(Math.random()*250)

  tween

enclose = (screen) ->

  if screen.tween_load.r isnt 0

    un = new TWEEN.Tween(screen.tween_load)
      .to({p: 0, h: -10, d: -100 }, 1000)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)
      .delay(Math.random()*500)

    deux = new TWEEN.Tween(screen.tween_load)
      .to({r: 0}, 750)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)

    trois = new TWEEN.Tween(screen.tween_load)
      .to({d: 0}, 1000)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)

    un.chain deux
    deux.chain trois

    un

  else

    un = new TWEEN.Tween(screen.tween_load)
      .to({p: 0, h: -10, d: 0}, 1000)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)
      .delay(Math.random()*500)

    un


surround = (screen) ->

  uno = new TWEEN.Tween(screen.tween_load)
    .to({d: -100}, 1000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  dos = new TWEEN.Tween(screen.tween_load)
    .to({p: 0, r: -Math.PI/2}, 1000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  tres = new TWEEN.Tween(screen.tween_load)
    .to({h: -60}, 1500 + Math.random() * 500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  quatro = new TWEEN.Tween(screen.tween_load)
    .to({d: 130}, 3000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  uno.chain dos
  dos.chain tres
  tres.chain quatro

  uno

surround_staggered = (screen) ->

  uno = new TWEEN.Tween(screen.tween_load)
    .to({d: -100}, 1000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  dos = new TWEEN.Tween(screen.tween_load)
    .to({p: 0, r: -Math.PI/2}, 1000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  dt = Math.random() * 500

  tres = new TWEEN.Tween(screen.tween_load)
    .to({h: -60}, 1000 + dt)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  dt = -dt + 500
  dt += screen._rotation_in_group/Math.PI*2 * 300

  quatro = new TWEEN.Tween(screen.tween_load)
    .to({d: 130}, 1500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(dt)

  uno.chain dos
  dos.chain tres
  tres.chain quatro

  uno

surround_halves = (screen) ->

  base_dt = 0 if screen._rotation_in_group > Math.PI
  base_dt = 2000 if screen._rotation_in_group < Math.PI

  uno = new TWEEN.Tween(screen.tween_load)
    .to({d: -100}, 1000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(base_dt)

  dos = new TWEEN.Tween(screen.tween_load)
    .to({p: 0, r: -Math.PI/2}, 1000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  dt = Math.random() * 500

  tres = new TWEEN.Tween(screen.tween_load)
    .to({h: -60}, 1000 + dt)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  quatro = new TWEEN.Tween(screen.tween_load)
    .to({d: 130}, 1500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  uno.chain dos
  dos.chain tres, quatro

  uno
