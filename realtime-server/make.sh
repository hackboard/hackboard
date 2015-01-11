#!/bin/bash
docker rmi hackboard/realtime
docker build -t hackboard/realtime .
