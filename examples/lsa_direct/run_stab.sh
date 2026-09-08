#!/bin/bash
set -e
cd "$(dirname "$0")"

NP=${NP:-8}

# requires output_base/reconstr_Wi0.4.sol (run run_baseflow.sh first)
ff-mpirun -np "$NP" ../../src/lsa_direct.edp -Wi 0.4
