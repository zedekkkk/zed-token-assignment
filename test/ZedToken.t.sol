// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {ZedToken} from "../src/ZedToken.sol";

contract ZedTokenTest is Test {
    ZedToken public token;
    address owner = address(this);
    address addr1 = address(0x1);
    address addr2 = address(0x2);
    uint256 initialSupply = 1000000;

    function setUp() public {
        token = new ZedToken(initialSupply);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), initialSupply * 10 ** token.decimals());
        assertEq(token.balanceOf(owner), initialSupply * 10 ** token.decimals());
    }

    function testTransfer() public {
        uint256 transferAmount = 1000 * 10 ** token.decimals();
        token.transfer(addr1, transferAmount);
        assertEq(token.balanceOf(addr1), transferAmount);
        assertEq(token.balanceOf(owner), (initialSupply * 10 ** token.decimals()) - transferAmount);
    }

    function testOwnerCanMint() public {
        uint256 mintAmount = 500 * 10 ** token.decimals();
        token.mint(addr1, mintAmount);
        assertEq(token.balanceOf(addr1), mintAmount);
    }

    function testNonOwnerCannotMint() public {
        vm.prank(addr1);
        vm.expectRevert();
        token.mint(addr2, 100);
    }

    function testPauseBlocksTransfer() public {
        token.pause();
        vm.expectRevert();
        token.transfer(addr1, 100);
    }

    function testUnpauseAllowsTransfer() public {
        token.pause();
        token.unpause();
        token.transfer(addr1, 100);
        assertEq(token.balanceOf(addr1), 100);
    }

    function testBurnReducesSupply() public {
        uint256 burnAmount = 500 * 10 ** token.decimals();
        uint256 supplyBefore = token.totalSupply();
        token.burn(burnAmount);
        assertEq(token.totalSupply(), supplyBefore - burnAmount);
    }
}
