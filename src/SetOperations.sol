// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./BitmaskOperations.sol";

/// @title SetOperations - Mathematical Set Operations using Bitmasks
/// @author Guap Codes
/// @notice Provides a complete implementation of mathematical set operations using bitmask representation
/// @dev Implements set operations using efficient bitwise operations through the BitmaskOperations contract
/// @custom:security-contact security@guapcodes.com
contract SetOperations {
    BitmaskOperations private bitmaskOps;

    /// @notice Initializes the contract with a new BitmaskOperations instance
    constructor() {
        bitmaskOps = new BitmaskOperations();
    }

    /// @notice Computes the union of two sets (A ∪ B)
    /// @dev Implements union using bitwise OR operation
    /// @param a First set represented as a bitmask
    /// @param b Second set represented as a bitmask
    /// @return result A bitmask representing all elements that are in either A or B
    function union(uint256 a, uint256 b) public returns (uint256 result) {
        result = bitmaskOps.bitwiseOr(a, b);
    }

    /// @notice Computes the intersection of two sets (A ∩ B)
    /// @dev Implements intersection using bitwise AND operation
    /// @param a First set represented as a bitmask
    /// @param b Second set represented as a bitmask
    /// @return result A bitmask representing all elements that are in both A and B
    function intersection(
        uint256 a,
        uint256 b
    ) public returns (uint256 result) {
        result = bitmaskOps.bitwiseAnd(a, b);
    }

    /// @notice Computes the difference of two sets (A \ B)
    /// @dev Implements set difference using bitwise AND with complement
    /// @param a The set to subtract from (A)
    /// @param b The set to subtract (B)
    /// @return result A bitmask representing all elements that are in A but not in B
    function difference(uint256 a, uint256 b) public returns (uint256 result) {
        result = bitmaskOps.bitwiseAnd(a, bitmaskOps.bitwiseNot(b));
    }

    /// @notice Computes the symmetric difference of two sets (A △ B)
    /// @dev Implements symmetric difference using bitwise XOR operation
    /// @param a First set represented as a bitmask
    /// @param b Second set represented as a bitmask
    /// @return result A bitmask representing all elements that are in either A or B, but not in both
    function symmetricDifference(
        uint256 a,
        uint256 b
    ) public returns (uint256 result) {
        result = bitmaskOps.bitwiseXor(a, b);
    }

    /// @notice Checks if one set is a subset of another (A ⊆ B)
    /// @dev A set A is a subset of B if A ∩ B = A
    /// @param a The potential subset (A)
    /// @param b The potential superset (B)
    /// @return result True if A is a subset of B, false otherwise
    function isSubset(uint256 a, uint256 b) public returns (bool result) {
        result = (bitmaskOps.bitwiseAnd(a, b) == a);
    }

    /// @notice Checks if one set is a superset of another (A ⊇ B)
    /// @dev A set A is a superset of B if A ∩ B = B
    /// @param a The potential superset (A)
    /// @param b The potential subset (B)
    /// @return result True if A is a superset of B, false otherwise
    function isSuperset(uint256 a, uint256 b) public returns (bool result) {
        result = (bitmaskOps.bitwiseAnd(a, b) == b);
    }

    /// @notice Computes the complement of a set (¬A)
    /// @dev Implements complement using bitwise NOT operation
    /// @param a The set to complement
    /// @return result A bitmask representing all elements that are not in A
    function complement(uint256 a) public returns (uint256 result) {
        result = bitmaskOps.bitwiseNot(a);
    }

    /// @notice Computes the cardinality (size) of a set
    /// @dev Counts the number of 1 bits in the bitmask using a loop
    /// @param a The set to compute cardinality for
    /// @return count The number of elements in the set
    function cardinality(uint256 a) public pure returns (uint256 count) {
        count = 0;
        while (a != 0) {
            count += a & 1;
            a >>= 1;
        }
    }

    /// @notice Checks if a set is empty
    /// @dev A set is empty if its bitmask is 0
    /// @param a The set to check
    /// @return result True if the set is empty (contains no elements), false otherwise
    function isEmpty(uint256 a) public pure returns (bool result) {
        result = (a == 0);
    }

    /// @notice Gets the minimum element in the set
    /// @dev Finds the position of the rightmost 1 bit
    /// @param a The set to find the minimum element in
    /// @return result The position of the minimum element (0-based)
    /// @custom:throws "Empty set has no minimum" if the set is empty
    function min(uint256 a) public pure returns (uint256 result) {
        require(a != 0, "Empty set has no minimum");
        result = 0;
        while ((a & 1) == 0) {
            result++;
            a >>= 1;
        }
    }

    /// @notice Gets the maximum element in the set
    /// @dev Finds the position of the leftmost 1 bit
    /// @param a The set to find the maximum element in
    /// @return result The position of the maximum element (0-based)
    /// @custom:throws "Empty set has no maximum" if the set is empty
    function max(uint256 a) public pure returns (uint256 result) {
        require(a != 0, "Empty set has no maximum");
        result = 255;
        while ((a & (1 << result)) == 0) {
            result--;
        }
    }

    /// @notice Computes the shift left union of a set with another set
    /// @dev Shifts the first set to the left by the specified number of positions and computes the union with the second set
    /// @param a The set to shift and union
    /// @param b The set to union with
    /// @param positions The number of positions to shift the first set to the left
    /// @return result A bitmask representing the union of the shifted first set and the second set
    function shiftLeftUnion(
        uint256 a,
        uint256 b,
        uint256 positions
    ) public returns (uint256 result) {
        uint256 shifted = bitmaskOps.bitwiseShiftLeft(a, positions);
        result = bitmaskOps.bitwiseOr(shifted, b);
    }

    /// @notice Computes the shift right intersection of a set with another set
    /// @dev Shifts the first set to the right by the specified number of positions and computes the intersection with the second set
    /// @param a The set to shift and intersect
    /// @param b The set to intersect with
    /// @param positions The number of positions to shift the first set to the right
    /// @return result A bitmask representing the intersection of the shifted first set and the second set
    function shiftRightIntersection(
        uint256 a,
        uint256 b,
        uint256 positions
    ) public returns (uint256 result) {
        uint256 shifted = bitmaskOps.bitwiseShiftRight(a, positions);
        result = bitmaskOps.bitwiseAnd(shifted, b);
    }

    /// @notice Computes the rotate left difference of a set with another set
    /// @dev Rotates the first set to the left by the specified number of positions and computes the difference with the second set
    /// @param a The set to rotate and subtract
    /// @param b The set to subtract
    /// @param positions The number of positions to rotate the first set to the left
    /// @return result A bitmask representing the difference of the rotated first set and the second set
    function rotateLeftDifference(
        uint256 a,
        uint256 b,
        uint256 positions
    ) public returns (uint256 result) {
        uint256 rotated = bitmaskOps.bitwiseRotateLeft(a, positions);
        result = bitmaskOps.bitwiseAnd(rotated, bitmaskOps.bitwiseNot(b));
    }

    /// @notice Computes the rotate right symmetric difference of a set with another set
    /// @dev Rotates the first set to the right by the specified number of positions and computes the symmetric difference with the second set
    /// @param a The set to rotate and compute symmetric difference
    /// @param b The set to compute symmetric difference with
    /// @param positions The number of positions to rotate the first set to the right
    /// @return result A bitmask representing the symmetric difference of the rotated first set and the second set
    function rotateRightSymmetricDifference(
        uint256 a,
        uint256 b,
        uint256 positions
    ) public returns (uint256 result) {
        uint256 rotated = bitmaskOps.bitwiseRotateRight(a, positions);
        result = bitmaskOps.bitwiseXor(rotated, b);
    }

    /// @notice Clears specific elements in a set
    /// @dev Clears the specified elements in the set using bitwise AND with complement
    /// @param a The set to clear elements from
    /// @param mask The bitmask representing the elements to clear
    /// @return result A bitmask representing the set with the specified elements cleared
    function clearElements(
        uint256 a,
        uint256 mask
    ) public view returns (uint256 result) {
        result = bitmaskOps.bitwiseClear(a, mask);
    }

    /// @notice Sets specific elements in a set
    /// @dev Sets the specified elements in the set using bitwise OR
    /// @param a The set to set elements in
    /// @param mask The bitmask representing the elements to set
    /// @return result A bitmask representing the set with the specified elements set
    function setElements(
        uint256 a,
        uint256 mask
    ) public view returns (uint256 result) {
        result = bitmaskOps.bitwiseSet(a, mask);
    }

    /// @notice Toggles specific elements in a set
    /// @dev Toggles the specified elements in the set using bitwise XOR
    /// @param a The set to toggle elements in
    /// @param mask The bitmask representing the elements to toggle
    /// @return result A bitmask representing the set with the specified elements toggled
    function toggleElements(
        uint256 a,
        uint256 mask
    ) public view returns (uint256 result) {
        result = bitmaskOps.bitwiseToggle(a, mask);
    }

    /// @notice Extracts a specific subset from a set
    /// @dev Extracts the specified subset from the set using bitwise AND
    /// @param a The set to extract the subset from
    /// @param start The starting position of the subset
    /// @param length The length of the subset
    /// @return result A bitmask representing the extracted subset
    function extractSubset(
        uint256 a,
        uint256 start,
        uint256 length
    ) public view returns (uint256 result) {
        result = bitmaskOps.bitwiseExtract(a, start, length);
    }

    /// @notice Counts the number of leading zeros in a set
    /// @dev Counts the number of leading zeros in the bitmask
    /// @param a The set to count leading zeros in
    /// @return count The number of leading zeros in the set
    function countLeadingZeros(uint256 a) public view returns (uint256 count) {
        count = bitmaskOps.countLeadingZeros(a);
    }

    /// @notice Counts the number of trailing zeros in a set
    /// @dev Counts the number of trailing zeros in the bitmask
    /// @param a The set to count trailing zeros in
    /// @return count The number of trailing zeros in the set
    function countTrailingZeros(uint256 a) public view returns (uint256 count) {
        count = bitmaskOps.countTrailingZeros(a);
    }
}
