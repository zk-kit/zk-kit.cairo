# Binary Merkle Root Library

This project contains the Binary Merkle Root Cairo library. It's used to calculate the root of a binary Merkle tree (including the LeanIMT).

## Import the library

To import the library, add the lib to the `Scarb.toml` file. For example:

```toml
[dependencies]
cairo_binary_merkle_root = { git = "https://github.com/vplasencia/cairo-binary-merkle-root" }
```

## Usage

```cairo
use core::integer::{u32, u8};
use cairo_binary_merkle_root::binary_merkle_root::binary_merkle_root;

#[executable]
fn main(
    secret: felt252,
    merkle_proof_length: u32,
    merkle_proof_indices: [u8; MAX_DEPTH],
    merkle_proof_siblings: [felt252; MAX_DEPTH],
) -> felt252 {
    // Calculate commitment.
    let commitment = ... ; // Calculate commitment

    // Calculate Merkle root.
    let merkle_root = binary_merkle_root(commitment, merkle_proof_length, merkle_proof_indices, merkle_proof_siblings);

    // Output the Merkle root.
    merkle_root
}
```

## Build

```sh
scarb build
```

## Run tests

```sh
scarb test
```

## References

- [Cairo docs](https://www.cairo-lang.org/)
- [RLN V2 Circom circuits](https://github.com/Rate-Limiting-Nullifier/circom-rln)
- [RLN V2 Noir circuits](https://github.com/Rate-Limiting-Nullifier/noir-rln)
- [RLN V3 Circom circuits](https://github.com/Rate-Limiting-Nullifier/rln-v3/tree/main/circuits/circom)
- [RLN V3 Noir circuits](https://github.com/Rate-Limiting-Nullifier/rln-v3/tree/main/circuits/noir)
- [LeanIMT paper](https://zkkit.org/leanimt-paper.pdf)
- [Binary Merkle Tree Root Circom circuits](https://github.com/zk-kit/zk-kit.circom/tree/main/packages/binary-merkle-root)
- [Binary Merkle Tree Root Noir circuits](https://github.com/zk-kit/zk-kit.noir/tree/main/packages/binary-merkle-root)
- [zk-api-credits-stwo-cairo circuits](https://github.com/omarespejel/zk-api-credits-stwo-cairo)
