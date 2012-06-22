NotificationBoard =
  url: '/notifications.json'

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
    element       = $('.notifications')
    notification  = @notifications[@index]

    if notification
      if notification.description
        element.find('p').html("#{notification.description}<span class='blink'>_</span>")

      if notification.status == 'fail'
        element.addClass('fail')
      else
        element.removeClass('fail')

    @index++
    @index = 0 if @index >= @notifications.length

  handleResponse: (data) ->
    if data != @oldNotificationPayload
      @oldNotificationPayload = JSON.stringify(data)
      @index = 0
      @notifications = data

$ ->
  NotificationBoard.init()
