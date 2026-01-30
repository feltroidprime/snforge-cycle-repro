use crate::ntt::ntt_512;
use crate::zq::{Zq, from_u16, to_u16};

#[executable]
pub fn main(input: Array<u16>) -> Array<u16> {
    // Convert input to Zq
    let mut f: Array<Zq> = array![];
    for val in input {
        f.append(from_u16(val));
    }
    
    // Run NTT
    let result = ntt_512(f);
    
    // Convert output back to u16
    let mut output: Array<u16> = array![];
    for val in result {
        output.append(to_u16(val));
    }
    output
}
