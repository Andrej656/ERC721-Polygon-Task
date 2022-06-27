//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract SensorsNFTContract is ERC721, Ownable {

         
         
          
          event WhitelistedAddressAdded(address addr);
          event WhitelistedAddressRemoved(address addr);
          uint256 public mintPrice = 0.05 ether;
          uint256 public totalSupply;
          uint256 public maxSupply;
          uint256 public allowances;
          bool public isMintEnabled;
          mapping (address => uint256) public mintedWallets;
          mapping (address => mapping (address => uint256)) private _allowances;
          mapping(address => bool) public whitelist;

          constructor () payable ERC721 ("SensorsNFT", "SEN"){
                      maxSupply =  2222 ; 
                      
                                
             }
             function addAddressToWhitelist(address addr) onlyOwner public returns(bool success) {
             if (!whitelist[addr]) 
             whitelist[addr] = true;
             emit WhitelistedAddressAdded(addr);
             success = true; 
             }
   
    
            function toggleIsMintenabled () external onlyOwner {
                      isMintEnabled = !isMintEnabled;
            }
            function allowance(address owner, address spender) public view returns (uint256) {
            return _allowances[owner][spender];
            }
            function setMaxSupply (uint256 maxSupply_) external onlyOwner {
                      maxSupply = maxSupply_;
             }
            function mint () external payable {
                      require (isMintEnabled, "minting not enabled");
                      require(mintedWallets[msg.sender] < 2, "exceeds max per wallet");
                      require(msg.value == mintPrice, "wrong value");
                      require(maxSupply > totalSupply, "sold out");

                      mintedWallets[msg.sender]++;
                      totalSupply++;
                      uint256 tokenId = totalSupply;
                      _safeMint(msg.sender, tokenId);
            
             }
        }       
          




