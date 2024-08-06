#!/bin/bash

# Threshold for CPU usage (e.g., 80%)
CPU_THRESHOLD=40

# Desired scale
SCALE_UP_REPLICAS=5
SCALE_DOWN_REPLICAS=1

# Get the container ID of the web service
CONTAINER_ID=$(docker ps -qf "name=p2p-webserver-infra-web-service-1")

if [[ -z "$CONTAINER_ID" ]]; then
  echo "Error: Unable to find container ID for web service"
  exit 1
fi

while true; do
  # Get the current CPU usage of the web container
  CPU_USAGE=$(docker stats --no-stream --format "{{.CPUPerc}}" $CONTAINER_ID | sed 's/%//')

  if [[ -z "$CPU_USAGE" ]]; then
    echo "Error: Unable to get CPU usage for container $CONTAINER_ID"
    exit 1
  fi

  # Check if CPU usage exceeds the threshold
  if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "CPU usage is high ($CPU_USAGE%). Scaling up..."
    docker-compose scale web-service=$SCALE_UP_REPLICAS
  else
    echo "CPU usage is normal ($CPU_USAGE%). Scaling down..."
    docker-compose scale web-service=$SCALE_DOWN_REPLICAS
  fi

  # Wait for 30 seconds before checking again
  sleep 30
done