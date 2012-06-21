# BlueBoard Client

Dashboard for software development teams. Pure HTML/CSS/Javascript client that can receive status
updates and notifications.

Inspired by the very slick Panic! board and NS "blauwe bord"

![screenshot](https://github.com/dkln/blue_board/raw/master/screenshot.png)

## Server

Can be used in combination with Robin Roestenburg's compatible [BlueBoard server](https://github.com/robinroestenburg/blue_board_server).

## Installation

You can find a compiled version of the SASS, SLIM and Coffeescript files in the ./build directory.
You can place this on any webserver that serves static files.

## Development

Middleman is used to compile the whole project. To develop locally, just run middleman

    middleman server

To build the whole project, just run middleman build:

    middleman build

## Json payloads

There are two types of JSON payloads. The current project status and notifications.

### Status updates

Example of JSON payload:

      [
        {
          "name":"This is some project",
          "progress":false,
          "feature_count":25,
          "delivered_feature_count":18,
          "errors":0,
          "rejected_feature_count":0,
          "failed":false,
          "contributors": [
              "https://secure.gravatar.com/avatar/14690f57c2f127656e1fdda876ec7e27?s=140", "https://secure.gravatar.com/avatar/9ffbc194f775c7bdc155ad6e833df81e?s=140"
          ]
        },
        {
          "name":"A failed project",
          "progress":false,
          "feature_count":10,
          "delivered_feature_count":10,
          "errors":0,
          "rejected_feature_count":2,
          "failed":true,
          "contributors": [
            "https://secure.gravatar.com/avatar/9ffbc194f775c7bdc155ad6e833df81e?s=140"
          ]
        },
        {
          "name":"A project with errors",
          "progress":false,
          "feature_count":17,
          "delivered_feature_count":12,
          "errors":37,
          "rejected_feature_count":10,
          "failed":false,
          "contributors": []
        },
        {
          "name":"Building in progress",
          "progress":true,
          "feature_count":10,
          "delivered_feature_count":0,
          "errors":0,
          "rejected_feature_count":1,
          "failed":false,
          "contributors": []
        }
      ]


* name: Short description for the project.
* progress: Indicates of the project is currently building (possible values: false/true).
* feature\_count: The number of total to-be-developed features.
* delivered\_feature\_count: The number of total accepted features.
* errors: The number of errors in production.
* rejected\_feature\_count: The number of bugs/rejected features.
* failed: Indicates if the project has failed building (possible values: false/true).
* contributors: Array of URLs to (gr)avatars.

### Notification updates

Example of JSON payload:

    [
      {
        "description":"Some user added comment: \"Disabled status updates for dashboard.\"",
        "service":"pivotal",
        "status":"ok",
      },
      {
        "description":"Other user added comment: \"As an administrative user, I want to delete a selected user, so I can revoke access for some people\"",
        "service":"pivotal",
        "status":"notify",
      },
      {
        "description":"Foo user added comment: \"This is some great test message\"",
        "service":"pivotal",
        "status":"fail",
      }
    ]


* description: The description of the notification.
* service: The service that provided the notification.
* status: Determines the purpose of the notification (possible values: ok/notify/fail).

## Configuration

By default, the JSON payloads are located on /projects.json and /notifications.json. You can change these URLs
in project\_board.js and notification\_board.js.

Project board:

      (function() {
        var ProjectBoard;
    
        ProjectBoard = {
          url: 'the_url_of_your_choice',

And in the notifications area:

      (function() {
        var NotificationBoard;
    
        NotificationBoard = {
          url: '/notifications',


# License and credits

Use it and have fun with it!

Credits to:

* [Kevin Tuhumury](https://github.com/kevintuhumury)
* [Robin Roestenburg](https://github.com/robinroestenburg)

And special thanx for the fonts:

* [modernpics](https://github.com/fontello/modernpics.font)
* [moonbase press](http://dionaea.com/)
* [google](http://www.google.com/webfonts)

Copyright 2012, Diederick Lawson - Altovista. Released under the FreeBSD license.
