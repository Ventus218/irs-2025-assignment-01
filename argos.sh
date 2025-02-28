#!/bin/bash
docker run --rm -p 6080:80 -v /dev/shm:/dev/shm -v "$(pwd):/lab" tjferrara/argos3:latest