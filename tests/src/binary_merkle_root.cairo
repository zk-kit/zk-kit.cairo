use zk_kit_binary_merkle_root::binary_merkle_root::binary_merkle_root;

#[cfg(test)]
mod tests {
    use super::{binary_merkle_root};

    #[test]
    fn test_one_level() {
        //          Root:
        //          1557996165160500454210437319447297236715335099509187222888255133199463084263
        //         /    \
        //        1      2

        let identity_commitment = 2;
        // One level, depth = 1
        let merkle_proof_length = 1;
        let merkle_proof_indices = [1, 0];
        let merkle_proof_siblings = [1, 0];
        let root: felt252 =
            1557996165160500454210437319447297236715335099509187222888255133199463084263;
        let root_result = binary_merkle_root(
            identity_commitment, merkle_proof_length, merkle_proof_indices, merkle_proof_siblings,
        );

        assert!(root_result == root);
    }

    #[test]
    fn test_odd_number_of_leaves() {
        //              Root: 83911946338641046416368892390227077540659630039857288895139472493910144923
        //                    /                                                                     \
        //  1557996165160500454210437319447297236715335099509187222888255133199463084263             3
        //        /              \                                                                   |
        //       1                2                                                                  3

        let identity_commitment =
            3;
        let merkle_proof_length = 1;
        let merkle_proof_indices = [1, 0];
        let merkle_proof_siblings = [
            1557996165160500454210437319447297236715335099509187222888255133199463084263,
            0,
        ];
        let root = 83911946338641046416368892390227077540659630039857288895139472493910144923;
        let root_result = binary_merkle_root(
            identity_commitment,
            merkle_proof_length,
            merkle_proof_indices,
            merkle_proof_siblings,
        );

        assert!(root_result == root);
    }

    #[test]
    fn test_depth_less_than_max_depth() {
        //               Root: -178099831789568785656038144209030303494497580673807434991366860246645633115
        //                      /                                                                     \
        // 1557996165160500454210437319447297236715335099509187222888255133199463084263   984631471205578712614553929895140960202851439944671757216493909002271097326
        //          /              \                                                                             /                                    \
        //         1                2                                                                           3                                       4

        let identity_commitment = 3;
        // depth = 2 which is < max depth = 5
        let merkle_proof_length = 2;
        let merkle_proof_indices = [0, 1, 0, 0, 0];
        let merkle_proof_siblings =
            [4, 1557996165160500454210437319447297236715335099509187222888255133199463084263, 0, 0, 0];
        let root = -178099831789568785656038144209030303494497580673807434991366860246645633115;
        let root_result = binary_merkle_root(
            identity_commitment,
            merkle_proof_length,
            merkle_proof_indices,
            merkle_proof_siblings,
        );

        assert!(root_result == root);
    }

    #[test]
    fn test_depth_equals_max_depth() {
        //              Root: 19646466727209028632368918362567300896600724196464472518263335051880792850046
        //                    /                                                                     \
        //  7853200120776062878684798364095072458815029376092732009249414926327459813530   3477366564967156727841823348488314755036194240340197326130499876568103937279
        //        /              \                                                                   /              \
        //       1                2                                                                 3                   4

        let identity_commitment = 4;
        // depth = 2 which is = max depth = 2
        let merkle_proof_length = 2;
        let merkle_proof_indices = [1, 1];
        let merkle_proof_siblings =
            [3, 1557996165160500454210437319447297236715335099509187222888255133199463084263];
        let root = -178099831789568785656038144209030303494497580673807434991366860246645633115;
        let root_result = binary_merkle_root(
            identity_commitment,
            merkle_proof_length,
            merkle_proof_indices,
            merkle_proof_siblings,
        );

        assert!(root_result == root);
    }

    #[test]
    #[should_panic]
    fn test_incorrect_commitment_value() {
        //              Root: 19646466727209028632368918362567300896600724196464472518263335051880792850046
        //                    /                                                                     \
        //  7853200120776062878684798364095072458815029376092732009249414926327459813530   3477366564967156727841823348488314755036194240340197326130499876568103937279
        //        /              \                                                                   /              \
        //       1                2                                                                 3                   4

        // This test is expected to fail because the identity_commitment value is incorrect, this was not the one used to generate the root expected.
        let identity_commitment = 5;
        let merkle_proof_length = 2;
        let merkle_proof_indices = [1, 1];
        let merkle_proof_siblings =
            [3, 1557996165160500454210437319447297236715335099509187222888255133199463084263];
        let root = -178099831789568785656038144209030303494497580673807434991366860246645633115;
        let root_result = binary_merkle_root(
            identity_commitment,
            merkle_proof_length,
            merkle_proof_indices,
            merkle_proof_siblings,
        );

        assert!(root_result == root);
    }

    #[test]
    #[should_panic]
    fn test_incorrect_depth_value() {
        //              Root: 19646466727209028632368918362567300896600724196464472518263335051880792850046
        //                    /                                                                     \
        //  7853200120776062878684798364095072458815029376092732009249414926327459813530   3477366564967156727841823348488314755036194240340197326130499876568103937279
        //        /              \                                                                   /              \
        //       1                2                                                                 3                   4
        let identity_commitment = 4;
        // This test is expected to fail because the depth value is incorrect, it should be 2.
        let merkle_proof_length = 1;
        let merkle_proof_indices = [1, 1];
        let merkle_proof_siblings =
            [3, 1557996165160500454210437319447297236715335099509187222888255133199463084263];
        let root = -178099831789568785656038144209030303494497580673807434991366860246645633115;
        let root_result = binary_merkle_root(
            identity_commitment,
            merkle_proof_length,
            merkle_proof_indices,
            merkle_proof_siblings,
        );

        assert!(root_result == root);
    }

    #[test]
    #[should_panic]
    fn test_incorrect_proof_indices_values() {
        //              Root: 19646466727209028632368918362567300896600724196464472518263335051880792850046
        //                    /                                                                     \
        //  7853200120776062878684798364095072458815029376092732009249414926327459813530   3477366564967156727841823348488314755036194240340197326130499876568103937279
        //        /              \                                                                   /              \
        //       1                2                                                                 3                   4
        let identity_commitment = 4;
        let merkle_proof_length = 2;
        // This test is expected to fail because the proof indices values are incorrect.
        let merkle_proof_indices = [0, 0];
        let merkle_proof_siblings =
            [3, 1557996165160500454210437319447297236715335099509187222888255133199463084263];
        let root = -178099831789568785656038144209030303494497580673807434991366860246645633115;
        let root_result = binary_merkle_root(
            identity_commitment,
            merkle_proof_length,
            merkle_proof_indices,
            merkle_proof_siblings,
        );

        assert!(root_result == root);
    }

    #[test]
    #[should_panic]
    fn test_incorrect_siblings_values() {
        //              Root: 19646466727209028632368918362567300896600724196464472518263335051880792850046
        //                    /                                                                     \
        //  7853200120776062878684798364095072458815029376092732009249414926327459813530   3477366564967156727841823348488314755036194240340197326130499876568103937279
        //        /              \                                                                   /              \
        //       1                2                                                                 3                   4
        let identity_commitment = 4;
        let merkle_proof_length = 2;
        let merkle_proof_indices = [0, 0];
        // This test is expected to fail because the proof siblings values are incorrect, these were not the ones used to generate the root expected.
        let merkle_proof_siblings = [3, 4];
        let root = -178099831789568785656038144209030303494497580673807434991366860246645633115;
        let root_result = binary_merkle_root(
            identity_commitment,
            merkle_proof_length,
            merkle_proof_indices,
            merkle_proof_siblings,
        );

        assert!(root_result == root);
    }

}
