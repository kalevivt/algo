define ['vendor/underscore', './raphael.class', 'vendor/jquery', './raphael.setfixes'], (_, RC, $) ->
  defaults =
    x: 0
    y: 0
    text: 'RecText'
    padding: 10  # Between the text and the box
    centerX: false # If true, x is taken to be the center, instead of the leftmost position
    centerY: false # If true, y is taken to be the center, instead of the topmost position
    fill_color: '#efefef'
    opacity: 1

  RC class RecText
    constructor: (@_paper, opts) ->
      opts = $.extend {}, defaults, opts

      # Support for empty boxes (rationale: we don't know the height)
      if opts.text == null or opts.text == ''
        t = @_paper.text opts.x, opts.y, 'E'
        b = t.getBBox()
        [b.width, b.x, b.y] = [0, opts.x, opts.y]
        t.remove()
      else
        t = @_paper.text opts.x, opts.y, opts.text
        b = t.getBBox()
      t.attr 'stroke-width', 0

      # Draw a rect around the text
      r = @_paper.rect opts.x, opts.y, b.width+(2*opts.padding), b.height+(2*opts.padding)
      r.translate -opts.padding-(b.width/2), -opts.padding-(b.height/2)
      r.attr {fill: opts.fill_color, 'fill-opacity': opts.opacity}
      r.toBack()

      # Make them a set
      @_set = @_paper.set()
      @_set.get('rect').add(r)
      @_set.get('text').add(t)

      # Un-center if needed (text is created with center coordinates)
      b = @getBBox()
      if not opts.centerX
        @_set.translate opts.x - b.x, 0
      if not opts.centerY
        @_set.translate 0, opts.y - b.y
    # eof constructor

    resizeX: (width) ->
        @_set.get('rect').attr 'width', width
        @_set.get('text').attr 'x', @getBBox().x

    moveTo: (x, y) ->
      [t, r] = [@_set.get('text'), @_set.get('rect')]
      @_set.attr {x: x, y: y}

    translate: (args...) -> @_set.translate args...
    getBBox: -> @_set.get('rect').getBBox()
    remove: -> @_set.remove()
