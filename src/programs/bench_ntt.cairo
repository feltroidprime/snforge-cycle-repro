use crate::ntt::reduce;

#[executable]
pub fn main(input: felt252) -> felt252 {
    reduce(input)
}
