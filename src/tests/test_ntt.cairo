use crate::ntt::reduce;

#[test]
fn test_reduce() {
    let result = reduce(42);
    assert_eq!(result, 42);
}
