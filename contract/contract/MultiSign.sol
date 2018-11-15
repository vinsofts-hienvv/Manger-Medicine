pragma solidity ^0.4.25;
pragma  experimental ABIEncoderV2;

contract MultiSign {
    

    uint8 public constant MAX_MANGER = 10;
    uint8 public numberRequire = 2;
    mapping(address => mapping(address => bool)) internal _isValidApproveAddMember;
    mapping(address => bool) internal _isWhiteList;
    

    
    modifier validRequirement(uint ownerCount) {
        require(ownerCount <= MAX_MANGER
            && numberRequire <= ownerCount
            && numberRequire != 0
            && ownerCount != 0);
        _;
    }
    
    modifier MutilIsWhiteList(address _addr) {
        require(_isWhiteList[_addr]);
        _;
    }
    
    modifier isNotWhiteList(address _addr) {
        require(!_isWhiteList[_addr]);
        _;
    }
    
    function changeNumberRequire(uint8 _number, address[] _whiteList) validRequirement(_whiteList.length)  internal returns(bool _suc) {
        require(_number != 0);
        require(_number <= _whiteList.length);
        numberRequire = _number;
        _suc = true;
        return;
    }
    

    
    function approveAddMemberWhiteList(address _member) isNotWhiteList(_member) internal returns(bool _suc) {
        require(_member != 0x0);
        _isValidApproveAddMember[msg.sender][_member] = true;
        _suc = true;
        return;
    }
    
    
    function coutWhiteListApproveAddMember(address[] _whiteList, address _member) internal view returns(uint) {
        uint8 _count = 0;
        for(uint8 i = 0; i < _whiteList.length; i++) {
            if(_isValidApproveAddMember[_whiteList[i]][_member]) {
                _count++;
            } 
        }
        return _count;
    }
    
    
    // NHA quan ly

   
}

