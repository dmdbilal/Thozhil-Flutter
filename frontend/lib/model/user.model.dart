import 'dart:io';

class User {
  String name;
  DateTime dob;
  int age;
  String gender;
  String email;
  String password;
  int mobile;
  String address;
  String street;
  String city;
  String district;
  String state;
  String country;
  int pincode;
  String degree;
  String graduation;
  int experience;
  double currentCTC;
  int yearOfPassing;
  String collegeName;
  String collegeDistrict;
  String collegeState;
  String areaOfInterest;
  File resume;
  String profilePic;

  User({
    required this.name,
    required this.dob,
    required this.age,
    required this.gender,
    required this.email,
    required this.password,
    required this.mobile,
    required this.address,
    required this.street,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.degree,
    required this.graduation,
    required this.experience,
    required this.currentCTC,
    required this.yearOfPassing,
    required this.collegeName,
    required this.collegeDistrict,
    required this.collegeState,
    required this.areaOfInterest,
    required this.resume,
    required this.profilePic
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      age: json['age'] is int ? json['age'] : int.parse(json['age']),
      gender: json['gender'],
      email: json['email'],
      password: json['password'],
      mobile: json['mobile'] is int ? json['mobile'] : int.parse(json['mobile']),
      address: json['address'],
      street: json['street'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'] is int ? json['pincode'] : int.parse(json['pincode']),
      degree: json['degree'],
      graduation: json['graduation'],
      experience: json['experience'] is int ? json['experience'] : int.parse(json['experience']),
      currentCTC: json['currentCTC'] is double ? json['currentCTC'] : double.parse(json['currentCTC'].toString()),
      yearOfPassing: json['yearOfPassing'] is int ? json['yearOfPassing'] : int.parse(json['yearOfPassing']),
      collegeName: json['collegeName'],
      collegeDistrict: json['collegeDistrict'],
      collegeState: json['collegeState'],
      areaOfInterest: json['areaOfInterest'],
      resume: File(json['resume']),
      profilePic: json['profilePic']
    );
  }

  Map<String, String> toJson() {
    return {
      'name': name,
      'dob': dob.toIso8601String().split('T').first,
      'age': age.toString(),
      'gender': gender,
      'email': email,
      'password': password,
      'mobile': mobile.toString(),
      'address': address,
      'street': street,
      'city': city,
      'district': district,
      'state': state,
      'country': country,
      'pincode': pincode.toString(),
      'degree': degree,
      'graduation': graduation,
      'experience': experience.toString(),
      'currentCTC': currentCTC.toString(),
      'yearOfPassing': yearOfPassing.toString(),
      'collegeName': collegeName,
      'collegeDistrict': collegeDistrict,
      'collegeState': collegeState,
      'areaOfInterest': areaOfInterest,
      'resume': resume.path,
      'profilePic': profilePic
    };
  }

  factory User.dummy() {
    return User(
      name: 'John Doe',
      dob: DateTime(1990, 1, 1),
      age: 30,
      gender: 'Male',
      email: 'john.doe@example.com',
      password: 'password',
      mobile: 1234567890,
      address: '123 Main St',
      street: 'Main St',
      city: 'Cityville',
      district: 'District 1',
      state: 'State',
      country: 'Country',
      pincode: 123456,
      degree: 'Bachelor of Science',
      graduation: '2012',
      experience: 5,
      currentCTC: 100000.0,
      yearOfPassing: 2012,
      collegeName: 'University of Example',
      collegeDistrict: 'Example District',
      collegeState: 'Example State',
      areaOfInterest: 'Example Area',
      resume: File('https://www.antennahouse.com/hubfs/xsl-fo-sample/pdf/basic-link-1.pdf'), // Provide a dummy path
      profilePic: 'https://static.vecteezy.com/system/resources/thumbnails/005/346/410/small_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg',
    );
  }
}
