#!/bin/bash
MONGO_PORT_27017_TCP_ADDR = "${MONGO_PORT_27017_TCP_ADDR:=$MONGO_HOST}"
MONGO_PORT_27017_TCP_PORT="${MONGO_PORT_27017_TCP_PORT:=$MONGO_PORT}"
ELASTICSEARCH_PORT_9300_TCP_ADDR="${ELASTICSEARCH_PORT_9300_TCP_ADDR:=$ELASTICSEARCH_HOST}"
ELASTICSEARCH_PORT_9300_TCP_PORT="${ELASTICSEARCH_PORT_9300_TCP_PORT:=ELASTICSEARCH_PORT}"
GORA_OPTIONS="gora.datastore.default=org.apache.gora.mongodb.store.MongoStore,gora.mongodb.override_hadoop_configuration=false,gora.mongodb.mapping.file=/gora-mongodb-mapping.xml,gora.mongodb.servers=$MONGO_PORT_27017_TCP_ADDR:$MONGO_PORT_27017_TCP_PORT,gora.mongodb.db=nutch"
# add url parsing instructions to nutch
# echo "# accept URLs ending with nutch.apache.org domain\r\n+^http://([a-z0-9]*\.)*reddit.com/\r\n#accept anything else\r\n+." >> "$NUTCH_HOME/conf/regex-urlfilter.txt"

# Create gora config for mongodb
echo $GORA_OPTIONS | tr "," "\n" >> "$NUTCH_HOME/runtime/local/conf/gora.properties"

# Create the nutch config
sed -e "s/%ELASTICSEARCH_PORT_9300_TCP_ADDR%/$ELASTICSEARCH_PORT_9300_TCP_ADDR/g" \
    -e "s/%ELASTICSEARCH_PORT_9300_TCP_PORT%/$ELASTICSEARCH_PORT_9300_TCP_PORT/g" \
    /tmp/config/nutch-site.template > $NUTCH_HOME/runtime/local/conf/nutch-site.xml

#add seedlist to seed file
mkdir -p "$NUTCH_HOME/runtime/local/urls"
touch "$NUTCH_HOME/runtime/local/urls/seed.txt"
echo $SEEDLIST | tr "," "\n" >> "$NUTCH_HOME/runtime/local/urls/seed.txt"
# Start nutch webserver for controlling with REST API
$NUTCH_HOME/runtime/local/bin/nutch nutchserver > /dev/null &
# Start nutch web gui
$NUTCH_HOME/runtime/local/bin/nutch webapp
