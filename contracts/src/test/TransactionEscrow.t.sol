// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "@std/Test.sol";
import "@std/Vm.sol";
import "@std/StdUtils.sol";
import "../TransactionEscrow.sol";
import "@solady/tokens/ERC20.sol";
import "../ExampleToken.sol";
import "@std/interfaces/IMulticall3.sol";
import "../lib/Multicall3.sol";

contract TransactionTest is Test {
    TransactionEscrow escrow;
    Multicall3 multicall;

    bytes32 testSecret = "supercereal";
    bytes32 encoded_testSecret = keccak256(abi.encodePacked(testSecret));
    address deployer = 0x08A2DE6F3528319123b25935C92888B16db8913E;
    uint256 rewardAmount = 1 ether;
    bytes32 targetHash;
    ExampleToken testToken;

    // Make the test contract payable for withdrawals
    receive() external payable {}

    function setUp() public {
        multicall = new Multicall3();
        escrow = new TransactionEscrow(address(multicall));

        /**
         * Make the transaction here to get the target hash.
         * Normally this would be done in advance by the customer
         * in the dApp, only simulating the transaction.
         */
        vm.startPrank(deployer);

        testToken = new ExampleToken(testSecret);
        IMulticall3.Call3Value[] memory calls = new IMulticall3.Call3Value[](1);
        calls[0] = IMulticall3.Call3Value({
            target: address(testToken),
            callData: abi.encodeWithSelector(0x70a08231, (deployer)),
            value: 0,
            allowFailure: false
        });
        targetHash = keccak256(abi.encode(calls, testSecret));

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
        IMulticall3.Call3Value[] memory calls = new IMulticall3.Call3Value[](1);
        calls[0] = IMulticall3.Call3Value({
            target: address(testToken),
            callData: abi.encodeWithSelector(0x70a08231, (deployer)),
            value: 0,
            allowFailure: false
        });
        escrow.reward(calls, testSecret, payable(deployer));
        assertEq(address(escrow).balance, 0);

        vm.stopPrank();
    }
}
