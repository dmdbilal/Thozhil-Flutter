const mongoose = require('mongoose');
const db = require('../config/database');

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  dob: {
    type: Date,
    required: true
  },
  age: {
    type: Number,
    required: true
  },
  gender: {
    type: String, 
    enum: ["Male","Female","Not Willing To Say"]
  },
  email: {
    type: String,
    lowercase: true,
    required: true,
    unique: true,
    match: [/^\S+@\S+\.\S+$/, 'Please enter a valid email address']
  },
  password: {
    type: String,
    required: true
  },
  mobile: {
    type: Number,
    validate: {
      validator: function(v) {
        return v.toString().length === 10;
      },
      message: props => `${props.value} is not a valid phone number!`
    }
  },
  address: {
    type: String
  },
  street: {
    type: String
  },
  city: {
    type: String
  },
  c: {
    type: String
  },
  state: {
    type: String
  },
  country: {
    type: String
  },
  pincode: {
    type: Number,
    validate: {
      validator: function(v) {
        return v.toString().length === 6;
      },
      message: props => `${props.value} is not a valid 6-digit pincode!`
    }
  },
  degree: {
    type: String
  },
  graduation: {
    type: String
  },
  experience: {
    type: Number
  },
  currentCTC: {
    type: Number
  },
  yearOfPassing: {
    type: Number
  },
  collegeName: {
    type: String
  },
  collegeDistrict: {
    type: String
  },
  collegeState: {
    type: String
  },
  areaOfInterest: {
    type: String
  },
  resume: {
    type: String
  },
  profilePic: {
    type: String
  }
});

const user = db.model("User",userSchema);

module.exports = user;