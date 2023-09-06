// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.4.20;

contract NFT{
    //an address for whom to query the balance
    mapping (address => uint) balanceOf;

    //the address of the owners of the NFT
   mapping (uint => Token) owners;
    struct Token {
        uint id;
        address owner;
        bytes32 metadata;     

    //tracking the approvals - are addresses that can make transfers on your behalf. Attached to balances and token IDs
    mapping (address => mapping(address => bool)) approvals;
    mapping (address => mapping(uint => address)) operators;

    }

   

 event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

 event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

 event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

 function balanceOf(address _owner) external view returns (uint256)
 { 
    //track to invalidate the zero address
    require (
    address(0) == _owner, "zero address is invalid");
    return balanceOf[_owner];
     }

 function ownerOf(uint256 _tokenId) external view returns (address)
 { 
    //track the address of the owner of the NFT
    address memory addr = owners[_tokenId].owner;
 require (
    address(0) == addr, "zero address is invalid");
    return addr;
 }

 function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable
{ //throws if _to is the zero address
    require (
    address(0) == _to, "zero address is invalid");

    //transfers the ownership of the NFT from one address to another    
    require (msg.sender == ownerOf(_tokenId), "You're not the owner");

    //track the approvals
    require (approvals[_from][msg.sender], "not authorized");

    //track the operators
    require(msg.sender == operators[_from][_tokenId], "not authorized");


}

}


