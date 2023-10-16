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

    bytes32 testSecret = "supercereal";
    bytes32 encoded_testSecret = keccak256(abi.encodePacked(testSecret));
    address deployer = 0x08A2DE6F3528319123b25935C92888B16db8913E;
    uint256 rewardAmount = 1 ether;

    function setUp() public {
        escrow = new DeployEscrow();
    }

    function test_Deploy() public {
        /**
         * Deploy the contract here to get the address & the target hash.
         * Normally this would be done in advance by the customer
         * in the dApp, only simulating the transaction.
         */
        vm.startPrank(deployer);
        ExampleToken myToken = new ExampleToken(testSecret);
        bytes32 targetHash = keccak256(
            abi.encodePacked(address(myToken), encoded_testSecret)
        );
        vm.stopPrank();

        // Submit a deploy request as the customer
        escrow.submitRequest{value: rewardAmount}(
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

    function testFail_Deploy() public {
        vm.startPrank(deployer);
        ExampleToken myToken = new ExampleToken(testSecret);

        bytes32 targetHash = keccak256(
            abi.encodePacked(address(myToken), encoded_testSecret)
        );

        vm.stopPrank();
        ExampleToken otherToken = new ExampleToken(testSecret);

        // Submit a deploy request
        escrow.submitRequest{value: rewardAmount}(
            targetHash,
            address(this),
            block.number + 100
        );

        // Check that not all similar contracts apply, even if they had the same secret
        escrow.reward(address(otherToken), payable(deployer));
        vm.expectRevert("No escrow exists for this target");
    }

    /* function testFail_Because_of_Change() public {
        vm.startPrank(deployer);
        ExampleToken myToken = new ExampleToken(testSecret);
        bytes32 targetHash = keccak256(
            abi.encodePacked(address(myToken), encoded_testSecret)
        );
        vm.stopPrank();

        // Submit a deploy request
        escrow.submitRequest{value: rewardAmount}(
            targetHash,
            address(this),
            block.number + 100
        );

        // Check that not all similar contracts apply, even if they had the same secret
        escrow.reward(address(otherToken), payable(deployer));
        vm.expectRevert("No escrow exists for this target");
    } */
}
