#!/bin/sh
echo "Running in directory: $(pwd)"
echo "Resources directory: $LDAK_RESOURCES"
echo " "

exec ldak "$@"