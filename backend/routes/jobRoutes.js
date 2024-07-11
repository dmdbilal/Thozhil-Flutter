const express = require('express');
const router = express.Router();
const jobController = require('../controller/jobController');
const userController = require('../controller/userController');
const multer = require('multer');


const upload = multer({ storage: multer.memoryStorage() });

const uploadFields = upload.fields([
  { name: 'logo', maxCount: 1 }
]);

router.get('/alljobs',jobController.alljobs);
router.post('/addjob',uploadFields,jobController.addjob);
router.get('/viewjob/:id',jobController.viewJob);
router.post('/apply',userController.protect,jobController.apply);
router.get('/dashboard',userController.protect,jobController.dashboard);

module.exports = router;