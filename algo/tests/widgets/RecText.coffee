define ['vendor/qunit', 'vendor/raphael', 'cs!widgets/RecText'], (T, R) ->
  T.module 'RecText',
    setup: ->
      @p = R('testpaper')
    teardown: ->
      @p.remove()

  T.test 'Should have a set with "rect" and "text" fields', ->
    r = @p.RecText()
    T.equal r._set.type, 'set'
    T.equal r._set.get('rect', 0).type, 'rect'
    T.equal r._set.get('text', 0).type, 'text'

  T.test 'Should be able to create with top-left coordinates', ->
    r = @p.RecText
      x: 20
      y: 30
    b = r.getBBox()
    T.equal b.x, 20
    T.equal b.y, 30

  T.test 'Should be able to create with center coordinates', ->
    x = @p.RecText
      x: 20
      y: 30
      centerX: true
    b = x.getBBox()
    T.equal b.y, 30
    T.equal b.x, (20 - b.width/2), 'centerX'

    y = @p.RecText
      x: 20
      y: 30
      centerY: true
    b = y.getBBox()
    T.equal b.x, 20
    T.equal b.y, (30 - b.height/2), 'centerY'

  T.test 'Translate should move the RecText', ->
    r = @p.RecText
      x: 30
      y: 35
    r.translate 40, 50
    b = r.getBBox()
    T.equal b.x, 70
    T.equal b.y, 85