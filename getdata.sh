#!/usr/bin/env bash
mkdir ../data
apt install unzip -y
cd ../data && curl http://files.fast.ai/data/dogscats.zip --output dogscats.zip
cd ../data && unzip -d . dogscats.zip 
cd ../data && rm dogscats.zip