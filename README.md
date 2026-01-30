# Minimal Reproduction: "unexpected cycle during cost computation" in snforge

This package demonstrates a bug where `snforge test` fails with "found an unexpected cycle during cost computation" when compiling valid Cairo code that uses BoundedInt operations.

## Environment

- snforge: 0.55.0
- universal-sierra-compiler: 2.7.0
- scarb: 2.15.1
- Cairo: 2.15.0

## Reproduction Steps

```bash
cd cycle_repro
snforge test
```

**Expected:** Tests pass
**Actual:**
```
[ERROR] found an unexpected cycle during cost computation
[ERROR] Error while compiling Sierra. Make sure you have the latest universal-sierra-compiler binary installed.
```

## Key Files

- `src/ntt.cairo` - Auto-generated NTT (Number Theoretic Transform) using BoundedInt operations (~35k lines, 1982 type definitions)
- `src/zq.cairo` - BoundedInt helper types and operations for modular arithmetic
- `src/programs/bench_ntt.cairo` - **The trigger:** An `#[executable]` function that uses the NTT

## Root Cause

The issue occurs when:
1. A package has an `#[executable]` function that uses BoundedInt-heavy code
2. `snforge test` compiles the test Sierra
3. `universal-sierra-compiler` (USC) tries to compute gas costs via `calc_metadata()`
4. The cost computation algorithm detects a "cycle" in the dependency graph

**Workaround:** The same code compiles successfully with `scarb build` because executables are compiled with `enable_gas = false`, which uses `calc_metadata_ap_change_only()` instead - skipping the problematic cost computation.

## Minimal vs Full

This is the minimal reproduction. The original issue was discovered in a larger package with ~35k lines of auto-generated NTT code. The key trigger is having an `#[executable]` function that references BoundedInt-heavy code.

Without the `#[executable]` function in `programs/bench_ntt.cairo`, the tests pass.
