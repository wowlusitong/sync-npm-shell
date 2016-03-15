#!/bin/bash
DIRNAME=temp`date +%s`
if [ -z $1 ]; then
  echo 'error: 没有输入包名'
  exit 0
fi
if [ ! -d ${DIRNAME} ]; then
  mkdir ${DIRNAME}
fi
cd ${DIRNAME}
npm init --force
npm --registry=https://registry.npm.taobao.org install $@
cd node_modules
DIR=`ls`
for dir in ${DIR}; do
  if [ -d ${dir} ]; then
    cd ${dir}
    npm --registry=http://localhost:5984/registry/_design/app/_rewrite publish --force
    cd ..
  fi
done
cd ../..
rm -rf ${DIRNAME}
