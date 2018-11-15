pragma solidity ^0.4.25;
pragma  experimental ABIEncoderV2;

import "./LBDigitalCertificate.sol";
import "./Owner.sol";


contract LBWhiteList is Owner  {
      // NHA quan ly
    struct WhiteList{
        uint whiteListId; 
        string whiteListName;
        string whiteListAddress;
    }
    address[] public whitelistAddress;
    WhiteList[] internal  whitelists;

    mapping(address => mapping(uint => bool))  wattingForApprove;
    mapping(address => mapping(uint => bool))  _isValidApprove;
    mapping(address => uint[])  idForWattingByOneWhiteList;  // list ids for watting
    mapping(uint => bool) public  isWaitting;
    mapping(address => bool)  isWhiteList;

    modifier _isWhiteList(address _addr) {
        require(isWhiteList[_addr]);
        _;
    }
    
    modifier _isWaitting(uint _id) {
        require(isWaitting[_id]);
        _;
    }
    
    
    function getAddresslength() public view returns(uint) {
        return whitelistAddress.length;
    }
    
    function getAddress(uint _id) public view returns(address) {
        return whitelistAddress[_id];
    }
    
    function setAddressWhiteList(address[] _add) 
        public
        onlyOwner returns(bool) 
    { // onlyowner
        require(_add.length > 0 && _add.length <= 10); 
        for(uint8 i = 0; i < _add.length; i++) {
            whitelistAddress.push(_add[i]);
            isWhiteList[_add[i]] = true;
        }

        return true;
    }
    
    function getWaittingForApprove(uint _id) 
        public view
        _isWhiteList(msg.sender)   
        returns(bool) 
    {
        return wattingForApprove[msg.sender][_id];
    }
    
    function setWaittingForApprove(address _add, uint _id) 
        public 
        returns(bool)
    {
        require(_add != 0x0);
        isWaitting[_id] = true;
        wattingForApprove[_add][_id] = true;
        idForWattingByOneWhiteList[_add].push(_id);
        return true;
    }
    
    function updateWhiteList(
        string _whiteListName,
        string _whiteListAddress,
        uint _index
    )
        public
        onlyOwner    
        returns(bool) 
    {
        whitelists[_index].whiteListName = _whiteListName;
        whitelists[_index].whiteListAddress = _whiteListAddress;

        return true;
    }
    
    function getWhiteListByIndex(uint _index) public view returns(WhiteList) {
       return whitelists[_index];
    }
    
    function insertWhitelist(
        string _name, 
        string _addr, 
        address _address
    )   
        public
        onlyOwner  
        returns(uint) 
    {
        uint myindex = whitelists.push(WhiteList(whitelists.length, _name, _addr)) - 1;
        whitelistAddress.push(_address);
        isWhiteList[_address] = true;

        return myindex;
    }
    
    function getWhiteLists(uint[] _index) 
        public 
        view 
        returns(WhiteList[]) 
    {
        WhiteList[] memory _whitelist = new WhiteList[](_index.length);
        for(uint8 i = 0; i < _index.length; i++) {
            _whitelist[i] = whitelists[_index[i]];
        }

        return _whitelist;
    }
    
    function approve(uint _medicineId) 
        public 
        _isWhiteList(msg.sender) 
        _isWaitting(_medicineId)  
        returns(bool _suc) 
    {
        _isValidApprove[msg.sender][_medicineId] = true;

        return true;
    }
    
    function countWhiteListApprove(uint _medicineId) 
        public 
        view 
        returns(uint) 
    {
        uint _count = 0;
        for(uint8 i = 0; i < whitelistAddress.length; i++) {
            if(_isValidApprove[whitelistAddress[i]][_medicineId]) {
                _count++;
            } 
        }

        return _count;
    }
    
    function getlistIdsForApprove()
        public 
        view 
        _isWhiteList(msg.sender)  
    returns(uint[])
    {
        return idForWattingByOneWhiteList[msg.sender];
    }
}