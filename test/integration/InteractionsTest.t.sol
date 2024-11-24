// SPDX-License-Identifier: MIT

pragma solidity 0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundMe;
    uint256 constant STARTING_USER_BALANCE = 10 ether;
    uint256 constant SEND_VALUE = 0.1 ether;
    address USER = makeAddr("user");

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_USER_BALANCE);
    }

    function testUsercanFundIntegration() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(payable(address(fundMe)));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(payable(address(fundMe)));

        assert(address(fundMe).balance == 0);
    }
}
