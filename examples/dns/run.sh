#!/bin/bash
set -e
cd "$(dirname "$0")"

NP=${NP:-8}
wi=${wi:-0.4}
tEnd=${tEnd:-400}
dt=${dt:-1e-3}

echo "### Wi = $wi, tEnd = $tEnd, dt = $dt ###"
exec ff-mpirun -np "$NP" ../../src/dns.edp -Wi "$wi" -tEnd "$tEnd" -dt "$dt" > log.dns
