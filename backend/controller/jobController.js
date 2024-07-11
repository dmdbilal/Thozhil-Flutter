const Job = require('../model/jobModel');
const db = require('../config/database');
const User = require('../model/userModel');
const Application = require('../model/applicationModel');
const login = require('../controller/userController');
const storageReference = require("../firebase");

exports.alljobs = async (req,res) => {
  try{
    const { role, skill, location, salary } = req.query;

    let filter = {};

    if (role) {
      filter.role = { $regex: role, $options: 'i' };
    }   
    if (skill) {
      filter.required_skills = { $regex: skill, $options: 'i' };
    }
    if (location) {
      filter.location = { $regex: location, $options: 'i' };
    }
    if (salary) {
      filter.salary = { $gte: Number(salary) };
    }

    let jobs;

    if (filter) {
      jobs = await Job.find(filter);
    } else {
      jobs = await Job.find({});
    }

    res.status(200).json({
      jobs
    })
  } catch(err) {
    res.status(400).json({
      message: "Job fetch unsuccessful",
      error: err.message
    })
  }
}

exports.addjob = async (req,res) => {
  const fileBuffer = req.files.logo;
  const fileReference = storageReference.child(`logos/${req.files.logo[0].originalname}`);
  await fileReference.put(fileBuffer, { contentType: 'image/png' });
  const fileDownloadURL = await fileReference.getDownloadURL();

  try{
    const { 
      role,
      company,
      location,
      location_type,
      salary,
      job_type,
      job_description,
      qualifications,
      required_skills,
      responsibilities,
      vacancies,
      experience,
      deadline
    } = req.body;

    const newjob = new Job({
      role,
      company,
      location,
      location_type,
      salary,
      job_type,
      job_description,
      qualifications,
      required_skills,
      responsibilities,
      vacancies,
      experience,
      deadline,
      logo: fileDownloadURL
     });
     
    await newjob.save()
  
    res.status(201).json({
      message: "Job added successfully"
    });
  } catch(err) {
    res.status(400).json({
      message: "Job not added",
      error: err.message
    });
  }
}

exports.viewJob = async (req,res) => {
  try{
    const { id: jobId } = req.params;
    let jobDetails = await Job.find({ _id: jobId});
    //console.log(jobId);
    res.status(200).json({
      jobDetails
    });
  }catch(err) {
    res.status(400).json({
      message: "Job not found",
      error: err.message
    });
  }
}

exports.apply = async (req,res) => {
  try {
    const { jobId } = req.body;
    const userId = req.user._id.toString(); 

    console.log(userId,jobId);

    if (!userId || !jobId) {
      return res.status(400).json({ message: 'User ID and Job ID are required.' });
    }

    const application = new Application({
      userId,
      jobId,
      //status: 'pending'
    });

    await application.save();

    res.status(201).json({
      message: 'Application submitted successfully',
      application
    });
  } catch (err) {
    res.status(500).json({
      message: 'Application submission unsuccessful',
      error: err.message
    });
  }
}

exports.dashboard = async(req,res) => {
  try {
    const userId = req.user._id.toString(); 

    const records = await Application.find({ userId: userId });

    let accepted = 0;
    let rejected = 0;
    let pending = 0;

    records.forEach(record => {
      if (record.userId === userId) {
        switch (record.status) {
          case 'pending':
            pending++;
            break;
          case 'accepted':
            accepted++;
            break;
          case 'rejected':
            rejected++;
            break;
          default:
            break;
        }
      }
    });
    
    res.status(200).json({
      "applied": records.length,
      pending,
      accepted,
      rejected
    })
  } catch(err) {
    console.log(err);
  }
}