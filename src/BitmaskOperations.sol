// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/// @title BitmaskOperations - Low-level bitwise operations for set manipulation
/// @author Guap Codes
/// @notice This contract provides fundamental bitwise operations used for implementing set operations
/// @dev All operations are implemented using Yul assembly for gas optimization
contract BitmaskOperations {
    // Events to log the results of each operation
    event BitwiseAnd(uint256 indexed a, uint256 indexed b, uint256 result);
    event BitwiseOr(uint256 indexed a, uint256 indexed b, uint256 result);
    event BitwiseXor(uint256 indexed a, uint256 indexed b, uint256 result);
    event BitwiseNot(uint256 indexed a, uint256 result);

    /// @notice Performs a bitwise AND operation on two bitmasks
    /// @dev Implemented in assembly for gas optimization
    /// @param a First bitmask operand
    /// @param b Second bitmask operand
    /// @return result The result of a & b
    function bitwiseAnd(uint256 a, uint256 b) public returns (uint256 result) {
        assembly {
            result := and(a, b)
        }
        emit BitwiseAnd(a, b, result);
    }

    /// @notice Performs a bitwise OR operation on two bitmasks
    /// @dev Implemented in assembly for gas optimization
    /// @param a First bitmask operand
    /// @param b Second bitmask operand
    /// @return result The result of a | b
    function bitwiseOr(uint256 a, uint256 b) public returns (uint256 result) {
        assembly {
            result := or(a, b)
        }
        emit BitwiseOr(a, b, result);
    }

    /// @notice Performs a bitwise XOR operation on two bitmasks
    /// @dev Implemented in assembly for gas optimization
    /// @param a First bitmask operand
    /// @param b Second bitmask operand
    /// @return result The result of a ^ b
    function bitwiseXor(uint256 a, uint256 b) public returns (uint256 result) {
        assembly {
            result := xor(a, b)
        }
        emit BitwiseXor(a, b, result);
    }

    /// @notice Performs a bitwise NOT operation on a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask operand to be negated
    /// @return result The result of ~a
    function bitwiseNot(uint256 a) public returns (uint256 result) {
        assembly {
            result := not(a)
        }
        emit BitwiseNot(a, result);
    }

    /// @notice Performs a bitwise shift left operation on a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask operand to be shifted
    /// @param positions Number of positions to shift left
    /// @return result The result of a << positions
    function bitwiseShiftLeft(
        uint256 a,
        uint256 positions
    ) public pure returns (uint256 result) {
        assembly {
            result := shl(positions, a)
        }
    }

    /// @notice Performs a bitwise shift right operation on a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask operand to be shifted
    /// @param positions Number of positions to shift right
    /// @return result The result of a >> positions
    function bitwiseShiftRight(
        uint256 a,
        uint256 positions
    ) public pure returns (uint256 result) {
        assembly {
            // Work with 4-bit window
            let window := 0xf
            // Mask input to 4 bits
            a := and(a, window)
            // Perform shift
            result := shr(positions, a)
            // Mask result to 4 bits
            result := and(result, window)
        }
    }

    /// @notice Performs a bitwise rotate left operation on a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask operand to be rotated
    /// @param positions Number of positions to rotate left
    /// @return result The result of rotating a left by positions
    function bitwiseRotateLeft(
        uint256 a,
        uint256 positions
    ) public pure returns (uint256 result) {
        assembly {
            // Work with 8-bit window
            let window := 0xff
            a := and(a, window)
            positions := mod(positions, 8)

            // Perform rotation
            let left := shl(positions, a)
            let right := shr(sub(8, positions), a)
            result := and(or(left, right), window)
        }
    }

    /// @notice Performs a bitwise rotate right operation on a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask operand to be rotated
    /// @param positions Number of positions to rotate right
    /// @return result The result of rotating a right by positions
    function bitwiseRotateRight(
        uint256 a,
        uint256 positions
    ) public pure returns (uint256 result) {
        assembly {
            // Work with 4-bit window
            let window := 0xf
            // Mask input to 4 bits and normalize positions
            a := and(a, window)
            positions := mod(positions, 4)

            // Calculate rotation
            switch positions
            case 1 {
                // Rotate right by 1: rightmost bit goes to leftmost position
                let rightmost := and(a, 1) // Get rightmost bit
                let rest := shr(1, a) // Shift rest right
                result := or(shl(3, rightmost), rest) // Combine
            }
            default {
                // For other rotations, use general approach
                let mask := sub(exp(2, positions), 1)
                let wrapped := and(a, mask)
                let top := shl(sub(4, positions), wrapped)
                let bottom := shr(positions, a)
                result := or(top, bottom)
            }
            // Ensure result is within 4-bit window
            result := and(result, window)
        }
    }

    /// @notice Performs a bitwise clear operation on specific bits of a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask to clear bits from
    /// @param mask Mask specifying bits to clear
    /// @return result The result of clearing bits in a
    function bitwiseClear(
        uint256 a,
        uint256 mask
    ) public pure returns (uint256 result) {
        assembly {
            result := and(a, not(mask))
        }
    }

    /// @notice Performs a bitwise set operation on specific bits of a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask to set bits in
    /// @param mask Mask specifying bits to set
    /// @return result The result of setting bits in a
    function bitwiseSet(
        uint256 a,
        uint256 mask
    ) public pure returns (uint256 result) {
        assembly {
            result := or(a, mask)
        }
    }

    /// @notice Performs a bitwise toggle operation on specific bits of a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask to toggle bits in
    /// @param mask Mask specifying bits to toggle
    /// @return result The result of toggling bits in a
    function bitwiseToggle(
        uint256 a,
        uint256 mask
    ) public pure returns (uint256 result) {
        assembly {
            result := xor(a, mask)
        }
    }

    /// @notice Extracts a specific range of bits from a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Source bitmask
    /// @param start Starting position of the range (0-based)
    /// @param length Length of the range in bits
    /// @return result The extracted bit range
    function bitwiseExtract(
        uint256 a,
        uint256 start,
        uint256 length
    ) public pure returns (uint256 result) {
        assembly {
            let mask := sub(shl(length, 1), 1)
            result := and(shr(start, a), mask)
        }
    }

    /// @notice Counts the number of leading zeros in a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask to count leading zeros in
    /// @return count Number of leading zeros
    function countLeadingZeros(uint256 a) public pure returns (uint256 count) {
        assembly {
            count := 256
            let mask := shl(255, 1) // Start with leftmost bit

            for {
                let i := 0
            } lt(i, 256) {
                i := add(i, 1)
            } {
                if and(a, mask) {
                    count := i
                    break
                }
                mask := shr(1, mask)
            }
        }
    }

    /// @notice Counts the number of trailing zeros in a bitmask
    /// @dev Implemented in assembly for gas optimization
    /// @param a Bitmask to count trailing zeros in
    /// @return count Number of trailing zeros
    function countTrailingZeros(uint256 a) public pure returns (uint256 count) {
        assembly {
            count := 0
            for {
                let i := 0
            } lt(i, 256) {
                i := add(i, 1)
            } {
                if iszero(and(shr(i, a), 1)) {
                    count := add(count, 1)
                }
                if eq(and(shr(i, a), 1), 1) {
                    break
                }
            }
        }
    }
}
