# snforge Bug: executable + enable-gas = false

**Minimal reproduction of "found an unexpected cycle during cost computation"**

## The Bug

When BOTH of these are true:
1. Package has `[[target.executable]]`
2. Package has `enable-gas = false`

Then `snforge test` fails - even with trivial code like `fn foo() { 42 }`.

## Reproduce

```bash
git clone https://github.com/feltroidprime/snforge-cycle-repro
cd snforge-cycle-repro
snforge test
```

Output:
```
[ERROR] found an unexpected cycle during cost computation
```

## Fix

Comment out either:
- The `[[target.executable]]` section, OR
- The `[cairo] enable-gas = false` section

Then tests pass.

## Files

**src/ntt.cairo** (3 lines):
```cairo
pub fn foo() -> felt252 {
    42
}
```

**Scarb.toml** (key parts):
```toml
[[target.executable]]
name = "my_executable"
function = "cycle_repro::programs::bench_ntt::main"

[cairo]
enable-gas = false  # Comment this out and tests pass
```

## Environment

- scarb 2.15.1
- snforge 0.55.0
