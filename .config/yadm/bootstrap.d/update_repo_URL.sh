#!/bin/sh

echo "Updating the yadm repo origin URL to SSH form HTTPS"
yadm remote set-url origin "git@github.com:orenzp/.dot-files.git"
