# Bitwise Set Operations

This project provides a Solidity implementation of mathematical set operations using bitmask representation. The operations are implemented using efficient bitwise operations through the `BitmaskOperations` contract.

## Contracts

### BitmaskOperations

The `BitmaskOperations` contract provides low-level bitwise operations for set manipulation. All operations are implemented using Yul assembly for gas optimization.

#### Functions

- `bitwiseAnd(uint256 a, uint256 b)`: Performs a bitwise AND operation on two bitmasks.
- `bitwiseOr(uint256 a, uint256 b)`: Performs a bitwise OR operation on two bitmasks.
- `bitwiseXor(uint256 a, uint256 b)`: Performs a bitwise XOR operation on two bitmasks.
- `bitwiseNot(uint256 a)`: Performs a bitwise NOT operation on a bitmask.
- `bitwiseShiftLeft(uint256 a, uint256 positions)`: Performs a bitwise shift left operation on a bitmask.
- `bitwiseShiftRight(uint256 a, uint256 positions)`: Performs a bitwise shift right operation on a bitmask.
- `bitwiseRotateLeft(uint256 a, uint256 positions)`: Performs a bitwise rotate left operation on a bitmask.
- `bitwiseRotateRight(uint256 a, uint256 positions)`: Performs a bitwise rotate right operation on a bitmask.
- `bitwiseClear(uint256 a, uint256 mask)`: Performs a bitwise clear operation on specific bits of a bitmask.
- `bitwiseSet(uint256 a, uint256 mask)`: Performs a bitwise set operation on specific bits of a bitmask.
- `bitwiseToggle(uint256 a, uint256 mask)`: Performs a bitwise toggle operation on specific bits of a bitmask.
- `bitwiseExtract(uint256 a, uint256 start, uint256 length)`: Extracts a specific range of bits from a bitmask.
- `countLeadingZeros(uint256 a)`: Counts the number of leading zeros in a bitmask.
- `countTrailingZeros(uint256 a)`: Counts the number of trailing zeros in a bitmask.

### SetOperations

The `SetOperations` contract provides a complete implementation of mathematical set operations using bitmask representation. It uses the `BitmaskOperations` contract for efficient bitwise operations.

#### Functions

- `union(uint256 a, uint256 b)`: Computes the union of two sets.
- `intersection(uint256 a, uint256 b)`: Computes the intersection of two sets.
- `difference(uint256 a, uint256 b)`: Computes the difference of two sets.
- `symmetricDifference(uint256 a, uint256 b)`: Computes the symmetric difference of two sets.
- `isSubset(uint256 a, uint256 b)`: Checks if one set is a subset of another.
- `isSuperset(uint256 a, uint256 b)`: Checks if one set is a superset of another.
- `complement(uint256 a)`: Computes the complement of a set.
- `cardinality(uint256 a)`: Computes the cardinality (size) of a set.
- `isEmpty(uint256 a)`: Checks if a set is empty.
- `min(uint256 a)`: Gets the minimum element in the set.
- `max(uint256 a)`: Gets the maximum element in the set.
- `shiftLeftUnion(uint256 a, uint256 b, uint256 positions)`: Computes the shift left union of a set with another set.
- `shiftRightIntersection(uint256 a, uint256 b, uint256 positions)`: Computes the shift right intersection of a set with another set.
- `rotateLeftDifference(uint256 a, uint256 b, uint256 positions)`: Computes the rotate left difference of a set with another set.
- `rotateRightSymmetricDifference(uint256 a, uint256 b, uint256 positions)`: Computes the rotate right symmetric difference of a set with another set.
- `clearElements(uint256 a, uint256 mask)`: Clears specific elements in a set.
- `setElements(uint256 a, uint256 mask)`: Sets specific elements in a set.
- `toggleElements(uint256 a, uint256 mask)`: Toggles specific elements in a set.
- `extractSubset(uint256 a, uint256 start, uint256 length)`: Extracts a specific subset from a set.
- `countLeadingZeros(uint256 a)`: Counts the number of leading zeros in a set.
- `countTrailingZeros(uint256 a)`: Counts the number of trailing zeros in a set.

## Tests

The project includes unit tests and invariant tests for the `SetOperations` contract using Forge's Test library.

### BitmaskSetOperationsTest

Unit tests for the `SetOperations` contract using bitmasks. Tests the functionality of various set operations.

### SetOpsInvariants

Invariant tests for the `SetOperations` contract using bitmasks. Tests the invariants of various set operations.

## Scripts

The project includes scripts to demonstrate the usage of the `SetOperations` contract.

### SetOperationsDemo

A script that demonstrates the usage of the `SetOperations` contract by performing various set operations and logging the results.

## License

This project is licensed under the MIT License.