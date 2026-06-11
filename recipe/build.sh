#!/bin/bash

set -o errexit -o pipefail -o xtrace

if [[ ${build_platform} != ${target_platform} ]]; then
    BOOM_DIR=$(${BUILD_PREFIX}/bin/Rscript -e "cat(system.file(package='Boom'))" | sed "s?${BUILD_PREFIX}?${PREFIX}?")
    sed -i "s?BOOM_DIR = .*?BOOM_DIR = ${BOOM_DIR}?" src/Makevars
fi

export DISABLE_AUTOBREW=1
${R} CMD INSTALL --build . ${R_ARGS}
