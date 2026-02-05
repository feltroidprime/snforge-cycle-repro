# snforge Cycle Detection Bug - Minimal Reproduction

Minimal reproduction of the "found an unexpected cycle during cost computation" error in snforge.

## The Bug

When ALL THREE of these conditions are met:
1. Code uses `bounded_int_div_rem`
2. Package has a `[[target.executable]]` defined
3. `enable-gas = false` in Scarb.toml

Then `snforge test` fails with:
```
[ERROR] found an unexpected cycle during cost computation
```

Remove ANY of the three conditions and tests pass.

## Reproduce

```bash
git clone https://github.com/feltroidprime/snforge-cycle-repro
cd snforge-cycle-repro
snforge test
```

## Verify Each Condition

### Without enable-gas = false: PASSES
```bash
# Comment out [cairo] section in Scarb.toml
snforge test  # Works!
```

### Without executable: PASSES
```bash
# Comment out [[target.executable]] in Scarb.toml
snforge test  # Works!
```

### Without bounded_int_div_rem: PASSES
```bash
# Replace ntt.cairo with code that doesn't use bounded_int_div_rem
snforge test  # Works!
```

## Analysis

The issue is that when `enable-gas = false` is set, scarb compiles without gas metering, but snforge's universal-sierra-compiler still tries to compute gas costs. The combination with `bounded_int_div_rem` triggers a false cycle detection.

## Environment

- scarb 2.15.1
- snforge 0.55.0
- Cairo 2.15.1
