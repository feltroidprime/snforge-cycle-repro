use crate::ntt::ntt_512;

#[executable]
pub fn main(input: Array<felt252>) -> Array<felt252> {
    ntt_512(input)
}
