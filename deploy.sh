#!/bin/bash
docker push djz721/sample-node

ssh deploy@128.199.153.21 << EOF
docker pull djz721/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi willrstern/sample-node:current || true
docker tag djz721/sample-node:latest djz721/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 djz721/sample-node:current
EOF
