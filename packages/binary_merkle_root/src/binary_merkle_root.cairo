use core::integer::{u32, u8};
use core::poseidon::poseidon_hash_span;

fn poseidon2(left: felt252, right: felt252) -> felt252 {
    poseidon_hash_span([left, right].span())
}

pub fn binary_merkle_root<const MAX_DEPTH: u32>(
    leaf: felt252, depth: u32, indices: [u8; MAX_DEPTH], siblings: [felt252; MAX_DEPTH],
) -> felt252 {
    let mut node: felt252 = leaf;
    let indices_span = indices.span();
    let siblings_span = siblings.span();

    let mut i: u32 = 0;
    while i < MAX_DEPTH {
        if i < depth {
            let index: u8 = *indices_span[i];

            let sibling: felt252 = *siblings_span[i];

            let (left, right) = if index == 0 {
                (node, sibling)
            } else {
                (sibling, node)
            };

            node = poseidon2(left, right);
        }

        i = i + 1;
    }

    node
}
