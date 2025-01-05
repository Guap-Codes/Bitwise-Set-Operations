// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../src/SetOperations.sol";

/// @title SetOpsInvariants - Invariant tests for SetOperations contract using bitmasks
/// @notice This contract tests the invariants of the SetOperations contract
/// @dev Uses Forge's Test library for unit testing
contract SetOpsInvariants is Test {
    SetOperations setOps;

    /// @notice Sets up the test environment by deploying a new SetOperations contract
    function setUp() public {
        setOps = new SetOperations();
    }

    /// @notice Tests the idempotent law for union operation
    /// @param a The set to test
    function testUnionIdempotent(uint256 a) public {
        assertEq(setOps.union(a, a), a, "Union with self should equal self");
    }

    /// @notice Tests the idempotent law for intersection operation
    /// @param a The set to test
    function testIntersectionIdempotent(uint256 a) public {
        assertEq(
            setOps.intersection(a, a),
            a,
            "Intersection with self should equal self"
        );
    }

    /// @notice Tests the commutative law for union operation
    /// @param a The first set to test
    /// @param b The second set to test
    function testUnionCommutative(uint256 a, uint256 b) public {
        assertEq(
            setOps.union(a, b),
            setOps.union(b, a),
            "Union should be commutative"
        );
    }

    /// @notice Tests the commutative law for intersection operation
    /// @param a The first set to test
    /// @param b The second set to test
    function testIntersectionCommutative(uint256 a, uint256 b) public {
        assertEq(
            setOps.intersection(a, b),
            setOps.intersection(b, a),
            "Intersection should be commutative"
        );
    }

    /// @notice Tests the associative law for union operation
    /// @param a The first set to test
    /// @param b The second set to test
    /// @param c The third set to test
    function testUnionAssociative(uint256 a, uint256 b, uint256 c) public {
        assertEq(
            setOps.union(setOps.union(a, b), c),
            setOps.union(a, setOps.union(b, c)),
            "Union should be associative"
        );
    }

    /// @notice Tests the associative law for intersection operation
    /// @param a The first set to test
    /// @param b The second set to test
    /// @param c The third set to test
    function testIntersectionAssociative(
        uint256 a,
        uint256 b,
        uint256 c
    ) public {
        assertEq(
            setOps.intersection(setOps.intersection(a, b), c),
            setOps.intersection(a, setOps.intersection(b, c)),
            "Intersection should be associative"
        );
    }

    /// @notice Tests the distributive law of union over intersection
    /// @param a The first set to test
    /// @param b The second set to test
    /// @param c The third set to test
    function testDistributiveUnionOverIntersection(
        uint256 a,
        uint256 b,
        uint256 c
    ) public {
        assertEq(
            setOps.intersection(a, setOps.union(b, c)),
            setOps.union(setOps.intersection(a, b), setOps.intersection(a, c)),
            "Union should distribute over intersection"
        );
    }

    /// @notice Tests the distributive law of intersection over union
    /// @param a The first set to test
    /// @param b The second set to test
    /// @param c The third set to test
    function testDistributiveIntersectionOverUnion(
        uint256 a,
        uint256 b,
        uint256 c
    ) public {
        assertEq(
            setOps.union(a, setOps.intersection(b, c)),
            setOps.intersection(setOps.union(a, b), setOps.union(a, c)),
            "Intersection should distribute over union"
        );
    }

    /// @notice Tests the double complement law
    /// @param a The set to test
    function testDoubleComplementLaw(uint256 a) public {
        assertEq(
            setOps.complement(setOps.complement(a)),
            a,
            "Double complement should equal self"
        );
    }

    /// @notice Tests DeMorgan's first law
    /// @param a The first set to test
    /// @param b The second set to test
    function testDeMorgansLaw1(uint256 a, uint256 b) public {
        assertEq(
            setOps.complement(setOps.union(a, b)),
            setOps.intersection(setOps.complement(a), setOps.complement(b)),
            "DeMorgan's Law: complement of union equals intersection of complements"
        );
    }

    /// @notice Tests DeMorgan's second law
    /// @param a The first set to test
    /// @param b The second set to test
    function testDeMorgansLaw2(uint256 a, uint256 b) public {
        assertEq(
            setOps.complement(setOps.intersection(a, b)),
            setOps.union(setOps.complement(a), setOps.complement(b)),
            "DeMorgan's Law: complement of intersection equals union of complements"
        );
    }

    /// @notice Tests the subset and superset relationship
    /// @param a The first set to test
    /// @param b The second set to test
    function testSubsetSupersetRelationship(uint256 a, uint256 b) public {
        if (setOps.isSubset(a, b)) {
            assertTrue(
                setOps.isSuperset(b, a),
                "If A is subset of B, then B must be superset of A"
            );
        }
    }

    /// @notice Tests the commutative property of symmetric difference
    /// @param a The first set to test
    /// @param b The second set to test
    function testSymmetricDifferenceCommutative(uint256 a, uint256 b) public {
        assertEq(
            setOps.symmetricDifference(a, b),
            setOps.symmetricDifference(b, a),
            "Symmetric difference should be commutative"
        );
    }

    /// @notice Tests the property of symmetric difference with self
    /// @param a The set to test
    function testSymmetricDifferenceWithSelf(uint256 a) public {
        assertEq(
            setOps.symmetricDifference(a, a),
            0,
            "Symmetric difference with self should be empty set"
        );
    }
}
