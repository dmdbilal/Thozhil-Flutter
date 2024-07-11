const mongoose = require('mongoose');
const db = require('../config/database');

const resumeSchema = new mongoose.Schema({
  name: String,
  url: String
});

const Resume = db.model('Resume',resumeSchema);

module.exports = Resume;