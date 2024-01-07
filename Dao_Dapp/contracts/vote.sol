//  SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vote{

    mapping(uint256 => mapping(string => uint256)) public proposal_votes;
    mapping(uint256 => mapping(uint256 => mapping(string => bool))) public voted;

    function voting(uint256 _project_id,uint256 _user_id,string memory _idea) public{
        require(!voted[_user_id][_project_id][_idea], "You have already voted");
        voted[_user_id][_project_id][_idea]=true;
        proposal_votes[_project_id][_idea]++;
    }

}