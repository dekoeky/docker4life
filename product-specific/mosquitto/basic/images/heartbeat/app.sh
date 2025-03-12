#!/bin/sh

# Exit gracefully when the docker container is signalled to stop.
trap 'echo "Exiting gracefully..."; exit 0' SIGTERM

# Check REQUIRED Environment Variables
if [ -z "$MQTT_HOST" ]; then echo "Error: MQTT_HOST is not set."; exit 1; fi
if [ -z "$MQTT_PORT" ]; then echo "Error: MQTT_PORT is not set."; exit 1; fi

# Set OPTIONAL Environment Variables
# Set default delay to 1 second if not provided
DELAY=${DELAY:-1}
MQTT_TOPIC=${MQTT_TOPIC:-date}

# Infinite loop
while true; do

  # Get the current date/time
  # current_datetime=$(date)
  current_datetime=$(date +"%Y-%m-%dT%H:%M:%S%z")

  # Publish the current datetime to the configured topic/broker
  mosquitto_pub -h "$MQTT_HOST" -p "$MQTT_PORT" -t "$MQTT_TOPIC" -m "$current_datetime" -u "$MQTT_USER" -P "$MQTT_PASSWORD"

  # Print the result of the publish
  if [ $? -eq 0 ]; then
    echo "Success: [$MQTT_TOPIC] $current_datetime"
  else
    echo "Failure: Failed to publish date/time."
  fi
  
  # Delay for the specified number of seconds
  sleep "$DELAY"
done
