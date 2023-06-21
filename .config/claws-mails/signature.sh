#!/bin/bash

key=$(head -c 21 /dev/urandom | base64 --wrap=0)

cat <<EOL

$key
EOL
