// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/MultiCaller.sol";
import "./PPG.sol";

contract MulticallerTest is Test {
    MultiCaller public caller;
    PPG public ppg;

    function setUp() public {
        caller = new MultiCaller();
        ppg = new PPG("PPG", "PPG");
    }

    function testAggregateWithSender() public {
        address user = 0x62d69f6867A0A084C6d313943dC22023Bc263691;
        vm.startPrank(user);
        address[] memory targets = new address[](2);
        targets[0] = address(ppg);
        targets[1] = address(ppg);
        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSelector(ppg.safeMint.selector, 1);
        data[1] = abi.encodeWithSelector(ppg.safeMint.selector, 2);
        caller.aggregateWithSender(targets, data);
        vm.stopPrank();
    }
}
