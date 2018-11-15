const httpProvider = 'https://ropsten.infura.io/v3/2ea352f51b5a45819be9923cdfb58894';

const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.HttpProvider(httpProvider));

const Tx = require('ethereumjs-tx');

const writeConfig = require('./writeConfig').writeConfig;

const fs = require('fs');
input = fs.readFileSync('medicine.sol');

const solc = require('solc');
output = solc.compile(input.toString(), 1);

const bytecode = output.contracts[':Betting'].bytecode;
const abi = JSON.stringify(JSON.parse(output.contracts[':Betting'].interface));
console.log('bytecode: ', bytecode);
console.log('abi: ', abi);

const privateKey = '13B66C7C98144C3BBD50C4169F4A4032D0648C7AA250C2937EBB5E600D2F677B';

var wallet = web3.eth.accounts.privateKeyToAccount('0x' + privateKey);
web3.eth.getTransactionCount(wallet.address).then(nonce => {
    const rawTx = {
        nonce: web3.utils.toHex(nonce),
        gasPrice: web3.utils.toHex(web3.utils.toWei('40', 'gwei')),
        gasLimit: web3.utils.toHex(3000000),
        data: '0x' + bytecode
    };
    const tx = new Tx(rawTx);

    tx.sign(Buffer.from(privateKey, 'hex'));
    const raw = '0x' + tx.serialize().toString('hex');
    web3.eth.sendSignedTransaction(raw).then(resp => {
        console.log('resp: ', resp);
        writeConfig(httpProvider, resp.contractAddress, abi);
    });

}).catch(error => {
    console.log(error.message)
});