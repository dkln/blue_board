(function() {
  var NotificationBoard;

  NotificationBoard = {
    url: '/notifications.json',
    oldNotificationPayload: '',
    notifications: [],
    index: 0,
    init: function() {
      var _this = this;
      setInterval((function() {
        return _this.updatePayload();
      }), 30000);
      setInterval((function() {
        return _this.updateTicker();
      }), 5000);
      return this.updatePayload();
    },
    updatePayload: function() {
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
    updateTicker: function() {
      var element, notification;
      element = $('.notifications');
      notification = this.notifications[this.index];
      element.find('p').html("" + notification.description + "<span class='blink'>_</span>");
      if (notification.status === 'fail') {
        element.addClass('fail');
      } else {
        element.removeClass('fail');
      }
      this.index++;
      if (this.index >= this.notifications.length) {
        return this.index = 0;
      }
    },
    handleResponse: function(data) {
      if (data !== this.oldNotificationPayload) {
        this.oldNotificationPayload = JSON.stringify(data);
        this.index = 0;
        return this.notifications = data;
      }
    }
  };

  $(function() {
    return NotificationBoard.init();
  });

}).call(this);
