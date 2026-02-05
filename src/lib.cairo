// Minimal reproduction: executable + enable-gas = false
pub mod ntt;
pub mod programs;

#[cfg(test)]
mod tests {
    mod test_ntt;
}
