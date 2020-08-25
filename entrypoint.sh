#!/usr/bin/env bash

#. /root/.nvm/nvm.sh

set -e

OUTPUT_ZIP=$(mktemp -t crytic --suffix=.zip)
crytic-compile . --truffle-version "$2" --export-zip "$OUTPUT_ZIP"

OUTPUT_JSON=$(mktemp -t crytic --suffix=.json)

(printf '{"zip":"'; base64 -w 0 "$OUTPUT_ZIP"; printf '"}';) | curl -X POST -d @- "$1" > "$OUTPUT_JSON"
echo "::set-output sarif_path=$OUTPUT_JSON"