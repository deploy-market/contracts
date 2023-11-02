// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "./interfaces/DeployEligible.sol";
import "@std/interfaces/IMulticall3.sol";

contract TransactionEscrow {
    IMulticall3 multicall;

    struct Escrow {
        uint256 amount;
        address payable submitter;
        uint256 deadline;
    }

    // Mapping from target hash (transaction hash + secret) to escrow
    mapping(bytes32 => Escrow) public escrows;

    constructor(address multicallAddress) {
        multicall = IMulticall3(multicallAddress);
    }

    /**
     * A transaction request is simply a customer submitted challenge submitted to
     * this escrow that can be withdrawn with successful transaction call
     */
    function submitRequest(
        bytes32 targetHash,
        address payable submitter,
        uint256 deadline
    ) public payable {
        escrows[targetHash] = Escrow({
            amount: msg.value,
            submitter: submitter,
            deadline: deadline
        });
    }

    /**
     * @dev Withdraws the escrowed funds if the transaction calls succeed
     */
    function reward(
        IMulticall3.Call3Value[] calldata calls,
        bytes32 secret,
        address payable deployerAddress
    ) public payable {
        IMulticall3.Result memory result = multicall.aggregate3Value(calls)[0];
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
     * @dev Withdraws the escrowed funds if the deadline has passed without a successful transaction
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
