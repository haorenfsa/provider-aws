#!/bin/bash
set -ex
FAIL="exit 1"
IMAGE_TEMP_DIR="./temp"
SED_CMD="sed -i"

mkdir -p ${IMAGE_TEMP_DIR}
# cp Dockerfile ${IMAGE_TEMP_DIR} || ${FAIL}
rm -f ./package/package.yaml
rm -r ${IMAGE_TEMP_DIR}
cp -R ./package ${IMAGE_TEMP_DIR}
# cd ${IMAGE_TEMP_DIR} && ${SED_CMD} 's|BASEIMAGE|${OSBASEIMAGE}|g' Dockerfile || ${FAIL}
# cd ${IMAGE_TEMP_DIR} && ${SED_CMD} 's|VERSION|${VERSION}|g' package/crossplane.yaml || ${FAIL}
# cd ${IMAGE_TEMP_DIR} && ${SED_CMD} 's|DOCKER_REGISTRY|${DOCKER_REGISTRY}|g' package/crossplane.yaml || ${FAIL}
find ${IMAGE_TEMP_DIR}/ -type f -name '*.yaml' -exec cat {} >> "package/package.yaml" \; -exec printf '\n---\n' \;
