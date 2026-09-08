#!/bin/bash
set -e
cd "$(dirname "$0")"

NP=${NP:-8}

# writes output_base/reconstr_Wi*.sol for Wi = 0.05, 0.10, ..., 0.40
ff-mpirun -np "$NP" ../../src/baseflow.edp > log.base
