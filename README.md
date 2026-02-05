# snforge Cycle Detection Bug Reproduction

Minimal reproduction of the "found an unexpected cycle during cost computation" error in snforge.

## Setup

```bash
git clone https://github.com/feltroidprime/snforge-cycle-repro
cd snforge-cycle-repro
```

## Reproduce the Bug

```bash
snforge test
```

Expected output:
```
   Compiling test(cycle_repro_unittest) ...
    Finished `dev` profile target(s) in ~10 seconds
[ERROR] found an unexpected cycle during cost computation
[ERROR] Error while compiling Sierra...
```

## Verify Code is Valid

```bash
scarb build
```

This succeeds, showing the Cairo code itself is valid.

## Analysis

The issue occurs when:
1. A package has an `#[executable]` function
2. The package uses BoundedInt types with DivRemHelper implementations
3. `snforge test` compiles with the universal-sierra-compiler

The root cause appears to be that `scarb build` uses `enable_gas = false` for executables, while universal-sierra-compiler performs full gas cost computation, triggering false cycle detection in the type hierarchy.

## Key Files

- `src/ntt.cairo` - Auto-generated NTT using felt252 mode with BoundedInt reduction (~12K lines)
- `src/programs/bench_ntt.cairo` - **The trigger:** An `#[executable]` function that uses the NTT

Without the `#[executable]` function, the tests pass.

## Environment

- scarb 2.15.1
- snforge 0.55.0
- Cairo 2.15.1
