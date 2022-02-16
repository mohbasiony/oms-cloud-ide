#!/bin/bash

tar xzf /tmp/runtime.tar.gz -C /projects
cd /projects/runtime
find . -type f -iname "*.sh" -exec chmod +x {} \;
chmod +x bin/* jdk/bin/* jdk/jre/bin/*
cp -r /projects/runtime/storesrc /projects/store-dev
cd /projects/store-dev && yarn
tail -f /dev/null