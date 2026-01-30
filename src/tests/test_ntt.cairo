use crate::ntt::ntt_512;
use crate::zq::{Zq, from_u16, to_u16};

#[test]
fn test_ntt_512_zeros() {
    let mut f: Array<Zq> = array![];
    let mut i: usize = 0;
    while i < 512 {
        f.append(from_u16(0));
        i += 1;
    }
    let result = ntt_512(f);
    assert_eq!(result.len(), 512);
}
