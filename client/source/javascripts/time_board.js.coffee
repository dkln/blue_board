TimeBoard =
  init: ->
    setInterval((=> @update()), 10000)
    @update()

  update: ->
    oldString = @getDisplayString()
    newString = @getCurrentString()
    elements  = $('.message .time span')

    i = 0
    changedIndex = 0

    while i < newString.length
      if newString[i] != oldString[i]
        @changeElement(changedIndex, $(elements[i]), newString[i])
        changedIndex++

      i++

    $('.message .time').data('time', newString)

  getDisplayString: ->
    $('.message .time').data('time')

  getCurrentString: ->
    newTime = new Date()

    "#{@format(newTime.getHours())}:#{@format(newTime.getMinutes())}"

  changeElement: (index, element, newToken) ->
    setTimeout((-> element.addClass('animate-hide')), index * 100)
    setTimeout((-> element.text(newToken)), 300 + index * 100)
    setTimeout((-> element.removeClass('animate-hide')), 400 + index * 100)

  format: (number) ->
    if number.toString().length == 1
      "0#{number}"
    else
      number.toString()

$ ->
  TimeBoard.init()
