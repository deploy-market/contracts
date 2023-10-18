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
    bytes32 targetHash;
    ExampleToken testToken;

    // Make the test contract payable for withdrawals
    receive() external payable {}

    function setUp() public {
        escrow = new DeployEscrow();

        /**
         * Deploy the contract here to get the address & the target hash.
         * Normally this would be done in advance by the customer
         * in the dApp, only simulating the transaction.
         */
        vm.startPrank(deployer);
        testToken = new ExampleToken(testSecret);
        targetHash = keccak256(
            abi.encodePacked(address(testToken), encoded_testSecret)
        );
        vm.stopPrank();
    }

    function test_Reward() public {
        // Submit a deploy request as the customer
        escrow.submitRequest{value: rewardAmount}(
            targetHash,
            payable(address(this)),
            block.number + 100
        );

        // Check that the escrow exists
        (uint256 amount, , ) = escrow.escrows(targetHash);
        assertEq(amount, rewardAmount);
        assertEq(address(escrow).balance, rewardAmount);

        // Check that the escrow can be rewarded
        vm.startPrank(deployer);
        escrow.reward(address(testToken), payable(deployer));
        assertEq(address(escrow).balance, 0);
        vm.stopPrank();
    }

    function testFail_Reward_Because_Different_Nonce() public {
        vm.startPrank(deployer);
        ExampleToken otherToken = new ExampleToken(testSecret);
        vm.stopPrank();

        // Submit a deploy request
        escrow.submitRequest{value: rewardAmount}(
            targetHash,
            payable(address(this)),
            block.number + 100
        );

        // Check that not all similar contracts apply, even if they had the same secret
        vm.startPrank(deployer);
        escrow.reward(address(otherToken), payable(deployer));
        vm.expectRevert("No escrow exists for this target");
        vm.stopPrank();
    }

    function testFail_Reward_Because_Deadline() public {
        vm.startPrank(deployer);
        testToken = new ExampleToken(testSecret);
        targetHash = keccak256(
            abi.encodePacked(address(testToken), encoded_testSecret)
        );
        vm.stopPrank();

        // Submit a deploy request
        escrow.submitRequest{value: rewardAmount}(
            targetHash,
            payable(address(this)),
            block.number + 100
        );

        // Move the block number forward
        vm.roll(block.number + 200);

        vm.startPrank(deployer);
        escrow.reward(address(testToken), payable(deployer));
        vm.expectRevert("No escrow exists for this target");
        vm.stopPrank();
    }

    function testFail_Reward_Because_Change() public {
        // Submit a deploy request
        escrow.submitRequest{value: rewardAmount}(
            targetHash,
            payable(address(this)),
            block.number + 100
        );

        vm.startPrank(deployer);
        testToken.setDeploySecret("newsecret");

        // Check that the same contract does not apply anymore, if the deploy secret changed
        escrow.reward(address(testToken), payable(deployer));
        vm.expectRevert("No escrow exists for this target");
        vm.stopPrank();
    }

    function test_Withdraw() public {
        // Submit a deploy request
        escrow.submitRequest{value: rewardAmount}(
            targetHash,
            payable(address(this)),
            block.number + 100
        );

        // Move the block number forward
        vm.roll(block.number + 200);

        // Check that the escrow can be withdrawn
        escrow.withdraw(targetHash);
        assertEq(address(escrow).balance, 0);
    }

    function testFail_Withdraw() public {
        // Submit a deploy request
        escrow.submitRequest{value: rewardAmount}(
            targetHash,
            payable(address(this)),
            block.number + 100
        );

        // Move the block number forward
        vm.roll(block.number + 50);

        // Check that the escrow can't be withdrawn before the deadline
        escrow.withdraw(targetHash);
        vm.expectRevert("Failed to withdraw");
    }
}
