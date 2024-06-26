// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

interface DeployEligible {
    function getDeploySecret() external view returns (bytes32 secret);
}
