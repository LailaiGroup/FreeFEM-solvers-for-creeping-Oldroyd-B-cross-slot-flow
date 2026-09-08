#!/bin/bash
set -e
cd "$(dirname "$0")"

NP=${NP:-8}

# requires ../lsa_direct/output_base/reconstr_Wi0.4.sol
# (run examples/lsa_direct/run_baseflow.sh first)
ff-mpirun -np "$NP" ../../src/lsa_adjoint.edp -Wi 0.4
