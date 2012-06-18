TimeBoard =
  init: ->
    setInterval((=> @update()), 10000)
    @update()

  update: ->
    oldString = @getDisplayString()
    newString = @getCurrentString()
    elements  = $('.message .time span')

    i = 0

    while i < newString.length
      if newString[i] != oldString[i]
        @changeElement($(elements[i]), newString[i])

      i++

    $('.message .time').data('time', newString)

  getDisplayString: ->
    $('.message .time').data('time')

  getCurrentString: ->
    newTime = new Date()

    "#{@format(newTime.getHours())}:#{@format(newTime.getMinutes())}"

  changeElement: (element, newToken) ->
    element.addClass('animate-hide')
    setTimeout((-> element.text(newToken)), 300)
    setTimeout((-> element.removeClass('animate-hide')), 400)

  format: (number) ->
    if number.toString().length == 1
      "0#{number}"
    else
      number.toString()

$ ->
  TimeBoard.init()
