// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MultiCaller {
    function aggregateWithSender(address[] calldata targets, bytes[] calldata data)
        external
        payable
        returns (bytes[] memory success)
    {
        for (uint256 i = 0; i < targets.length; i++) {
            bytes memory d = data[i];
            address to = targets[i];
            assembly {
                success := delegatecall(10000, to, add(d, 0x20), mload(d), 0, 0)
            }
        }
    }
}
