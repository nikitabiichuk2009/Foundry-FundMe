// SPDX-License-Identifier: MIT

pragma solidity 0.8.27;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address payable mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(mostRecentlyDeployed).fund{value: SEND_VALUE}();
        console.log("Funded FundMe with %s", SEND_VALUE);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(payable(mostRecentlyDeployed));
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address payable mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(mostRecentlyDeployed).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(payable(mostRecentlyDeployed));
    }
}
