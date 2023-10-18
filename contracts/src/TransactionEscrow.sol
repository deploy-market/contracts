// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "./interfaces/DeployEligible.sol";
import "./interfaces/IMulticall3.sol";

contract TransactionEscrow {
    IMulticall3 multicall =
        IMulticall3(0xcA11bde05977b3631167028862bE2a173976CA11);

    struct Escrow {
        uint256 amount;
        address submitter;
        uint256 deadline;
    }

    // Mapping from target hash (transaction hash + secret) to escrow
    mapping(bytes32 => Escrow) public escrows;

    /**
     * A deploy request is simply a customer submitted challenge submitted to
     * this escrow that can be withdrawn with successful deployment of a contract
     */
    function submitRequest(
        bytes32 targetHash,
        address submitter,
        uint256 deadline
    ) public payable {
        escrows[targetHash] = Escrow({
            amount: msg.value,
            submitter: submitter,
            deadline: deadline
        });
    }

    /**
     * @dev Withdraws the escrowed funds if the target contract has been deployed
     * successfully.
     */
    function reward(
        IMulticall3.Call3[] memory calls,
        bytes32 secret,
        address payable deployerAddress
    ) public payable {
        IMulticall3.Result memory result = multicall.aggregate3(calls)[0];
        require(result.success, "Transaction failed");

        bytes32 targetHash = keccak256(abi.encode(calls, secret));

        // Check that the escrow exists and has not expired
        Escrow memory escrow = escrows[targetHash];
        require(escrow.amount > 0, "No escrow exists for this target");
        require(escrow.deadline > block.number, "Job deadline has passed");

        // Transfer marked funds to the deployer
        delete escrows[targetHash];
        (bool success, ) = deployerAddress.call{value: escrow.amount}("");
        require(success, "Failed to send a reward");
    }

    /**
     * @dev Withdraws the escrowed funds if the deadline has passed without a successful deployment
     */
    function withdraw(bytes32 targetHash) public payable {
        Escrow memory escrow = escrows[targetHash];
        require(escrow.amount > 0, "No escrow exists for this target");
        require(
            escrow.deadline < block.number,
            "Job still open, wait for the deadline"
        );

        delete escrows[targetHash];
        (bool success, ) = escrow.submitter.call{value: escrow.amount}("");
        require(success, "Failed to withdraw");
    }
}
