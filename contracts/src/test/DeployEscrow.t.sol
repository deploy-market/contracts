// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "@std/Test.sol";
import "@std/Vm.sol";
import "../DeployEscrow.sol";
import "../interfaces/DeployEligible.sol";
import "@solady/tokens/ERC20.sol";
import "../ExampleToken.sol";

contract ContractTest is Test {
    DeployEscrow escrow;

    function setUp() public {
        escrow = new DeployEscrow();
    }

    function testDeploy() public {
        bytes32 testSecret = keccak256("supercereal");
        uint256 rewardAmount = 1 ether;

        address deployer = 0x08A2DE6F3528319123b25935C92888B16db8913E;

        vm.startPrank(deployer);
        ExampleToken myToken = new ExampleToken();
        bytes32 targetHash = keccak256(
            abi.encodePacked(address(myToken), testSecret)
        );
        vm.stopPrank();

        // Submit a deploy request
        escrow.submitDeployRequest{value: rewardAmount}(
            targetHash,
            address(this),
            block.number + 100
        );

        // Check that the escrow exists
        (uint256 amount, , ) = escrow.escrows(targetHash);
        assertEq(amount, rewardAmount);
        assertEq(address(escrow).balance, rewardAmount);

        // Check that the escrow can be withdrawn
        vm.startPrank(deployer);
        escrow.reward(address(myToken), payable(deployer));
        assertEq(address(escrow).balance, 0);
        vm.stopPrank();
    }
}
