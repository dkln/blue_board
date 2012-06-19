NotificationBoard =
  url: '/notifications_example.json'

  oldNotificationPayload: ''

  notifications: []

  index: 0

  init: ->
    setInterval((=> @updatePayload()), 30000)
    setInterval((=> @updateTicker()), 5000)
    @updatePayload()

  updatePayload: ->
    $.ajax(
      url:        @url
      dataType:   'json'
      cache:      false
      type:       'GET'
      success:    ((data) => @handleResponse(data))
    )

  updateTicker: ->
    element = $('.notification .message')
    element.addClass('animate-hide')

    setTimeout((=> @setNewText()), 300)
    setTimeout((-> element.removeClass('animate-hide')), 400)

  setNewText: ->
    element       = $('.notification .message')
    notification  = @notifications[@index]

    element.html("<i class='icon-signal'></i>#{notification.description}")

    if notification.severity == 'ok'
      element.addClass('ok')
    else
      element.removeClass('ok')

    if notification.severity == 'fail'
      element.addClass('fail')
    else
      element.removeClass('fail')

    if notification.severity == 'notify'
      element.addClass('notify')
    else
      element.removeClass('notify')

    @index++
    @index = 0 if @index >= @notifications

  handleResponse: (data) ->
    if data != @oldNotificationPayload
      @oldNotificationPayload = JSON.stringify(data)
      @index = 0
      @notifications = data

$ ->
  NotificationBoard.init()
