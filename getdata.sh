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


### get rossman data
if [ ! -e ../data/rossmann ]
        then
                cd ../data && curl http://files.fast.ai/part2/lesson14/rossmann.tgz  --output rossmann.tgz 
                cd ../data && mkdir rossmann 
		cd ../data && mv rossmann.tgz rossmann/
                cd ../data/rossmann && tar -xzf rossmann.tgz
		cd ..
fi


# get movielens data
if [ ! -e ../data/ml-latest-small ]
        then
		cd ../data && curl http://files.grouplens.org/datasets/movielens/ml-latest-small.zip --output ml-latest-small.zip
		cd ../data && unzip -d . ml-latest-small.zip 
		cd ../data && rm ml-latest-small.zip
fi

# get imdb data
if [ ! -e ../data/aclImdb ]
        then
                cd ../data && curl http://files.fast.ai/data/aclImdb.tgz --output aclImdb.tgz
                cd ../data && tar -xzf aclImdb.tgz
                cd ..

fi

