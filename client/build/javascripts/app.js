(function() {
  var TimeBoard;

  TimeBoard = {
    init: function() {
      var _this = this;
      setInterval((function() {
        return _this.update();
      }), 10000);
      return this.update();
    },
    update: function() {
      var elements, i, newString, oldString;
      oldString = this.getDisplayString();
      newString = this.getCurrentString();
      elements = $('.message .time span');
      i = 0;
      while (i < newString.length) {
        if (newString[i] !== oldString[i]) {
          this.changeElement($(elements[i]), newString[i]);
        }
        i++;
      }
      return $('.message .time').data('time', newString);
    },
    getDisplayString: function() {
      return $('.message .time').data('time');
    },
    getCurrentString: function() {
      var newTime;
      newTime = new Date();
      return "" + (this.format(newTime.getHours())) + ":" + (this.format(newTime.getMinutes()));
    },
    changeElement: function(element, newToken) {
      element.addClass('animate-hide');
      setTimeout((function() {
        return element.text(newToken);
      }), 300);
      return setTimeout((function() {
        return element.removeClass('animate-hide');
      }), 400);
    },
    format: function(number) {
      if (number.toString().length === 1) {
        return "0" + number;
      } else {
        return number.toString();
      }
    }
  };

  $(function() {
    return TimeBoard.init();
  });

}).call(this);
