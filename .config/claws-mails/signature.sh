#!/bin/bash

# key=$(head -c 21 /dev/urandom | base64 --wrap=0)
key=$(head -c 12 /dev/urandom | xxd -p | tr a-z A-Z)
cat <<EOL

Message-ID: $key
EOL
