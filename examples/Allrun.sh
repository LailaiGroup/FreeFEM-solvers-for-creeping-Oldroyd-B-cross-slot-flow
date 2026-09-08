#!/bin/bash
# Runs all three example cases. lsa_direct must complete before lsa_adjoint
# (adjoint reads lsa_direct's base flow); dns is independent.
set -e
cd "$(dirname "$0")"

echo "=== lsa_direct: baseflow ==="
(cd lsa_direct && ./run_baseflow.sh)

echo "=== lsa_direct: stab ==="
(cd lsa_direct && ./run_stab.sh)

echo "=== lsa_adjoint ==="
(cd lsa_adjoint && ./run_adjoint.sh)

echo "=== dns ==="
# dns.edp defaults to tEnd=400, far longer than a smoke test needs, so run a
# short one here. Override with DNS_TEND, e.g. DNS_TEND=400 examples/Allrun.sh.
(cd dns && tEnd=${DNS_TEND:-1} ./run.sh)

echo "=== All example cases completed ==="
