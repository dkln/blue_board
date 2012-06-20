DateBoard =
  init: ->
    setInterval((=> @update()), 10000)
    @update()

  update: ->
    oldString = @getDisplayString()
    newString = @getCurrentString()

    element  = $('.message .date span')
    element.text(newString)

    $('.message .date').data('date', newString)

  getDisplayString: ->
    $('.message .date').data('date')

  getCurrentString: ->
    newDate = new Date()

    "#{@formatDay(newDate.getDay())}, #{newDate.getDate()} #{@formatMonth(newDate.getMonth())} #{newDate.getFullYear()}"

  formatDay: (index) ->
    days = ["zondag", "maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag"]
    days[index]

  formatMonth: (index) ->
    months = ["januari", "februari", "maart", "april", "mei", "juni", "juli", "augustus", "september", "oktober", "november", "december"]
    months[index]

$ ->
  DateBoard.init()
