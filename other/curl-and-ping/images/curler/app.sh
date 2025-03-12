#!/bin/sh

while true
do
    # Send request to listener
    curl -s "http://listener:8888/${HOSTNAME}"

    # Wait one second
    sleep 1
done