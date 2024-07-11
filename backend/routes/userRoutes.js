const express = require('express');
const router = express.Router();
const userController = require('../controller/userController');
const multer = require('multer');

const upload = multer({ storage: multer.memoryStorage() });

const uploadFields = upload.fields([
  { name: 'resume', maxCount: 1 },
  { name: 'profilePic', maxCount: 1 }
]);

router.post('/register',uploadFields,userController.register);
router.post('/login',userController.login);
router.get('/users',userController.userInfo);

module.exports = router;