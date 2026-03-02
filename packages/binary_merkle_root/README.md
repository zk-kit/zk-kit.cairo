# Binary Merkle Root Library

This project contains the Binary Merkle Root Cairo library. It's used to calculate the root of a binary Merkle tree (including the LeanIMT).

## Installation

Add the package to your project using Scarb:

```bash
scarb add zk_kit_binary_merkle_root
```

Or manually add it to your `Scarb.toml`:

```toml
[dependencies]
zk_kit_binary_merkle_root = "0.1.0"
```

## Usage

```cairo
use core::integer::{u32, u8};
use zk_kit_binary_merkle_root::binary_merkle_root::binary_merkle_root;

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
