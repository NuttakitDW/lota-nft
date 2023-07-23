// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/utils/Counters.sol";
import {LotaAcc} from "./struct.sol";
import {ILotaItem} from "./ILotaItem.sol";

contract Lota is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    mapping(uint256 => LotaAcc) public lotaAcc;

    Counters.Counter private _tokenIdCounter;
    ILotaItem public lotaItem;

    constructor(address _lotaItem) ERC721("Lota", "LTA") {
        lotaItem = ILotaItem(_lotaItem);
    }

    function safeMint(
        address to,
        string memory uri,
        uint256 clothes,
        uint256 face,
        uint256 head
    ) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        lotaAcc[tokenId] = LotaAcc(clothes, face, head);
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function setClothes(uint256 tokenId, uint256 accId) public {
        lotaAcc[tokenId].clothes = accId;
    }
}
