(function() {
  var DateBoard;

  DateBoard = {
    init: function() {
      var _this = this;
      setInterval((function() {
        return _this.update();
      }), 10000);
      return this.update();
    },
    update: function() {
      var element, newString, oldString;
      oldString = this.getDisplayString();
      newString = this.getCurrentString();
      element = $('.message .date span');
      element.text(newString);
      return $('.message .date').data('date', newString);
    },
    getDisplayString: function() {
      return $('.message .date').data('date');
    },
    getCurrentString: function() {
      var newDate;
      newDate = new Date();
      return "" + (this.formatDay(newDate.getDay())) + ", " + (newDate.getDate()) + " " + (this.formatMonth(newDate.getMonth())) + " " + (newDate.getFullYear());
    },
    formatDay: function(index) {
      var days;
      days = ["zondag", "maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag"];
      return days[index];
    },
    formatMonth: function(index) {
      var months;
      months = ["januari", "februari", "maart", "april", "mei", "juni", "juli", "augustus", "september", "oktober", "november", "december"];
      return months[index];
    }
  };

  $(function() {
    return DateBoard.init();
  });

}).call(this);
