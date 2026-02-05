// Minimal bounded_int_div_rem usage that triggers the bug
use corelib_imports::bounded_int::{BoundedInt, DivRemHelper, UnitInt, bounded_int_div_rem};

type Q = UnitInt<12289>;
type T = BoundedInt<0, 100000>;

impl DivRemImpl of DivRemHelper<T, Q> {
    type DivT = BoundedInt<0, 8>;
    type RemT = BoundedInt<0, 12288>;
}

pub fn reduce(val: felt252) -> felt252 {
    let t: T = val.try_into().unwrap();
    let (_q, _r) = bounded_int_div_rem(t, 12289);
    val
}
