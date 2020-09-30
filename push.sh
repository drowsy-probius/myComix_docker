#!/bin/bash
docker build -t app .
docker tag app k123s456h/mycomix
docker push k123s456h/mycomix
