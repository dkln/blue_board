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
      var changedIndex, elements, i, newString, oldString;
      oldString = this.getDisplayString();
      newString = this.getCurrentString();
      elements = $('.time span');
      i = 0;
      changedIndex = 0;
      while (i < newString.length) {
        if (newString[i] !== oldString[i]) {
          this.changeElement(changedIndex, $(elements[i]), newString[i]);
          changedIndex++;
        }
        i++;
      }
      return $('.time').data('time', newString);
    },
    getDisplayString: function() {
      return $('.time').data('time');
    },
    getCurrentString: function() {
      var newTime;
      newTime = new Date();
      return "" + (this.format(newTime.getHours())) + (this.format(newTime.getMinutes()));
    },
    changeElement: function(index, element, newToken) {
      setTimeout((function() {
        return element.addClass('animate-hide');
      }), index * 100);
      setTimeout((function() {
        return element.text(newToken);
      }), 300 + index * 100);
      return setTimeout((function() {
        return element.removeClass('animate-hide');
      }), 400 + index * 100);
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
