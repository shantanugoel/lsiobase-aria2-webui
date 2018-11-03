#!/bin/bash

export RPC_TOKEN="${CUSTOM_RPC_TOKEN:-$(openssl rand -base64 32)}"
export OVERRIDE_OPTIONS=("${CUSTOM_OVERRIDE_OPTIONS}")

exec $(eval echo "$@")
