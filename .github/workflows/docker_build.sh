#!/bin/bash

#set -eu
set -x

docker pull $TAG_BRANCH
HASH_BEFORE=`docker images -q $TAG_BRANCH` 
if [ "$BRANCH" != "master" ]; then
    docker build -t $TAG_BRANCH --build-arg BRANCH=$BRANCH --build-arg CACHEBUST=$CACHE_BUST .
else
    docker build -t $TAG_BRANCH -t $TAG_LATEST --build-arg BRANCH=$BRANCH --build-arg CACHEBUST=$CACHE_BUST .
fi
HASH_AFTER=`docker images -q $TAG_BRANCH`
if [ "${HASH_BEFORE}" == "${HASH_AFTER}" ]; then
    echo '::set-output name=dispatch_bypass::true'
else
    echo '::set-output name=dispatch_bypass::false'
    docker push $TAG_BRANCH
    if [ "$BRANCH" == "master" ]; then
        docker push $TAG_LATEST
    fi
fi
