import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../model/user.model.dart';

User createUserFromControllers({
  required TextEditingController nameController,
  required TextEditingController dobController,
  required TextEditingController ageController,
  required String genderController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController mobileController,
  required TextEditingController addressController,
  required TextEditingController streetController,
  required TextEditingController cityController,
  required TextEditingController districtController,
  required TextEditingController stateController,
  required TextEditingController countryController,
  required TextEditingController pincodeController,
  required String degreeController,
  required TextEditingController graduationController,
  required TextEditingController experienceController,
  required TextEditingController currentCTCController,
  required TextEditingController yearOfPassingController,
  required TextEditingController collegeNameController,
  required TextEditingController collegeDistrictController,
  required TextEditingController collegeStateController,
  required TextEditingController areaOfInterestController,
  required File resume,
  required String profilePic
}) {

  String dateString = dobController.text;
  DateFormat dateFormat = DateFormat('d/M/yyyy');
  DateTime dateTime = dateFormat.parse(dateString);

  return User(
    name: nameController.text,
    dob: dateTime,
    age: int.parse(ageController.text),
    gender: genderController,
    email: emailController.text,
    password: passwordController.text,
    mobile: int.parse(mobileController.text),
    address: addressController.text,
    street: streetController.text,
    city: cityController.text,
    district: districtController.text,
    state: stateController.text,
    country: countryController.text,
    pincode: int.parse(pincodeController.text),
    degree: degreeController,
    graduation: graduationController.text,
    experience: int.parse(experienceController.text),
    currentCTC: double.parse(currentCTCController.text),
    yearOfPassing: int.parse(yearOfPassingController.text),
    collegeName: collegeNameController.text,
    collegeDistrict: collegeDistrictController.text,
    collegeState: collegeStateController.text,
    areaOfInterest: areaOfInterestController.text,
    resume: resume,
    profilePic: profilePic
  );
}