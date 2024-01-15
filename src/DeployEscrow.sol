// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "./interfaces/DeployEligible.sol";

contract DeployEscrow {
    address public owner;

    struct Escrow {
        uint256 amount;
        address payable submitter;
        uint256 deadline;
        uint8 feePermille;
    }

    // Mapping from target hash (contract address + secret) to escrow
    mapping(bytes32 => Escrow) public escrows;

    constructor(address ownerAddress) {
        owner = ownerAddress;
    }

    /**
     * A deploy request is simply a customer submitted challenge submitted to
     * this escrow that can be withdrawn with successful deployment of a contract
     */
    function submitRequest(
        bytes32 targetHash,
        address payable submitter,
        uint256 deadline,
        uint8 feePermille
    ) public payable {
        escrows[targetHash] = Escrow({
            amount: msg.value,
            submitter: submitter,
            deadline: deadline,
            feePermille: feePermille
        });
    }

    /**
     * @dev Calculates the fee
     */
    function calculateFee(
        uint256 amount,
        uint8 feePermille
    ) public pure returns (uint256) {
        return (amount / 1000) * feePermille;
    }

    /**
     * @dev Withdraws the escrowed funds if the target contract has been deployed
     * successfully.
     */
    function reward(
        address targetAddress,
        address payable deployerAddress
    ) public {
        // Check that the target contract has been deployed successfully
        DeployEligible target = DeployEligible(address(targetAddress));
        bytes32 secret = target.getDeploySecret();

        // (Re)construct the submitted target hash from deployed contract info
        bytes32 targetHash = keccak256(abi.encodePacked(targetAddress, secret));

        // Check that the escrow exists and has not expired
        Escrow memory escrow = escrows[targetHash];
        require(escrow.amount > 0, "No escrow exists for this target");
        require(escrow.deadline >= block.number, "Job deadline has passed");

        // Transfer marked funds to the deployer
        delete escrows[targetHash];

        // Calculate and pay the fee if existent
        if (escrow.feePermille > 0) {
            uint256 feeAmount = calculateFee(escrow.amount, escrow.feePermille);
            require(feeAmount > 0, "Failed to calculate the fee for this job");
            (bool feeSuccess, ) = owner.call{value: feeAmount}("");
            require(feeSuccess, "Failed to send the fee for this job");
        }

        // Pay the reward to the deployer
        (bool success, ) = deployerAddress.call{value: escrow.amount}("");
        require(success, "Failed to send a reward for this job");
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

    function setOwner(address newOwner) public {
        require(msg.sender == owner, "Only the owner can set the owner");
        owner = newOwner;
    }
}
