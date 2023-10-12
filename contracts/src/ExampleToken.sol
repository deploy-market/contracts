// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "@solady/tokens/ERC20.sol";
import "@solady/auth/Ownable.sol";
import "./interfaces/DeployEligible.sol";

contract ExampleToken is DeployEligible, Ownable {
    string public name = "ExampleToken";
    string public symbol = "ETK";
    bytes32 public deploySecret;
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000000000000000000000000;
    mapping(address => uint256) public balances;

    constructor(bytes memory _deploySecret) {
        _initializeOwner(msg.sender);
        deploySecret = keccak256(abi.encodePacked(_deploySecret));
        balances[msg.sender] = totalSupply;
    }

    function getDeploySecret() external pure override returns (bytes32 secret) {
        return deploySecret;
    }

    function setDeploySecret(bytes32 memory newSecret) external returns (void) {
        deploySecret = keccak256(abi.encodePacked(newSecret));
    }
}
