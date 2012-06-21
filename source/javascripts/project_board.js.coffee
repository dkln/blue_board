ProjectBoard =
  url: '/projects_example.json'

  projects: []

  oldProjectCount: 0

  init: ->
    setInterval((=> @update()), 10000)
    @update()

  build: ->
    numberToBuild = @projects.length - @oldProjectCount

    if numberToBuild > 0
      @buildNew(numberToBuild)
    else if numberToBuild < 0
      @removeLast(Math.abs(numberToBuild))

    @setNewTexts()

    @oldProjectCount = @projects.length

  buildNew: (numberToBuild) ->
    for index in [1..numberToBuild]
      $('.projects').append("
        <div class='project'>
          <div class='icon column'>
            <i class='icon-attention'></i>
            <i class='icon-clock-alt'></i>
            <div class='separator'></div>
          </div>
          <div class='name column'>
            <h2></h2>
            <div class='separator'></div>
          </div>
          <div class='progress column'>
            <span class='bar'></span>
            <span class='count'></span>
            <div class='separator'></div>
          </div>
          <div class='errors column'>
            <h2></h2>
            <div class='separator'></div>
          </div>
          <div class='rejected_stories column'>
            <h2></h2>
            <div class='separator'></div>
          </div>
          <div class='users column'>
            <div class='separator'></div>
          </div>
        </div>
      ")

  removeLast: (numberToBuild) ->
    for index in [0..numberToBuild]
      $('.projects .project:last').remove()

  setNewTexts: ->
    updateIndex = 0

    for index in [0..@projects.length - 1]
      element = $($('.projects .project')[index])

      if @isProjectChanged(element, index)
        @updateProject(element, index, updateIndex)
        updateIndex++

  isProjectChanged: (element, index) ->
    @isNameChanged(element, index) || @isProgressChanged(element, index) || @isErrorChanged(element, index)

  isNameChanged: (element, index) ->
    @projects[index].name != element.find('.name h2').text()

  isProgressChanged: (element, index) ->
    @projects[index].progress != element.hasClass('building')

  isErrorChanged: (element, index) ->
    @projects[index].errors > 0 && !element.hasClass('error')

  isRejectsChanged: (element, index) ->
    @projects[index].rejects > 0 && @projects[index].rejects != element.find('.rejects').text()

  isUsersChanged: (element, index) ->
    @projects[index].users != @getImages(element)

  getImages: (element) ->
    if element.find('img')
      images = $(image).attr('src') for image in element.find('img')

  setProject: (element, index) ->
    element.find('.name h2').text(@projects[index].name)
    element.find('.errors h2').text(@projects[index].errors)
    element.find('.rejected_stories h2').text(@projects[index].rejected_stories)

    if @projects[index].errors > 0
      element.addClass('error')
    else
      element.removeClass('error')

    if @projects[index].progress
      element.addClass('building')
    else
      element.removeClass('building')

    if @projects[index].failed
      element.addClass('failed')
    else
      element.removeClass('failed')

    @setUsers(element, index)
    @setProgress(element, index)

  updateProject: (element, index, updateIndex) ->
    setTimeout((-> element.addClass('animate-hide')), updateIndex * 400)
    setTimeout((=> @setProject(element, index)), 300 + updateIndex * 400)
    setTimeout((-> element.removeClass('animate-hide')), 400 + updateIndex * 400)

  setUsers: (element, index) ->
    if @isUsersChanged(element, index)
      for user in @projects[index].users
        element.find('.users').append("<img src='#{user}' />")

  setProgress: (element, index) ->
    maxWidth = element.find('.progress').width() - 22
    element.find('.progress .bar').width("#{@progressWidthFactor(index) * maxWidth}px")
    element.find('.progress .count').text("#{@projects[index].delivered_feature_count}/#{@projects[index].feature_count}")

  progressWidthFactor: (index) ->
    @projects[index].delivered_feature_count / @projects[index].feature_count

  update: ->
    $.ajax(
      url:        @url
      dataType:   'json'
      cache:      false
      type:       'GET'
      success:    ((data) => @handleResponse(data))
    )

  handleResponse: (data) ->
    @projects = data
    @build()

$ ->
  ProjectBoard.init()
