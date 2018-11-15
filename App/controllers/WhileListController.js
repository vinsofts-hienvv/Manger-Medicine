const Helper = require("../helpers/Medicine");
var Web3 = require('web3');
var web3 = new Web3(Helper.host);
// var WhileList = new web3.eth.Contract(Helper.whileList.abi, Helper.whileList.address); // init contract

module.exports = {
    insertWhileList: (req, res) => {
        WhileList.methods.updateWhileList(
            req.body.WhileListId,
            req.body.WhileListName,
            req.body.WhileListAddress,
            req.body.WhileListTelephone,
            req.body.WhileListOwner,
        )
        .on("receipt", receipt => {
            if(!receipt.status) return res.json({status: 400});
            return res.json({status: 200})
        })
    },

    changeWhileList: (req, res) => {
        WhileList.methods.changeWhileList(
            req.body.WhileListName,
            req.body.WhileListAddress,
            req.body.WhileListTelephone,
            req.body.WhileListOwner,
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