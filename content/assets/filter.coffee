# trim whitespace
trim = (s) -> (s || '').replace(/^\s+|\s+$/g, '')

# filter by a regular expression, case-insensitive
$.expr[":"].contains = $.expr.createPseudo (arg) ->
    (elem) ->
        $(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0

filter = (term, updateBox) ->
    if updateBox
        $("#filter-search").val(term)

    if term == ""
        window.history.replaceState("", "", window.originalURL)
    else
#        if window.originalURL != "http://amazing-aces-bs.de/blog"
        window.location.href = window.originalURL+"#"+term
#        else
        window.history.replaceState("", "", window.originalURL+"#"+term)

    if term == ""
        $("#content .box").show()
        $("#content .boxes").show() #.prev().show()
    else
        $("#content .box").hide()

        ors = term.split("|")
        for o in ors
            o = trim(o)
            ands = o.split(" ")
            boxes = $("#content .box")
            for a in ands
                a = trim(a)
                boxes = boxes.has(":contains("+a+")")
            boxes.show()

        $("#content .boxes").show() #.prev().show()
        $("#content .boxes").not(":has(:visible)").hide() #.prev().hide()

$ ->
    window.originalURL = window.location.pathname

    $(window).on "hashchange", ->
        term = window.location.hash.substr(1)
        hash = decodeURIComponent(term)
        filter(hash, true)

    $("#filter-search").keyup (e) ->
        filter($("#filter-search").val(), false)

    $(window).trigger("hashchange")
