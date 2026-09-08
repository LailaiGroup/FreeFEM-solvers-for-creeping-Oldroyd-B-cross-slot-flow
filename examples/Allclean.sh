#!/bin/bash
# Removes solver-generated outputs from all three example cases. Safe to
# run even if a case was never run (or only partially run).
cd "$(dirname "$0")" || exit 1

./dns/clean.sh

rm -rf lsa_direct/output_base lsa_direct/eig
rm -f lsa_direct/log.base

rm -rf lsa_adjoint/eig

echo "=== All example case outputs removed ==="
