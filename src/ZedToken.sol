// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Pausable} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ZedToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    
    constructor(uint256 initialSupply) ERC20("ZedToken", "ZED") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}
