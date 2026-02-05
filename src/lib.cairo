// Minimal reproduction of snforge "cycle during cost computation" bug
//
// Trigger conditions:
// 1. bounded_int_div_rem usage
// 2. [[target.executable]] in Scarb.toml
// 3. enable-gas = false in Scarb.toml
//
// Remove any of these and tests pass.

pub mod ntt;
pub mod programs;

#[cfg(test)]
mod tests {
    mod test_ntt;
}
