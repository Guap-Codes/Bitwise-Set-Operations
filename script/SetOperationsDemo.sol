// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "../src/SetOperations.sol";

/// @title SetOperationsDemo - Demonstrates the usage of the SetOperations contract
/// @notice This script performs various set operations and logs the results
contract SetOperationsDemo {
    SetOperations private setOps;

    /// @notice Initializes the contract with a new SetOperations instance
    constructor() {
        setOps = new SetOperations();
    }

    /// @notice Demonstrates the union operation
    function demoUnion() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 12; // Set {2,3} (binary: 1100)
        return setOps.union(a, b); // Expected: 14 (binary: 1110)
    }

    /// @notice Demonstrates the intersection operation
    function demoIntersection() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 12; // Set {2,3} (binary: 1100)
        return setOps.intersection(a, b); // Expected: 8 (binary: 1000)
    }

    /// @notice Demonstrates the difference operation
    function demoDifference() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 12; // Set {2,3} (binary: 1100)
        return setOps.difference(a, b); // Expected: 2 (binary: 0010)
    }

    /// @notice Demonstrates the symmetric difference operation
    function demoSymmetricDifference() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 12; // Set {2,3} (binary: 1100)
        return setOps.symmetricDifference(a, b); // Expected: 6 (binary: 0110)
    }

    /// @notice Demonstrates the subset operation
    function demoIsSubset() public returns (bool) {
        uint256 subset = 8; // Set {3} (binary: 1000)
        uint256 superset = 10; // Set {1,3} (binary: 1010)
        return setOps.isSubset(subset, superset); // Expected: true
    }

    /// @notice Demonstrates the superset operation
    function demoIsSuperset() public returns (bool) {
        uint256 subset = 8; // Set {3} (binary: 1000)
        uint256 superset = 10; // Set {1,3} (binary: 1010)
        return setOps.isSuperset(superset, subset); // Expected: true
    }

    /// @notice Demonstrates the complement operation
    function demoComplement() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        return setOps.complement(a); // Expected: ~10
    }

    /// @notice Demonstrates the cardinality operation
    function demoCardinality() public view returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        return setOps.cardinality(a); // Expected: 2
    }

    /// @notice Demonstrates the shift left union operation
    function demoShiftLeftUnion() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 1; // Set {0} (binary: 0001)
        uint256 positions = 1;
        return setOps.shiftLeftUnion(a, b, positions); // Expected: 21 (binary: 10101)
    }

    /// @notice Demonstrates the shift right intersection operation
    function demoShiftRightIntersection() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 5; // Set {0,2} (binary: 0101)
        uint256 positions = 1;
        return setOps.shiftRightIntersection(a, b, positions); // Expected: 5 (binary: 0101)
    }

    /// @notice Demonstrates the rotate left difference operation
    function demoRotateLeftDifference() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 6; // Set {1,2} (binary: 0110)
        uint256 positions = 1;
        return setOps.rotateLeftDifference(a, b, positions); // Expected: 16 (binary: 10000)
    }

    /// @notice Demonstrates the rotate right symmetric difference operation
    function demoRotateRightSymmetricDifference() public returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        uint256 b = 6; // Set {1,2} (binary: 0110)
        uint256 positions = 1;
        return setOps.rotateRightSymmetricDifference(a, b, positions); // Expected: 3 (binary: 0011)
    }

    /// @notice Demonstrates the clear elements operation
    function demoClearElements() public view returns (uint256) {
        uint256 a = 15; // Set {0,1,2,3} (binary: 1111)
        uint256 mask = 10; // Clear {1,3} (binary: 1010)
        return setOps.clearElements(a, mask); // Expected: 5 (binary: 0101)
    }

    /// @notice Demonstrates the set elements operation
    function demoSetElements() public view returns (uint256) {
        uint256 a = 5; // Set {0,2} (binary: 0101)
        uint256 mask = 10; // Set {1,3} (binary: 1010)
        return setOps.setElements(a, mask); // Expected: 15 (binary: 1111)
    }

    /// @notice Demonstrates the toggle elements operation
    function demoToggleElements() public view returns (uint256) {
        uint256 a = 15; // Set {0,1,2,3} (binary: 1111)
        uint256 mask = 10; // Toggle {1,3} (binary: 1010)
        return setOps.toggleElements(a, mask); // Expected: 5 (binary: 0101)
    }

    /// @notice Demonstrates the extract subset operation
    function demoExtractSubset() public view returns (uint256) {
        uint256 a = 240; // Set {4,5,6,7} (binary: 11110000)
        uint256 start = 4;
        uint256 length = 4;
        return setOps.extractSubset(a, start, length); // Expected: 15 (binary: 1111)
    }

    /// @notice Demonstrates the count leading zeros operation
    function demoCountLeadingZeros() public view returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        return setOps.countLeadingZeros(a); // Expected: 252 (256 - 4)
    }

    /// @notice Demonstrates the count trailing zeros operation
    function demoCountTrailingZeros() public view returns (uint256) {
        uint256 a = 10; // Set {1,3} (binary: 1010)
        return setOps.countTrailingZeros(a); // Expected: 1
    }
}
