// Minimal reproduction of "unexpected cycle during cost computation" bug
//
// To reproduce:
//   cd /path/to/cycle_repro && snforge test
//
// Expected: Tests pass
// Actual: [ERROR] found an unexpected cycle during cost computation

pub mod ntt;
pub mod programs;

#[cfg(test)]
mod tests {
    mod test_ntt;
}
