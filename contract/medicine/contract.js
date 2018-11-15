const Config = require('./config');
const Web3 = require('web3');
const Tx = require('ethereumjs-tx');
const web3 = new Web3(new Web3.providers.HttpProvider(Config.httpProvider));
MedicineContract = new web3.eth.Contract(Config.abiContract, Config.addressContract);

module.exports = {
    MedicineContract
}