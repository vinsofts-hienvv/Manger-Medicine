pragma solidity ^0.4.25;
pragma  experimental ABIEncoderV2;

import "./LBDigitalCertificate.sol";
import "./LBMedicine.sol";
import "./MultiSign.sol";
import "./LBWhiteList.sol";
import "./LBProvider.sol";

contract MangerMedicine  {
    LBDigitalCertificate lbdigtal;
    LBMedicine lbmedicine;
    MultiSign lbmultisign;
    LBWhiteList lbwhitelist;
    LBProvider lbprovider;
    address public owner;
    

    mapping(address => uint[]) public addressUserToMedicineIndex;  // get ra index cua list medicine tu address
    mapping(uint => address) public medicineAddressOf; // medicine nay cua address nao //tu thang index get ra address cua thang white list 
    mapping(address => uint[]) public addressToCeritifateIndex;
    mapping(address => uint) addressToProvider; //
    mapping(address => bool) isRegister;
    mapping(uint => uint) certificateToMedicine;
    mapping(uint => uint) meddicineToCertificate;
    
    modifier isNotRegisterUser(address _addr) {
        require(!isRegister[_addr]);
        _;
    }
    
    modifier isRegisterUser(address _addr) {
        require(isRegister[_addr]);
        _;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        lbdigtal = LBDigitalCertificate(0x0971b5d216af52c411c9016bbc63665b4e6f2542);
        lbmedicine = LBMedicine(0xde6a66562c299052b1cfd24abc1dc639d429e1d6);
        lbmultisign = MultiSign(0x7beb6d4fd3f424762a540aa03194c45ff959cdeb);
        lbwhitelist = LBWhiteList(0xa113b22d40dc1d5d086003c27a556e597f614e8b);
        lbprovider = LBProvider(0x1526613135cbe54ee257c11dd17254328a774f4a);
    }
    
    
    function registerUser(string _providerName, string _addr, string _phone) isNotRegisterUser(msg.sender)  public returns(bool _suc) {
        uint myindex = lbprovider.insertProvider(_providerName, _addr, _phone);
        addressToProvider[msg.sender] =  myindex;
        isRegister[msg.sender] = true;
        _suc = true;
        return;
    }
    
    
    
    // regiser for medicine 
    function registerMedecine(string _medicineName,
                              string _structure,
                              string _uses,
                              string _productsBy,
                              uint _prices
                             ) 
                             isRegisterUser(msg.sender)  // check is register
                             public {
        uint myindex = lbmedicine.insertMedecine(_medicineName, _structure, _uses, _productsBy, _prices);
        addressUserToMedicineIndex[msg.sender].push(myindex);
        medicineAddressOf[myindex] = msg.sender;
        for(uint256 i = 0; i < lbwhitelist.getAddresslength(); i++) {
            address _myaddr = lbwhitelist.getAddress(i);
            lbwhitelist.setWaittingForApprove(_myaddr, myindex);
        }
           // add wattingForApprove whitelists
    }
    
    function approveMedicine( uint _medicineId) public returns(bool) {
        uint cout = lbwhitelist.approve(_medicineId);
        if(cout  >= 5) {
            lbmedicine.setMedicine(true, _medicineId);
            address  _addr = medicineAddressOf[_medicineId];
            uint _myindex = lbdigtal.insertDigitalCertificate("Cung Cap", now, "WhiteList");
            addressToCeritifateIndex[_addr].push(_myindex);  // 1 thang add co nhung chung chi nao
            certificateToMedicine[_myindex] = _medicineId;
            meddicineToCertificate[_medicineId] = _myindex;
        }
        return true;
    }

    
}