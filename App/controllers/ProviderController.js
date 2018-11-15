const Helper = require("../helpers/Medicine");
var Web3 = require('web3');
var web3 = new Web3(Helper.host);
// var Provider = new web3.eth.Contract(Helper.provider.abi, Helper.provider.address); // init contract

module.exports = {
    insertProvider: (req, res) => {
        Provider.methods.updateProvider(
            req.body.providerId,
            req.body.providerName,
            req.body.providerAddress,
            req.body.providerTelephone,
            req.body.providerOwner,
        )
        .send({
            from: "",
            gasLimit: 3000000
        })
        .on("receipt", receipt => {
            if(!receipt.status) return res.json({status: 400});
            return res.json({status: 200})
        })
    },

    changeProvider: (req, res) => {
        Provider.methods.changeProvider(
            req.body.providerName,
            req.body.providerAddress,
            req.body.providerTelephone,
            req.body.providerOwner,
        )
        .send({
            from: "",
            gasLimit: 3000000
        })
        .on("receipt", receipt => {
            if(!receipt.status) return res.json({status: 400});
            return res.json({status: 200})
        })
    },
}