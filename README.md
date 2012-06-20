# BlueBoard Client

Dashboard for software development teams. Pure HTML/CSS/Javascript client that can receive status
updates and notifications.

Inspired by the very slick Panic! board and NS "blauwe bord"

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

Format of status updates:

    [
      {
        "name":"This is some project",
        "progress":false,
        "feature_count":25,
        "delivered_feature_count":18,
        "errors":0,
        "rejected_stories":0,
        "failed":false,
        "users": [
          "https://secure.gravatar.com/avatar/14690f57c2f127656e1fdda876ec7e27?s=140",
          "https://secure.gravatar.com/avatar/9ffbc194f775c7bdc155ad6e833df81e?s=140"
        ]
      },
      {
        "name":"A failed project",
        "progress":false,
        "feature_count":10,
        "delivered_feature_count":8,
        "errors":0,
        "rejected_stories":2,
        "failed":true,
        "users": [
          "https://secure.gravatar.com/avatar/9ffbc194f775c7bdc155ad6e833df81e?s=140"
        ]
      },
      {
        "name":"A project with errors",
        "progress":false,
        "feature_count":17,
        "delivered_feature_count":12,
        "errors":37,
        "rejected_stories":10,
        "failed":false,
        "users": []
      },
      {
        "name":"Building in progress",
        "progress":true,
        "feature_count":10,
        "delivered_feature_count":0,
        "errors":0,
        "rejected_stories":1,
        "failed":false,
        "users": []
      }
    ]

Format of notifications updates:

    [
      {
        "created_at":"2012-06-19T06:50:30Z",
        "description":"Some user added comment: \"Disabled status updates for dashboard.\"",
        "external_identifier":"1337",
        "id":1,
        "service":"pivotal",
        "severity":null,
        "updated_at":"2012-06-19T06:50:30Z"
      },
      {
        "created_at":"2012-06-19T06:50:30Z",
        "description":"Other user added comment: \"As an administrative user, I want to delete a selected user, so I can revoke access for some people\"",
        "external_identifier":"1338",
        "id":2,
        "service":"pivotal",
        "severity":null,
        "updated_at":"2012-06-19T06:50:30Z"
      },
      {
        "created_at":"2012-06-19T06:50:30Z",
        "description":"Foo user added comment: \"This is some great test message\"",
        "external_identifier":"1339",
        "id":3,
        "service":"pivotal",
        "severity":null,
        "updated_at":"2012-06-19T06:50:30Z"
      }
    ]


# License and credits

Use it and have fun with it!

Copyright 2012, Diederick Lawson - Altovista. Released under the FreeBSD license.
