
# tweens for DollScreens

# RETREAT

retreat = (screen) ->

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: Math.PI*5/6, h: 40, d:-150 }, 3000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(Math.random()*250)

  tween

retreat_leader = (screen) ->

  group_size = 7
  group_num = ((screen._rotation_in_group / (Math.PI*2)) * 15) % group_size
  group_num = Math.abs((group_size-1)/2 - group_num)

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: Math.PI*5/6, h: 40, d:-100 }, 1500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(750 + group_num*300)

  tween.delay(0) if group_num is 0

  tween

retreat_by_fives = (screen) ->

  group_num = ((screen._rotation_in_group / (Math.PI*2)) * 15) % 5

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: Math.PI*5/6, h: 40, d:-150 }, 2500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(group_num*500)

  tween

retreat_unzip = (screen) ->

  group_size = 5
  group_num = ((screen._rotation_in_group / (Math.PI*2)) * 15) % group_size
  group_num = Math.abs((group_size-1)/2 - group_num)

  tween = new TWEEN.Tween(screen.tween_load)
    .to({p: Math.PI*5/6, h: 40, d:-150 }, 2500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(group_num*750)

  tween

retreat_real = (screen) ->

  group_size = 5
  group_num = ((screen._rotation_in_group / (Math.PI*2)) * 15) % group_size
  group_num = Math.abs((group_size-1)/2 - group_num)

  tween = realisticScreenTween(screen, {p: Math.PI*5/6, h: 40, d:-150 })
    .delay(group_num*750)

  tween

# ENCLOSE

enclose = (screen) ->

  if screen.tween_load.r isnt 0

    un = new TWEEN.Tween(screen.tween_load)
      .to({p: 0, h: -10, d: -150 }, 1000)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)
      .delay(Math.random()*500)

    deux = new TWEEN.Tween(screen.tween_load)
      .to({r: 0}, 750)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)

    trois = new TWEEN.Tween(screen.tween_load)
      .to({d: -50}, 1000)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)

    un.chain deux
    deux.chain trois

    un

  else

    un = new TWEEN.Tween(screen.tween_load)
      .to({p: 0, h: -10, d: -50}, 1000)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)
      .delay(Math.random()*500)

    un

enclose_real = (screen) ->

  if screen.tween_load.r isnt 0

    un = realisticScreenTween(screen, {p: 0, h: -10, d: -150 })
      .delay(Math.random()*500)

    deux = realisticScreenTween(screen, {r: 0})

    trois = realisticScreenTween(screen, {d: -50})

    un.chain deux
    deux.chain trois

    un

  else

    un = realisticScreenTween(screen, {p: 0, h: -10, d: -50})
      .delay(Math.random()*500)

    un

# SURROUND

surround = (screen) ->

  uno = new TWEEN.Tween(screen.tween_load)
    .to({d: -150}, 1000)
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
    .to({d: 80}, 3000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  uno.chain dos
  dos.chain tres
  tres.chain quatro

  uno

surround_staggered = (screen) ->

  uno = new TWEEN.Tween(screen.tween_load)
    .to({d: -150}, 1000)
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
    .to({d: 80}, 1500)
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
    .to({d: -150}, 1000)
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
    .to({d: 80}, 1500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  uno.chain dos
  dos.chain tres, quatro

  uno

surround_leader = (screen) ->

  group_num = figureScreenGroupOrder(screen, 7)

  uno = new TWEEN.Tween(screen.tween_load)
    .to({d: -150}, 1000)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .delay(if group_num is 0 then 0 else (2000 + (group_num * 200)))

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
    .to({d: 80}, 1500)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  uno.chain dos
  dos.chain tres, quatro

  uno

surround_real = (screen) ->

  group_num = figureScreenGroupOrder(screen, 7)

  uno = realisticScreenTween(screen, {d: -150})
    .delay(if group_num is 0 then 0 else (2000 + (group_num * 200)))

  dos = realisticScreenTween(screen, {p: 0, r: -Math.PI/2})

  dt = Math.random() * 500

  tres = realisticScreenTween(screen, {h: -60})

  quatro = realisticScreenTween(screen, {d: 80})

  uno.chain dos
  dos.chain tres, quatro

  uno

# ALCOVE FORMATION

alcove_verticals = (screen) ->

  group = figureScreenGroup(screen, 7)
  group_nth = figureScreenGroupOrder(screen, 7)

  if group is 0 then enclose(screen)
  else retreat_unzip(screen)

alcove_horizontals = (screen) ->

  group = figureScreenGroup(screen, 7)
  group_nth = figureScreenGroupOrder(screen, 7)

  if group is 0 then surround_leader(screen)
  else retreat_unzip(screen)

alcove_verticals_real = (screen) ->

  group = figureScreenGroup(screen, 7)
  group_nth = figureScreenGroupOrder(screen, 7)

  if group is 0 then enclose_real(screen)
  else retreat_real(screen)

alcove_horizontals_real = (screen) ->

  group = figureScreenGroup(screen, 7)
  group_nth = figureScreenGroupOrder(screen, 7)

  if group is 0 then surround_real(screen)
  else retreat_real(screen)


# ALTERNATING SOMETHING OR ANOTHER

alternating = (screen) ->

  group_num = figureScreenGroupOrder(screen, 2)

  return_load = Object.assign({}, screen.tween_load)

  # come a little forward (or back)
  uno_to = {
    d: if group_num is 0 then return_load.d + 15 else return_load.d - 15,
    p: if group_num is 0 then return_load.p+Math.PI/18 else return_load.p-Math.PI/18
  }
  uno = new TWEEN.Tween(screen.tween_load)
    .to(uno_to, 400)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  # shake side to side
  dos = new TWEEN.Tween(screen.tween_load)
    .to({y: return_load.y+Math.PI/12, r: return_load.r+Math.PI/64}, 400)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Quadratic.InOut)

  tres = new TWEEN.Tween(screen.tween_load)
    .to({y: return_load.y-Math.PI/12, r: return_load.r-Math.PI/64}, 150)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)
    .yoyo(true)
    .repeat(3)

  # return
  quatro = new TWEEN.Tween(screen.tween_load)
    .to(return_load, 400)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  uno.chain dos
  dos.chain tres
  tres.chain quatro

  uno

# SHAKE

quick_shake = (screen) ->

  group_num = figureScreenGroupOrder(screen, 7)

  return_load = Object.assign({}, screen.tween_load)

  if group_num is 0

    # come a little forward
    uno = new TWEEN.Tween(screen.tween_load)
      .to({d: return_load.d + 30, p: screen.tween_load.p+Math.PI/6}, 400)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)

    # shake side to side
    dos = new TWEEN.Tween(screen.tween_load)
      .to({y: return_load.y+Math.PI/12}, 400)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Quadratic.InOut)

    tres = new TWEEN.Tween(screen.tween_load)
      .to({y: return_load.y-Math.PI/12}, 100)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)
      .yoyo(true)
      .repeat(5)

    # return
    quatro = new TWEEN.Tween(screen.tween_load)
      .to(return_load, 400)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)

    uno.chain dos
    dos.chain tres
    tres.chain quatro

    return uno

  new TWEEN.Tween()


quick_wave_hi = (screen) ->

  group_num = figureScreenGroupOrder(screen, 7)

  return_load = Object.assign({}, screen.tween_load)

  if group_num is 0

    # come a little forward
    uno = new TWEEN.Tween(screen.tween_load)
      .to({d: screen.tween_load.d + 30}, 400)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)

    # shake side to side
    dos = new TWEEN.Tween(screen.tween_load)
      .to({r: return_load.r+Math.PI/16}, 400)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Quadratic.InOut)

    tres = new TWEEN.Tween(screen.tween_load)
      .to({r: return_load.r-Math.PI/16}, 100)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)
      .yoyo(true)
      .repeat(7)

    # return
    quatro = new TWEEN.Tween(screen.tween_load)
      .to(return_load, 400)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)

    uno.chain dos
    dos.chain tres
    tres.chain quatro

    return uno

  new TWEEN.Tween()

quick_look = (screen) ->

  nth = figureScreenGroupOrder(screen, 7)

  return_load = Object.assign({}, screen.tween_load)

  if nth is 0

    uno = new TWEEN.Tween(screen.tween_load)
      .to(d: return_load.d + 20, 200)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)
      .delay(400)

    # come out and look to side
    dos = new TWEEN.Tween(screen.tween_load)
      .to({d: return_load.d + 60, y: return_load.y+Math.PI/4, rg: return_load.rg-Math.PI/16}, 600)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Quadratic.InOut)

    # look to other side
    tres = new TWEEN.Tween(screen.tween_load)
      .to({y: return_load.y-Math.PI/4, rg: return_load.rg+Math.PI/16}, 600)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Quadratic.InOut)
      .delay(500)

    # return
    quatro = new TWEEN.Tween(screen.tween_load)
      .to(return_load, 400)
      .onUpdate(() -> @s.updateFromTweenLoad())
      .easing(TWEEN.Easing.Cubic.InOut)
      .delay(200)

    uno.chain dos
    dos.chain tres
    tres.chain quatro

    return uno

  new TWEEN.Tween()


# GENERAL UTILITIES

realisticScreenTween = (screen, goal) ->

  start = screen.tween_load

  big_diff = 0
  for key, value of goal
    d = Math.abs(goal[key] - start[key])
    if d > big_diff then big_diff = d

  # here's a crappy hack to get reasonable speed for rotations
  if big_diff < Math.PI*2.25 and big_diff < Math.PI*2.25
    big_diff *= 25
    # yes thats a magic number

  # screen speed in cm/s
  speed = 25
  dur = big_diff/speed
  # s to ms
  dur *= 1000

  tween = new TWEEN.Tween(start)
    .to(goal, dur)
    .onUpdate(() -> @s.updateFromTweenLoad())
    .easing(TWEEN.Easing.Cubic.InOut)

  tween

figureScreenGroup = (screen, group_size) ->

  group_num = Math.floor(((screen._rotation_in_group / (Math.PI*2)) * 15) / group_size)

figureScreenGroupOrder = (screen, group_size) ->

  group_num = ((screen._rotation_in_group / (Math.PI*2)) * 15) % group_size
  group_num = Math.abs((group_size-1)/2 - group_num)

  if group_size is 2
    group_num = ((screen._rotation_in_group / (Math.PI*2)) * 15) % group_size

  group_num
