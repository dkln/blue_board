# Blue Board Server


## Features


## Installation

Prerequisites:
- Redis installed on your system (use Homebrew)

Start redis:

```
redis-server /usr/local/etc/redis.conf 
```

Start Resque worker:

```
QUEUE=<queue-name> rake resque:work
```

Start the Resque job scheduler (schedules jobs in the different queues at
different intervals): 

```
rake resque:scheduler
```


Start Rails:

```
rails s
``` 

That's a lot, we should probably make this easier :-)

## Configuration

TODO: The API keys should not be present in the repo.

## Usage

Once all the servers and workers are running, you can retrieve different kinds
of information through  the following endpoints:

### /notifications

Contains a list of the 50 most recent notifications in JSON format. Each element
contains: 

* id
* description
* service
* severity

You can supply the id of the last received notification on subsequent calls to
the API. In this case, the server will only send notifications with higher ids 
higher (e.g. newer notifications).  

### /projects

Contains a list of all projects that are present in Hudson in JSON format. 

TODO

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
