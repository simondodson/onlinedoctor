#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5ea31d8a4b50f6001ab043a5/webhook/build/pull > /dev/null
if [[ -z "${34dcf861cb4e1c108a8229fed2dec01227e78d5598e0edb654623aad46472d54}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5ea31d8a4b50f6001ab043a5 
fi
curl -s -X POST https://api.stackbit.com/project/5ea31d8a4b50f6001ab043a5/webhook/build/ssgbuild > /dev/null
gatsby build
./inject-netlify-identity-widget.js public
curl -s -X POST https://api.stackbit.com/project/5ea31d8a4b50f6001ab043a5/webhook/build/publish > /dev/null
