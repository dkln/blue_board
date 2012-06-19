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
          </div>
          <div class='name column'>
            <h2></h2>
          </div>
          <div class='active column'></div>
          <div class='status column'></div>
          <div class='users column'></div>
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

  setProject: (element, index) ->
    element.find('.name h2').text(@projects[index].name)

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

  updateProject: (element, index, updateIndex) ->
    setTimeout((-> element.addClass('animate-hide')), updateIndex * 400)
    setTimeout((=> @setProject(element, index)), 300 + updateIndex * 400)
    setTimeout((-> element.removeClass('animate-hide')), 400 + updateIndex * 400)

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
