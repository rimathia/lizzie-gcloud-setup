#!/usr/bin/env bash
set -eu
git clone https://github.com/featurecat/lizzie.git Lizzie
cd Lizzie
mvn package
cp ../lizzie_config.txt config.txt
