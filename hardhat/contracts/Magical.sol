// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@klaytn/contracts/KIP/token/KIP17/extensions/KIP17URIStorage.sol";
import "@klaytn/contracts/utils/Counters.sol";


contract MagicalNfts is KIP17URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private tokenCounter;

    mapping(uint256 => uint256) private tokenPrices;
    mapping(address => uint256[]) private userNFTs;

    constructor(
    ) KIP17("magicalNfts", "MN") {
    }

    function mintNFT(
        uint256 price,
        string memory tokenUri
    ) public returns (uint256) {
        tokenCounter.increment();

        uint256 newItemId = tokenCounter.current();

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenUri);
        tokenPrices[newItemId] = price;
        userNFTs[msg.sender].push(newItemId);

        return newItemId;
    }

    function buyToken(uint256 tokenId) public payable {
        require(_exists(tokenId), "NFTMarketplace: token does not exist");
        require(
            msg.value == tokenPrices[tokenId],
            "NFTMarketplace: incorrect value"
        );

        address payable seller = payable(ownerOf(tokenId));
        _transfer(seller, msg.sender, tokenId);
        seller.transfer(msg.value);
    }

    function getAllTokens() public view returns (uint256[] memory) {
        uint256[] memory allTokens = new uint256[](tokenCounter.current());
        for (uint256 i = 1; i <= tokenCounter.current(); i++) {
            if (_exists(i)) {
                allTokens[i - 1] = i;
            }
        }
        return allTokens;
    }

    function getUserTokens(
        address user
    ) public view returns (uint256[] memory) {
        return userNFTs[user];
    }

    function getTotalSupply() public view returns (uint256) {
        return tokenCounter.current();
    }

}