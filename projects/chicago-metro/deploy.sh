#!/bin/bash
set -x;

DATA_DIR='/data';
CODE_DIR='/code';

# check for dependencies
if [[ ! -f /usr/bin/docker || ! -x /usr/bin/docker ]]; then
  echo "docker not installed on system";
  exit 1;
fi

if [[ ! -f /usr/local/bin/docker-compose || ! -x /usr/local/bin/docker-compose ]]; then
  echo "docker-compose not installed on system";
  exit 1;
fi

if [[ ! -f /usr/bin/unzip || ! -x /usr/bin/unzip ]]; then
  echo "unzip not installed on system";
  exit 1;
fi

# create directories for github repository and data
mkdir $DATA_DIR;
mkdir $CODE_DIR;

# clone repo
cd $CODE_DIR;
git clone https://github.com/mchladek/docker.git .;

# install pelias script
ln -s "$(pwd)/pelias" /usr/local/bin/pelias;

# checkout chicago project branch and change into directory
git pull origin chicago-project;
git checkout chicago-project;
cd projects/chicago-metro;

# configure environment
sed -i '/DATA_DIR/d' .env;
echo "DATA_DIR=$DATA_DIR" >> .env;

# run first steps of build
pelias compose pull;
pelias elastic start;
pelias elastic wait;
pelias elastic create;

# download all data except for TIGER census data
pelias download wof;
pelias download oa;
pelias download osm;
pelias download transit;

# get TIGER census data for Cook County as current scripts corrupt data when
# downloading it (see https://github.com/pelias/interpolation/issues/162)
mkdir -p $DATA_DIR/tiger/{downloads,shapefiles};
cd $DATA_DIR/tiger/downloads;
wget ftp://ftp2.census.gov/geo/tiger/TIGER2016/ADDRFEAT/tl_2016_17031_addrfeat.zip;
unzip tl_2016_17031_addrfeat.zip -d $DATA_DIR/tiger/shapefiles;
cd $CODE_DIR/projects/chicago-metro;

# continue with build
pelias prepare all;
pelias import all;
pelias compose up;
