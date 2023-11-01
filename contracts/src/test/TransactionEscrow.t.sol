// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "@std/Test.sol";
import "@std/Vm.sol";
import "@std/StdUtils.sol";
import "../TransactionEscrow.sol";
import "@solady/tokens/ERC20.sol";
import "../ExampleToken.sol";
import "@std/interfaces/IMulticall3.sol";

contract TransactionTest is Test {
    TransactionEscrow escrow;
    IMulticall3 multicall =
        IMulticall3(0xcA11bde05977b3631167028862bE2a173976CA11);

    bytes32 testSecret = "supercereal";
    bytes32 encoded_testSecret = keccak256(abi.encodePacked(testSecret));
    address deployer = 0x08A2DE6F3528319123b25935C92888B16db8913E;
    uint256 rewardAmount = 1 ether;
    bytes32 targetHash;
    ExampleToken testToken;

    // Make the test contract payable for withdrawals
    receive() external payable {}

    function setUp() public {
        escrow = new TransactionEscrow();

        /**
         * Make the transaction here to get the target hash.
         * Normally this would be done in advance by the customer
         * in the dApp, only simulating the transaction.
         */
        vm.startPrank(deployer);
        testToken = new ExampleToken(testSecret);

        IMulticall3.Call3[] storage callData;
        callData += IMulticall3.Call3({
            target: address(testToken),
            callData: abi.encodeWithSelector(0x70a08231, (deployer)),
            allowFailure: false
        });

        targetHash = keccak256(abi.encode(callData, testSecret));
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
        IMulticall3.Call3[] storage callData;
        callData += IMulticall3.Call3({
            target: address(testToken),
            callData: abi.encodeWithSelector(0x70a08231, (deployer)),
            allowFailure: false
        });
        escrow.reward(callData, testSecret, payable(deployer));
        assertEq(address(escrow).balance, 0);
        vm.stopPrank();
    }
}
