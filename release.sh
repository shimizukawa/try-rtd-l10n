#!/bin/sh

set -ex

RELEASE=1_7

# setup environment
SPHINXINTL_TRANSIFEX_USERNAME=sphinxjp
SPHINXINTL_TRANSIFEX_PROJECT_NAME=sphinx-doc-${RELEASE}
git submodule init
git submodule update
(cd sphinx; git fetch origin)
find sphinx -name "*.pyc" -exec rm {} \;
git checkout master
pip install -r requirements.txt

# setup environment
cd sphinx
git checkout master  # checkout sphinx master
cd ../

# update transifex pot and local po files
sh ./locale/update.sh

# commit po(t) files
git add locale sphinx
git commit -m "[skip ci] update po(t) files"

# push changes
git checkout master
git submodule update
git push origin master
