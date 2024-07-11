const mongoose = require('mongoose');
const db = require('../config/database');

const jobSchema = new mongoose.Schema({
  role: {
    type: String,
    required: true
  },
  company: {
    type: String,
    required: true
  },
  location: {
    type: String,
    required: true
  },
  location_type: {
    type: String,
    enum: ['remote', 'in-office', 'hybrid'],
    required: true
  },
  salary: {
    type: String,
    required: true
  },
  job_type: {
    type: String,
    enum: ['Full-time', 'Part-time'],
    required: true
  },
  job_description: {
    type: String,
    required: true
  },
  qualifications: {
    type: String,
    required: true
  },
  required_skills: {
    type: String,
    required: true
  },
  responsibilities: {
    type: String,
    required: true
  },
  vacancies: {
    type: Number,
    required: true
  },
  experience: {
    type: String,
    required: true
  },
  deadline: {
    type: Date,
    required: true,
    index: { expireAfterSeconds: 0 } 
  },
  posted: {
    type: Date,
    default: Date.now(),
  },
  postedAgo: {
    type: Number
  },
  logo: {
    type: String
  }
});

jobSchema.pre('save', function(next) {
  if (!this.postedAgo) {
    const now = Date.now();
    const postedTime = this.posted.getTime();
    const diffInMilliseconds = now - postedTime;
    const diffInDays = Math.floor(diffInMilliseconds / (1000 * 60 * 60 * 24)); // Convert milliseconds to days
    this.postedAgo = diffInDays;
  }
  next();
});

const job = db.model('Job',jobSchema);

module.exports = job;
