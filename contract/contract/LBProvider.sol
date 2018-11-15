pragma solidity ^0.4.25;
pragma  experimental ABIEncoderV2;

import "./Owner.sol";

contract LBProvider is Owner{
      // NHA CUNG CAP
    struct Provider{
        uint providerId;
        string providerName;
        string providerAddress;
        string providerTelephone;
    }

    Provider[] internal providers;
    
    function updateProvider(
        string _providerName,
        string _providerAddress,
        string _providerTelephone,
        uint _index
    )
        public 
        onlyOwner 
        returns(bool) 
    {
        providers[_index].providerName = _providerName;
        providers[_index].providerAddress = _providerAddress;
        providers[_index].providerTelephone = _providerTelephone;
        return true;
    }
    
    function getProvider(uint _index)  public view returns(Provider) {
       return providers[_index];
    }
    
    function insertProvider(
        string _providerName,
        string _providerAddress,
        string _providerTelephone
    )
        public 
        returns(uint) 
    {
        uint myindex = providers.push(Provider(providers.length, _providerName, _providerAddress,_providerTelephone)) - 1;
        return myindex;
    }
    
    function listProviders(uint[] _index) 
        public 
        view returns(Provider[]) 
    {
        require(_index.length > 0);
        Provider[] memory _provider = new Provider[](_index.length);
        for(uint8 i = 0; i < _index.length; i++) {
            _provider[i] =  providers[_index[i]];
        }
        //
        return _provider;
    }
}