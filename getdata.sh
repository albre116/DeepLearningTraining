#!/usr/bin/env bash
mkdir ../data
apt install unzip -y

### get dogs cats data if it doesn't exist
if [ ! -e ../data/dogscats ]
	then
		cd ../data && curl http://files.fast.ai/data/dogscats.zip --output dogscats.zip	
		cd ../data && unzip -d . dogscats.zip 
		cd ../data && rm dogscats.zip
fi

# get movielens data
if [ ! -e ../data/ml-latest-small ]
        then
		cd ../data && curl http://files.grouplens.org/datasets/movielens/ml-latest-small.zip --output ml-latest-small.zip
		cd ../data && unzip -d . ml-latest-small.zip 
		cd ../data && rm ml-latest-small.zip
fi
