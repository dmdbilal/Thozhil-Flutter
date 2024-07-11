const mongoose = require('mongoose');
const db = require('../config/database');

const applicationSchema = new mongoose.Schema({
  userId: {
    type: String,
    required: true  
  },
  jobId: {
    type: String,
    required: true
  },
  appliedAt: {
    type: Date,
    default: Date.now,
  },
  status: {
    type: String,
    enum: ['pending', 'accepted', 'rejected'],
    default: 'pending'
  }
});

const Application = db.model('Application', applicationSchema);

module.exports = Application;