// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../src/SetOperations.sol";

/// @title BitmaskSetOperationsTest - Unit tests for SetOperations contract using bitmasks
/// @notice This contract tests the functionality of the SetOperations contract
/// @dev Uses Forge's Test library for unit testing
contract BitmaskSetOperationsTest is Test {
    SetOperations setOps;

    /// @notice Sets up the test environment by deploying a new SetOperations contract
    function setUp() public {
        setOps = new SetOperations();
    }

    /// @notice Tests the union operation
    function testUnion() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 12; // Set {2,3} (binary: 1100)
        uint256 expected = 14; // Set {1,2,3} (binary: 1110)
        assertEq(setOps.union(a, b), expected);
    }

    /// @notice Tests the intersection operation
    function testIntersection() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 12; // Set {2,3} (binary: 1100)
        uint256 expected = 8; // Set {3} (binary: 1000)
        assertEq(setOps.intersection(a, b), expected);
    }

    /// @notice Tests the difference operation
    function testDifference() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 12; // Set {2,3} (binary: 1100)
        uint256 expected = 2; // Set {1} (binary: 0010)
        assertEq(setOps.difference(a, b), expected);
    }

    /// @notice Tests the symmetric difference operation
    function testSymmetricDifference() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 12; // Set {2,3} (binary: 1100)
        uint256 expected = 6; // Set {1,2} (binary: 0110)
        assertEq(setOps.symmetricDifference(a, b), expected);
    }

    /// @notice Tests the subset operation
    function testIsSubset() public {
        uint256 subset = 8; // Set {3} (binary: 1000)
        uint256 superset = 10; // Set {1,3} (binary: 1010)
        assertTrue(setOps.isSubset(subset, superset));
        assertFalse(setOps.isSubset(superset, subset));
    }

    /// @notice Tests the superset operation
    function testIsSuperset() public {
        uint256 subset = 8; // Set {3} (binary: 1000)
        uint256 superset = 10; // Set {1,3} (binary: 1010)
        assertTrue(setOps.isSuperset(superset, subset));
        assertFalse(setOps.isSuperset(subset, superset));
    }

    /// @notice Tests the complement operation
    function testComplement() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 expected = ~uint256(10);
        assertEq(setOps.complement(a), expected);
    }

    /// @notice Tests the cardinality operation
    function testCardinality() public view {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 expected = 2;
        assertEq(setOps.cardinality(a), expected);
    }

    /// @notice Tests the shift left union operation
    function testShiftLeftUnion() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 1; // Set {0} (binary: 0001)
        uint256 positions = 1;
        uint256 expected = 21; // Set {0,2,4} (binary: 10101)
        assertEq(setOps.shiftLeftUnion(a, b, positions), expected);
    }

    /// @notice Tests the shift right intersection operation
    function testShiftRightIntersection() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 5; // Set {0,2} (binary: 0101)
        uint256 positions = 1;
        uint256 expected = 5; // Set {0,2} (binary: 0101) = shiftRight(1010,1) AND 0101 = 0101 AND 0101
        assertEq(setOps.shiftRightIntersection(a, b, positions), expected);
    }

    /// @notice Tests the rotate left difference operation
    function testRotateLeftDifference() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 6; // Set {1,2} (binary: 0110)
        uint256 positions = 1;
        uint256 expected = 16; // Set {4} (binary: 10000)
        assertEq(setOps.rotateLeftDifference(a, b, positions), expected);
    }

    /// @notice Tests the rotate right symmetric difference operation
    function testRotateRightSymmetricDifference() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 6; // Set {1,2} (binary: 0110)
        uint256 positions = 1;
        uint256 expected = 3; // Set {0,1} (binary: 0011) = rotateRight(1010,1) XOR 0110 = 0101 XOR 0110
        assertEq(
            setOps.rotateRightSymmetricDifference(a, b, positions),
            expected
        );
    }

    /// @notice Tests the clear elements operation
    function testClearElements() public {
        uint256 a = 15; // Set {0,1,2,3} (binary: 1111)
        uint256 mask = 10; // Clear {1,3} (binary: 1010)
        uint256 expected = 5; // Set {0,2} (binary: 0101)
        assertEq(setOps.clearElements(a, mask), expected);
    }

    /// @notice Tests the set elements operation
    function testSetElements() public {
        uint256 a = 5; // Set {0,2} (binary: 0101)
        uint256 mask = 10; // Set {1,3} (binary: 1010)
        uint256 expected = 15; // Set {0,1,2,3} (binary: 1111)
        assertEq(setOps.setElements(a, mask), expected);
    }

    /// @notice Tests the toggle elements operation
    function testToggleElements() public {
        uint256 a = 15; // Set {0,1,2,3} (binary: 1111)
        uint256 mask = 10; // Toggle {1,3} (binary: 1010)
        uint256 expected = 5; // Set {0,2} (binary: 0101)
        assertEq(setOps.toggleElements(a, mask), expected);
    }

    /// @notice Tests the extract subset operation
    function testExtractSubset() public {
        uint256 a = 240; // Set {4,5,6,7} (binary: 11110000)
        uint256 start = 4;
        uint256 length = 4;
        uint256 expected = 15; // Set {0,1,2,3} (binary: 1111)
        assertEq(setOps.extractSubset(a, start, length), expected);
    }

    /// @notice Tests the count leading zeros operation
    function testCountLeadingZeros() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 expected = 252; // 256 - 4
        assertEq(setOps.countLeadingZeros(a), expected);
    }

    /// @notice Tests the count trailing zeros operation
    function testCountTrailingZeros() public {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 expected = 1;
        assertEq(setOps.countTrailingZeros(a), expected);
    }

    /// @notice Tests operations on an empty set
    function testEmptySet() public {
        uint256 empty = 0;
        assertEq(setOps.cardinality(empty), 0);
        assertTrue(setOps.isSubset(empty, 15)); // 15 is binary 1111
        assertFalse(setOps.isSuperset(empty, 1));
    }

    /// @notice Tests operations on a full set
    function testFullSet() public {
        uint256 full = type(uint256).max;
        assertEq(setOps.cardinality(full), 256);
        assertTrue(setOps.isSuperset(full, 15)); // 15 is binary 1111
        assertFalse(setOps.isSubset(full, 15));
    }
}
