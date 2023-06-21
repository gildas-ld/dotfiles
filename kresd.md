#!/bin/env sh

rm /var/cache/knot-resolver/*.mdb && systemctl restart kresd@1.service && systemctl restart NetworkManager.service
