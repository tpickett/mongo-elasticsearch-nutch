[![Code Climate](https://codeclimate.com/github/tpickett/mongo-elasticsearch-nutch/badges/gpa.svg)](https://codeclimate.com/github/tpickett/mongo-elasticsearch-nutch)

[Apache Nutch](http://nutch.apache.org/) is a highly extensible and scalable open source web crawler software project. A well matured, production ready crawler.

## Before You Begin
Before you begin we recommend you read about the basic building blocks that assemble an Apache Nutch crawler:
* Apache Nutch - Go through [Nutch Official Website](http://nutch.apache.org/) and proceed to their [Nutch 2.x tutorial](http://wiki.apache.org/nutch/Nutch2Tutorial), which should help you understand how crawling with apache nutch works.

## Prerequisites
Make sure you have installed all of the following prerequisites on your development machine:
* MongoDB - [Download & Install MongoDB](http://www.mongodb.org/downloads), and make sure it's running on the default port (27017).
* Elasticsearch - You're going to use the [Elasticsearch](https://www.elastic.co/) analytics engine to manage the index of your crawls.


## Deployment With Docker
* Install [Docker](http://www.docker.com/)
* Install [Docker Compose](https://docs.docker.com/compose/install)

## Build Docker Image
```
docker build -t tpickett/nutch .
```

## Use with existing mongodb and elasticsearch servers
```
docker run -p 8080:8080 -p 8081:8081 -e MONGO_HOST="localhost" -e MONGO_PORT="27017" -e ELASTICSEARCH_HOST="localhost" -e ELASTICSEARCH_PORT="9300" --name nutch tpickett/nutch
```

## Docker Compose support
included with the docker image is a 'docker-compose.yaml' file. this file will bring up a Mongodb server an Elasticsearch server and the Apache Nutch crawler. Everything you need in one command!
```
docker-compose up
```

## Getting Started With Apache Nutch
You have your nutch crawler started, but there is a lot of stuff to understand. We recommend you go over the [Nutch tutorials](http://wiki.apache.org/nutch/#Tutorials).
In the tutorials they will go over the process of crawling/indexing etc... After familiarizing yourself with Apache Nutch enter the container to start using Nutch!
```
docker exec -it nutch bin/bash
mkdir $NUTCH_HOME/runtime/local/urls
touch $NUTCH_HOME/runtime/local/urls/seed.txt
echo "http://reddit.com" >> $NUTCH_HOME/runtime/local/urls/seed.txt
$NUTCH_HOME/runtime/local/bin/nutch inject /urls/seed.txt
$NUTCH_HOME/runtime/local/bin/nutch generate -topN 10
$NUTCH_HOME/runtime/local/bin/nutch fetch -all
$NUTCH_HOME/runtime/local/bin/nutch parse -all
$NUTCH_HOME/runtime/local/bin/nutch updatedb -all
$NUTCH_HOME/runtime/local/bin/nutch index -all
```

## License
(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.