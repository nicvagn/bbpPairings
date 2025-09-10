#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
rm -fr $SCRIPT_DIR/build/*
rm -f $SCRIPT_DIR/bbpPairings
echo "Cleaned $SCRIPT_DIR"
