# Load CSS files asynchronously

define ['vendor/jquery'], ($) ->
    (urls...) ->
        $ ->
            for url in urls then do (url) ->
                $('head').append($('<link>').attr(
                    type: 'text/css'
                    rel: 'stylesheet'
                    href: "stylesheets/#{url}.css"
                ))
