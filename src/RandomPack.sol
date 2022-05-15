// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract VRFv2Consumer is VRFConsumerBaseV2 {
  VRFCoordinatorV2Interface COORDINATOR;

  // Your subscription ID.
  uint64 s_subscriptionId;

  // Rinkeby coordinator. For other networks,
  // see https://docs.chain.link/docs/vrf-contracts/#configurations
  address vrfCoordinator = 0x6168499c0cFfCaCD319c818142124B7A15E857ab;

  // The gas lane to use, which specifies the maximum gas price to bump to.
  // For a list of available gas lanes on each network,
  // see https://docs.chain.link/docs/vrf-contracts/#configurations
  bytes32 keyHash = 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;

  // Depends on the number of requested values that you want sent to the
  // fulfillRandomWords() function. Storing each word costs about 20,000 gas,
  // so 100,000 is a safe default for this example contract. Test and adjust
  // this limit based on the network that you select, the size of the request,
  // and the processing of the callback request in the fulfillRandomWords()
  // function.
  uint32 callbackGasLimit = 100000;

  // The default is 3, but you can set this higher.
  uint16 requestConfirmations = 3;

  // For this example, retrieve 2 random values in one request.
  // Cannot exceed VRFCoordinatorV2.MAX_NUM_WORDS.
  uint32 numWords =  2;

  uint256[] public s_randomWords;
  uint256 public s_requestId;
  address s_owner;

  constructor(uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator) {
    COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
    s_owner = msg.sender;
    s_subscriptionId = subscriptionId;
  }

  // Assumes the subscription is funded sufficiently.
  function requestRandomWords() external onlyOwner {
    // Will revert if subscription is not set and funded.
    s_requestId = COORDINATOR.requestRandomWords(
      keyHash,
      s_subscriptionId,
      requestConfirmations,
      callbackGasLimit,
      numWords
    );
  }
  
  function fulfillRandomWords(
    uint256, /* requestId */
    uint256[] memory randomWords
  ) internal override {
    s_randomWords = randomWords;
  }

  function getRandomNumberFromConsumer () public view returns(uint256[] memory){
      return s_randomWords;
  }

  modifier onlyOwner() {
    require(msg.sender == s_owner);
    _;
  }
}


abstract contract Combinator is ERC721, ERC721Burnable, Ownable {

    function combinator (address insectContrAddress, address fungiContrAddress, address plantsContrAddress, address elementalContrAddress) public view returns(uint result){
        Insect insect = Insect(insectContrAddress);
        Fungi fungi = Fungi(fungiContrAddress);
        Plants plants = Plants(plantsContrAddress);
        Elemental elemental = Elemental(elementalContrAddress);

        uint256 insectBalance = insect.balanceOf(msg.sender);
        uint256 fungiBalance = fungi.balanceOf(msg.sender);
        uint256 plantsBalance = plants.balanceOf(msg.sender);
        uint256 elementalBalance = elemental.balanceOf(msg.sender);

        if ( insectBalance == 0 && fungiBalance == 0 && plantsBalance == 0 && elementalBalance == 0 ){
            return 0;
        } else if ( insectBalance == 0 && fungiBalance == 0 && plantsBalance == 0 && elementalBalance > 0) {
            return 1;
        } else if ( insectBalance == 0 && fungiBalance == 0 && plantsBalance > 0 && elementalBalance == 0) {
            return 2;
        } else if ( insectBalance == 0 && fungiBalance == 0 && plantsBalance > 0 && elementalBalance > 0) {
            return 3;
        } else if ( insectBalance == 0 && fungiBalance > 0 && plantsBalance == 0 && elementalBalance == 0) {
            return 4;
        } else if ( insectBalance == 0 && fungiBalance > 0 && plantsBalance == 0 && elementalBalance > 0) {
            return 5;
        } else if ( insectBalance == 0 && fungiBalance > 0 && plantsBalance > 0 && elementalBalance == 0) {
            return 6;
        } else if ( insectBalance == 0 && fungiBalance > 0 && plantsBalance > 0 && elementalBalance > 0) {
            return 7;
        } else if ( insectBalance > 0 && fungiBalance == 0 && plantsBalance == 0 && elementalBalance == 0) {
            return 8;
        } else if ( insectBalance > 0 && fungiBalance == 0 && plantsBalance == 0 && elementalBalance > 0) {
            return 9;
        } else if ( insectBalance > 0 && fungiBalance == 0 && plantsBalance > 0 && elementalBalance == 0) {
            return 10;
        } else if ( insectBalance > 0 && fungiBalance == 0 && plantsBalance > 0 && elementalBalance > 0) {
            return 11;
        } else if ( insectBalance > 0 && fungiBalance > 0 && plantsBalance == 0 && elementalBalance == 0) {
            return 12;
        } else if ( insectBalance > 0 && fungiBalance > 0 && plantsBalance == 0 && elementalBalance > 0) {
            return 13;
        } else if ( insectBalance > 0 && fungiBalance > 0 && plantsBalance > 0 && elementalBalance == 0) {
            return 14;
        } else if ( insectBalance > 0 && fungiBalance > 0 && plantsBalance > 0 && elementalBalance > 0) {
            return 15;
        } 
    }

}


contract Insect is Combinator {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Insect", "INS") {}

    function mint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId);
    }
}

contract Fungi is Combinator {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Fungi", "FNG") {}

    function mint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId);
    }
}


contract Elemental is Combinator {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Elemental", "ELM") {}

    function mint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId);
    }
}

contract Plants is Combinator {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("PLANTS", "PLT") {}

    function mint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _mint(to, tokenId);
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

    function getRandomNumber (address consumerAddress) public {
        VRFv2Consumer rng = VRFv2Consumer(consumerAddress);

        rng.requestRandomWords();
    }

    function rngMint (address account, uint256 id, uint256 amount, uint256 randomNumber, address insectContrAddress, address fungiContrAddress, address plantsContrAddress, address elementalContrAddress) internal {
        if (randomNumber == 0) {
            _burn(account,id,amount);
            Insect insect = Insect(insectContrAddress);
            insect.mint(account);
            insect.mint(account);
            insect.mint(account);
            insect.mint(account);
        } else if ( randomNumber == 1) {
            _burn(account,id,amount);
            Fungi fungi = Fungi(fungiContrAddress);
            fungi.mint(account);
            fungi.mint(account);
            fungi.mint(account);
            fungi.mint(account);
        } else if ( randomNumber == 2) {
            _burn(account,id,amount);
            Plants plants = Plants(plantsContrAddress);
            plants.mint(account);
            plants.mint(account);
            plants.mint(account);
            plants.mint(account);
        } else if ( randomNumber == 3) {
            _burn(account,id,amount);
            Elemental elemental = Elemental(elementalContrAddress);
            elemental.mint(account);
            elemental.mint(account);
            elemental.mint(account);
            elemental.mint(account);
        } else if ( randomNumber == 4) {
            _burn(account,id,amount);
            Insect insect = Insect(insectContrAddress);
            Fungi fungi = Fungi(fungiContrAddress);
            Plants plants = Plants(plantsContrAddress);
            Elemental elemental = Elemental(elementalContrAddress);
            insect.mint(account);
            fungi.mint(account);
            plants.mint(account);
            elemental.mint(account);
        }
    }


    function openPack(address account, uint256 id, uint256 amount, address insectContrAddress, address fungiContrAddress, address plantsContrAddress, address elementalContrAddress, address consumerAddress) 
    public
    {
        VRFv2Consumer rng = VRFv2Consumer(consumerAddress);
        uint256[] memory randomWords = rng.getRandomNumberFromConsumer();

        uint256 randomNumber = randomWords[0]%5;
        rngMint(account, id, amount, randomNumber, insectContrAddress, fungiContrAddress, plantsContrAddress, elementalContrAddress);
    }
    
        // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
    
}
