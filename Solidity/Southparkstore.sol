pragma solidity >=0.4.22 <0.6.0;

contract Southparkstore {
    
    
    struct SOUNTPARKCharacter{
        uint id;
        string name;
        uint256 priceTag;
        address owner;
        string imagePath;
        bool haveOwner;
    }
    
    uint C_ID = 0;
    
    uint[] collectionSouthparkCharacterId;
    mapping (uint => SOUNTPARKCharacter) southparkCharacter;
    event PurchaseCharacterErrorLog(address indexed buyer,string reason);
    event SoldCharacter(address indexed buyer,uint id);

    
    function addCharacter(string memory name,uint256 priceTag ,string memory imagePath) public returns(uint id){
        uint Id = C_ID++;
        
        southparkCharacter[Id] = SOUNTPARKCharacter(Id,name, priceTag, address(0x0000000000000000000000000000000000000000), imagePath,false);
        collectionSouthparkCharacterId.push(Id);
        
        return Id;
    }
    
    function sellCharacter(uint id) public payable returns(bool){
        if(msg.value != southparkCharacter[id].priceTag){
            emit PurchaseCharacterErrorLog(msg.sender,"Error, invalid value !!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
        if(southparkCharacter[id].haveOwner){
            emit PurchaseCharacterErrorLog(msg.sender,"Error, this character is have owner!!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
        southparkCharacter[id].owner = msg.sender;
        southparkCharacter[id].haveOwner = true;
        emit SoldCharacter(msg.sender,id);
        
        return true;
    }
    
    function getChracterById(uint Id) public view returns(uint,string memory,uint256,address,string memory,bool){
        return (southparkCharacter[Id].id,southparkCharacter[Id].name,southparkCharacter[Id].priceTag,southparkCharacter[Id].owner,southparkCharacter[Id].imagePath,southparkCharacter[Id].haveOwner);
    }
    
    function getAllCharacter() public view returns(uint[] memory){
        return collectionSouthparkCharacterId;
    }
    
    function getNextValId() public view returns(uint){
        return C_ID;
    }
    
}






