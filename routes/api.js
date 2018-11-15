var express = require('express');
var router = express.Router();
var Provider = require("../App/controllers/ProviderController");
var WhileList = require("../App/controllers/WhileListController");

router.post('/insert-provider', Provider.insertProvider) // add provider
      .post('/change-provider', Provider.changeProvider) // change provider
      .post('/insert-whileList', WhileList.insertWhileList) // change WhileList
      .post('/change-whileList', WhileList.changeWhileList) // change WhileList

module.exports = router;