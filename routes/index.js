var express = require('express');
var router = express.Router();
var Home = require("../App/controllers/HomeController");
/* GET home page. */
router.get('/', Home.homePage)
      .get('/admin', Home.adminPage)

module.exports = router;
