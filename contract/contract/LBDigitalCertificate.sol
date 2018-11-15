pragma solidity ^0.4.25;
pragma  experimental ABIEncoderV2;

import "./LBWhiteList.sol";
import "./LBMedicine.sol";


contract LBDigitalCertificate is LBWhiteList{
    //giay chung nhan
    struct DigitalCertificate{
        uint digitalCertificateId;
        string contents;  // contents
        uint dateOf;
        string productBy;
        bool isValid;
    }
    
    DigitalCertificate[] public digitalCertificates;
    
    function approveMedicine( uint _medicineId, address _medicinecontractAddress) 
        public 
        returns(bool) 
    {
        uint cout = countWhiteListApprove(_medicineId);
        if(cout  >= 5) {
            LBMedicine(_medicinecontractAddress).setMedicine(true, _medicineId);
            address  _addr = LBMedicine(_medicinecontractAddress).getmedicineAddressOf(_medicineId);
            uint _myindex = insertDigitalCertificate("Cung Cap", now, "WhiteList");
            LBMedicine(_medicinecontractAddress).setaddressToCeritifateIndex(_myindex, _addr); // 1 thang add co nhung chung chi nao
            LBMedicine(_medicinecontractAddress).setcertificateToMedicine(_myindex, _medicineId);
        }

        return true;
    }

    
    function updateDigitalCertificate(
        string _contents,
        uint _dateOf,
        bool _isvalid,
        uint _index
    ) 
        public 
        _isWhiteList(msg.sender)  
        returns(bool) 
    {
        digitalCertificates[_index].contents = _contents;
        digitalCertificates[_index].dateOf = _dateOf;
        digitalCertificates[_index].isValid = _isvalid;
        return true;
    }
    
    function getDigitalCertificate(uint _index)
        public view 
        _isWhiteList(msg.sender)
        returns(DigitalCertificate) 
    {
       return digitalCertificates[_index];
    }
    
    function insertDigitalCertificate(
        string _contents,
        uint _dateOf,
        string _product
    )
        public
        _isWhiteList(msg.sender)
        returns(uint)
    {
        uint myIndex = digitalCertificates.push(DigitalCertificate(digitalCertificates.length, _contents, _dateOf, _product,true)) - 1;
        return myIndex;
    }
    
    function getmanyInforDigitalCertificate(uint[] _index)
        public view
        _isWhiteList(msg.sender)  
        returns(DigitalCertificate[]) 
    {
        require(_index.length > 0);
        DigitalCertificate[] memory _digitalCertificate = new DigitalCertificate[](_index.length);
        for(uint8 i = 0; i < _index.length; i++) {
            _digitalCertificate[i] = digitalCertificates[_index[i]];
        }

        return _digitalCertificate;
    }
}