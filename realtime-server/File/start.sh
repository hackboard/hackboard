#!/bin/sh 
service redis-server start
cd /real-time-server/ && node server.js
