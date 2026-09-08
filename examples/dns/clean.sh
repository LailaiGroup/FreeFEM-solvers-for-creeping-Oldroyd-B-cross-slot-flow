#!/bin/bash
cd "$(dirname "$0")" || exit 1

rm -rf data output
rm -f probe_Wi*.txt log.dns
