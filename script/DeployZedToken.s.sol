// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ZedToken} from "../src/ZedToken.sol";

contract DeployZedToken is Script {
    function run() external {
        uint256 initialSupply = 1000000;
        
        vm.startBroadcast();
        new ZedToken(initialSupply);
        vm.stopBroadcast();
    }
}
