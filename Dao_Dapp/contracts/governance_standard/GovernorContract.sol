// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";
import "../Treasury.sol";  

abstract contract GovernorContract is Treasury, Governor, GovernorSettings, GovernorCountingSimple, GovernorVotes, GovernorVotesQuorumFraction{
    constructor(IVotes _token,uint48 _votingDelay,uint32 _votingPeriod,uint256 _quorumPercentage)
        Governor("GovernorContract")
        GovernorSettings(_votingDelay /* 1 day */, _votingPeriod /* 1 week */, 0)
        GovernorVotes(_token)
        GovernorVotesQuorumFraction(_quorumPercentage) 
        Treasury()
    {}
    
    
    function createProject(uint256 projectId,address payee,uint256 funds) external onlyOwner override(Treasury){

        super.createProject(projectId,payee,funds); 
    }

    function give_funds(uint256 projectId,address to_pay,uint256 amount) external payable override(Treasury){
        super.give_funds(projectId,to_pay,amount);
    }

    function contribute_to_project(uint256 projectId,uint256 amount,address payee)external payable override(Treasury){
        super.contribute_to_project(projectId,amount,payee);
    }


    // The following functions are overrides required by Solidity.

    function votingDelay()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.votingDelay();
    }

    function votingPeriod()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.votingPeriod();
    }

    function quorum(uint256 blockNumber)
        public
        view
        override(Governor, GovernorVotesQuorumFraction)
        returns (uint256)
    {
        return super.quorum(blockNumber);
    }

    function state(uint256 proposalId)
        public
        view
        override(Governor)
        returns (ProposalState)
    {
        return super.state(proposalId);
    }

    function proposalNeedsQueuing(uint256 proposalId)
        public
        view
        override(Governor)
        returns (bool)
    {
        return super.proposalNeedsQueuing(proposalId);
    }

    function proposalThreshold()
        public
        view
        override(Governor, GovernorSettings)
        returns (uint256)
    {
        return super.proposalThreshold();
    }

    function _queueOperations(uint256 proposalId, address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
        internal
        override(Governor)
        returns (uint48)
    {
        return super._queueOperations(proposalId, targets, values, calldatas, descriptionHash);
    }

    function _executeOperations(uint256 proposalId, address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
        internal
        override(Governor)
    {
        super._executeOperations(proposalId, targets, values, calldatas, descriptionHash);
    }

    function _cancel(address[] memory targets, uint256[] memory values, bytes[] memory calldatas, bytes32 descriptionHash)
        internal
        override(Governor)
        returns (uint256)
    {
        return super._cancel(targets, values, calldatas, descriptionHash);
    }

    function _executor()
        internal
        view
        override(Governor)
        returns (address)
    {
        return super._executor();
    }
}
