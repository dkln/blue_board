(function() {
  var ProjectBoard;

  ProjectBoard = {
    url: '/projects_example.json',
    projects: [],
    oldProjectCount: 0,
    init: function() {
      var _this = this;
      setInterval((function() {
        return _this.update();
      }), 10000);
      return this.update();
    },
    build: function() {
      var numberToBuild;
      numberToBuild = this.projects.length - this.oldProjectCount;
      if (numberToBuild > 0) {
        this.buildNew(numberToBuild);
      } else if (numberToBuild < 0) {
        this.removeLast(Math.abs(numberToBuild));
      }
      this.setNewTexts();
      return this.oldProjectCount = this.projects.length;
    },
    buildNew: function(numberToBuild) {
      var index, _i, _results;
      _results = [];
      for (index = _i = 1; 1 <= numberToBuild ? _i <= numberToBuild : _i >= numberToBuild; index = 1 <= numberToBuild ? ++_i : --_i) {
        _results.push($('.projects').append("        <div class='project'>          <div class='icon column'>            <i class='icon-attention'></i>            <i class='icon-clock-alt'></i>          </div>          <div class='name column'>            <h2></h2>          </div>          <div class='active column'></div>          <div class='rejects column'></div>          <div class='users column'></div>        </div>      "));
      }
      return _results;
    },
    removeLast: function(numberToBuild) {
      var index, _i, _results;
      _results = [];
      for (index = _i = 0; 0 <= numberToBuild ? _i <= numberToBuild : _i >= numberToBuild; index = 0 <= numberToBuild ? ++_i : --_i) {
        _results.push($('.projects .project:last').remove());
      }
      return _results;
    },
    setNewTexts: function() {
      var element, index, updateIndex, _i, _ref, _results;
      updateIndex = 0;
      _results = [];
      for (index = _i = 0, _ref = this.projects.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; index = 0 <= _ref ? ++_i : --_i) {
        element = $($('.projects .project')[index]);
        if (this.isProjectChanged(element, index)) {
          this.updateProject(element, index, updateIndex);
          _results.push(updateIndex++);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    },
    isProjectChanged: function(element, index) {
      return this.isNameChanged(element, index) || this.isProgressChanged(element, index) || this.isErrorChanged(element, index);
    },
    isNameChanged: function(element, index) {
      return this.projects[index].name !== element.find('.name h2').text();
    },
    isProgressChanged: function(element, index) {
      return this.projects[index].progress !== element.hasClass('building');
    },
    isErrorChanged: function(element, index) {
      return this.projects[index].errors > 0 && !element.hasClass('error');
    },
    isRejectsChanged: function(element, index) {
      return this.projects[index].rejects > 0 && this.projects[index].rejects !== element.find('.rejects').text();
    },
    isUsersChanged: function(element, index) {
      return this.projects[index].users !== this.getImages(element);
    },
    setProject: function(element, index) {
      element.find('.name h2').text(this.projects[index].name);
      element.find('.rejects').text(this.projects[index].rejects);
      if (this.projects[index].errors > 0) {
        element.addClass('error');
      } else {
        element.removeClass('error');
      }
      if (this.projects[index].progress) {
        element.addClass('building');
      } else {
        element.removeClass('building');
      }
      if (this.projects[index].failed) {
        element.addClass('failed');
      } else {
        element.removeClass('failed');
      }
      return this.setUsers(element, index);
    },
    setUsers: function(element, index) {
      var user, _i, _len, _ref, _results;
      if (this.isUsersChanged(element, index)) {
        _ref = this.projects[index].users;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          user = _ref[_i];
          _results.push(element.find('.users').append("<img src='" + user + "' />"));
        }
        return _results;
      }
    },
    getImages: function(element) {
      var image, images, _i, _len, _ref, _results;
      if (element.find('img')) {
        _ref = element.find('img');
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          image = _ref[_i];
          _results.push(images = $(image).attr('src'));
        }
        return _results;
      }
    },
    updateProject: function(element, index, updateIndex) {
      var _this = this;
      setTimeout((function() {
        return element.addClass('animate-hide');
      }), updateIndex * 400);
      setTimeout((function() {
        return _this.setProject(element, index);
      }), 300 + updateIndex * 400);
      return setTimeout((function() {
        return element.removeClass('animate-hide');
      }), 400 + updateIndex * 400);
    },
    update: function() {
      var _this = this;
      return $.ajax({
        url: this.url,
        dataType: 'json',
        cache: false,
        type: 'GET',
        success: (function(data) {
          return _this.handleResponse(data);
        })
      });
    },
    handleResponse: function(data) {
      this.projects = data;
      return this.build();
    }
  };

  $(function() {
    return ProjectBoard.init();
  });

}).call(this);
