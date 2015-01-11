#!/bin/bash
docker run -d -ti --name hb-realtime -p 16379:6379 -p 33555:33555 hackboard/realtime
