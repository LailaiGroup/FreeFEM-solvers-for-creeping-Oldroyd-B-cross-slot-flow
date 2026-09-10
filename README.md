# FreeFEM++ solvers for creeping Oldroyd-B cross-slot flow

FreeFEM++ solvers for the cross-slot problem: full DNS, direct
linear stability analysis (LSA), and the adjoint LSA.

```
mesh/            shared mesh (M2.msh), used by all three cases
src/             solver code
  dns.edp              DNS
  baseflow.edp         base flow continuation (Wi: 0.05 -> 0.4)
  lsa_direct.edp       direct LSA (reads a base flow, writes eigenvalues/modes)
  lsa_adjoint.edp      adjoint LSA (reads lsa_direct's base flow)
examples/        one runnable case per code, run from inside its own directory
  Allrun.sh            runs all three cases in dependency order
  Allclean.sh          removes generated outputs from all three cases
  dns/                 run.sh, clean.sh, clean_output.sh
  lsa_direct/          run_baseflow.sh (base flow), run_stab.sh (Wi=0.4 eigenproblem)
  lsa_adjoint/         run_adjoint.sh (Wi=0.4 adjoint eigenproblem)
```

## Requirements

FreeFEM++ built with PETSc, PETSc-complex, and SLEPc (needed for the
`lsa_direct.edp`/`lsa_adjoint.edp` eigensolvers), plus an MPI runtime.
Verified working with **FreeFEM++ v4.9** (PETSc 3.15) built against MPICH
3.3rc1, and with **FreeFEM++ v4.15**.

## Running

`ff-mpirun` (FreeFEM's MPI launcher) must be on `PATH`. Each script `cd`s
into its own directory and invokes the solver via a `../../src/*.edp`
relative path, so they can be run from anywhere, e.g. `./run.sh`. All scripts
run with 8 MPI ranks by default; override with `NP=<n>`.

Run everything at once with `examples/Allrun.sh`, and remove all
generated outputs with `examples/Allclean.sh`. Or run cases individually:

- `examples/dns/run.sh`: self-contained. `wi` defaults to 0.4, and the run
  length is set by physical end time: `tEnd` (default 400) with `dt`
  (default 1e-3), from which `dns.edp` computes the step count
  `M = tEnd/dt`. E.g. `tEnd=1 ./run.sh` for a short test.
- `examples/lsa_direct/run_baseflow.sh`: run first — it writes
  `output_base/reconstr_Wi*.sol` for Wi = 0.05, 0.10, ..., 0.40.
  `examples/lsa_direct/run_stab.sh`: run after, solves the Wi=0.4 eigenproblem
  and writes `eig/`.
- `examples/lsa_adjoint/run_adjoint.sh`: depends on
  `examples/lsa_direct/output_base/reconstr_Wi0.4.sol` existing, so run
  `lsa_direct/run_baseflow.sh` first.



## Citation

This code accompanies the paper:

> K. Zhang, Z. Wang & L. Zhu, *Revisiting creeping viscoelastic cross-slot
> flow: Global linear stability and structural sensitivity analyses*,
> arXiv:2606.21554. <https://arxiv.org/abs/2606.21554>

If you find our script useful for your research, please acknowledge our work by citing it!

```bibtex
@article{zhang2026crossslot,
  title   = {Revisiting creeping viscoelastic cross-slot flow: Global linear
             stability and structural sensitivity analyses},
  author  = {Zhang, Kun and Wang, Zhanwen and Zhu, Lailai},
  journal = {arXiv preprint arXiv:2606.21554},
  year    = {2026},
  url     = {https://arxiv.org/abs/2606.21554}
}
```
