Celastica: elasticsearch Client
Celastica is an open source elasticsearch client delivered as a C extension for the PHP language providing high performance and lower resource consumption.
It is direct port of Ruflin PHP Client for elasticsearch Elastica.

This readme provides an introduction to contributing to Elastica

Get Started

Clone Elastica repo:

git clone -b https://github.com/ariskemper/celastica.git
Clone zephir repo:

git clone https://github.com/phalcon/zephir.git
clone json-c repo:

git clone https://github.com/json-c/json-c.git
Install required packages:

sudo apt-get install php5-dev gcc make re2c libpcre3-dev
Compile json-c:

cd json-c
sudo sh autogen.sh
sudo ./configure
sudo make
sudo make install
cd ..
Compile zephir:

cd zephir
sudo ./install
cd ..
Compile celastica:

cd celastica
../zephir/bin/zephir generate
../zephir/bin/zephir compile
Add extension to your php.ini

extension=elastica.so
Finally restart/reload php

Dependencies
------------
| Project | Version | Required |
|---------|---------|----------||[Elasticsearch](https://github.com/elasticsearch/elasticsearch/tree/v1.1.1)|1.1.1|yes|
|[Zephir](https://github.com/phalcon/zephir/tree/zephir-0.4.0a)|0.4.0a|yes|
|[Json-C](https://github.com/json-c/json-c/tree/json-c-0.10)|0.10|yes|
|[Elasticsearch](https://github.com/elasticsearch/elasticsearch/tree/v1.1.1)|1.1.1|yes|
|[Elasticsearch mapper attachments plugin](https://github.com/elasticsearch/elasticsearch-mapper-attachments/tree/v2.0.0.RC1)|2.0.0.RC1|no|
|[Elasticsearch geocluster facet plugin](https://github.com/zenobase/geocluster-facet/tree/0.0.10)|0.0.10|no|