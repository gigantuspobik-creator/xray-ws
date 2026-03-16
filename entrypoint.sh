#!/bin/sh
set -e
echo "Starting Xray WS..."
REQUIRED="PORT UUID"
for VAR in $REQUIRED; do
  eval "VALUE=\$$VAR"
  if [ -z "$VALUE" ]; then
    echo "FATAL: Missing $VAR"
    exit 1
  fi
done
envsubst '${PORT} ${UUID}' \
  < /etc/xray/config.template.json > /etc/xray/config.json
echo "Config test..."
xray -test -config /etc/xray/config.json
echo "Starting Xray on port $PORT..."
exec xray run -config /etc/xray/config.json
