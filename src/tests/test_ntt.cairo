use crate::ntt::ntt_512;

#[test]
fn test_ntt_512_zeros() {
    let mut f: Array<felt252> = array![];
    let mut i: usize = 0;
    while i < 512 {
        f.append(0);
        i += 1;
    }
    let result = ntt_512(f);
    assert_eq!(result.len(), 512);
}
