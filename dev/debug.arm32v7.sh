#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# This is just a helper script to quickly test local Dockerfile builds, please run setup-build-env.sh once

# Note - S6 overlay does NOT like it when you give it a tty under QEMU - do not run 
# the container with "-it" rather, run it in background (so we get log output) then
# exec a bash process to enter the container. 

trap "trap - SIGTERM && docker stop pms-armv7" SIGINT SIGTERM EXIT
docker run --rm --name pms-armv7 --platform linux/arm/v7 -e DEBUG=true pms-armv7:latest &
sleep 5
docker exec -it pms-armv7 bash