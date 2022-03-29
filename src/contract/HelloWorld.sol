// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract Hero is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Hero", "HRO") {}

    function safeMint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

}

contract Land is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("LAND", "LND") {}

    function safeMint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}

contract Plants is ERC721, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("PLANTS", "PLT") {}

    function safeMint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}

contract Pack is ERC1155, Ownable, ERC1155Burnable, ERC1155Supply {
    uint256 PRICE = 10000000000000000;
    constructor() ERC1155("Pack") {}

    function setURI(string memory newuri) public {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        payable
    {
        require(msg.value == PRICE, "The amount of ether you want to send is incorrect!");
        require(amount == 1, "Only one NFT is allowed to be minted at a time!");
        require( totalSupply(id) < 555, "Supply exceeded!");
        _mint(account, id, amount, data);
    }

    function openPack(address account, uint256 id, uint256 amount, address heroContrAddress, address landContrAddress, address plantsContrAddress) 
    public
    {

        Hero hero = Hero(heroContrAddress);
        Land land = Land(landContrAddress);
        Plants plants = Plants(plantsContrAddress);
        _burn(account,id,amount);
        
        hero.safeMint(account);
        land.safeMint(account);
        plants.safeMint(account);

    }
    
        // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
    
}
