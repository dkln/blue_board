(function() {
  var NotificationBoard;

  NotificationBoard = {
    url: '/notifications_example.json',
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
      var element,
        _this = this;
      element = $('.notification .message');
      element.addClass('animate-hide');
      setTimeout((function() {
        return _this.setNewText();
      }), 300);
      return setTimeout((function() {
        return element.removeClass('animate-hide');
      }), 400);
    },
    setNewText: function() {
      var element, notification;
      element = $('.notification .message');
      notification = this.notifications[this.index];
      element.html("<i class='icon-signal'></i>" + notification.description);
      if (notification.severity === 'ok') {
        element.addClass('ok');
      } else {
        element.removeClass('ok');
      }
      if (notification.severity === 'fail') {
        element.addClass('fail');
      } else {
        element.removeClass('fail');
      }
      if (notification.severity === 'notify') {
        element.addClass('notify');
      } else {
        element.removeClass('notify');
      }
      this.index++;
      if (this.index >= this.notifications) {
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
