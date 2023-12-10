#!/bin/bash
while true  # Keep an infinite loop to reconnect when connection lost/broker unavailable
do
    mosquitto_sub -h "${MQTT_HOST}" -t "${MQTT_TOPIC}" -u "${MQTT_USERNAME:-adminuser}" -P "${MQTT_PASSWORD}"| while read -r payload
    do
        echo "mosquitto_sub -h ${MQTT_HOST} -t ${MQTT_TOPIC}"
        echo "${payload}"
        # Here is the callback to execute whenever you receive a message:
        ./display-power.sh ${payload}
    done
    sleep 10  # Wait 10 seconds until reconnection
done 
