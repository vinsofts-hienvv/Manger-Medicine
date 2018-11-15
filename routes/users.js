var express = require('express');
var router = express.Router();
var User = require("../App/controllers/UserController");

router.get('/', User.userPage); /* GET users listing. */

module.exports = router;
