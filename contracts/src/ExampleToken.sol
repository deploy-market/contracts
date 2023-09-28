// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "@solady/tokens/ERC20.sol";
import "./interfaces/DeployEligible.sol";

contract ExampleToken is DeployEligible {
    string public name = "ExampleToken";
    string public symbol = "ETK";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000000000000000000000000;
    mapping(address => uint256) public balances;

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function getDeploySecret() external pure override returns (bytes32 secret) {
        return keccak256(abi.encodePacked("supercereal"));
    }
}
