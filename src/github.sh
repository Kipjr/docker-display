#!/bin/bash
echo "Login github"
docker login -u kipjr1991 -p {[token](https://github.com/settings/tokens)} docker.pkg.github.com

echo "Start Server"
docker-compose up -d


