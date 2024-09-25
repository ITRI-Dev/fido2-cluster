#!/bin/bash

# Check if HAProxy is running
if docker inspect -f '{{.State.Running}}' haproxy2 | grep true > /dev/null; then
    exit 0
else
    exit 1
fi
