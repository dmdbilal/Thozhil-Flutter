import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:file_picker/file_picker.dart';
import 'package:thozhil_flutter_app/screens/login_screen.dart';
import 'package:thozhil_flutter_app/services/auth_service.dart';
import 'package:thozhil_flutter_app/services/user_service.dart';
import 'package:thozhil_flutter_app/util/user_preferences.dart';
import '../model/user.model.dart';

class RegisterScreen extends StatefulWidget {
  final String title;
  const RegisterScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _mobileController;
  late TextEditingController _addressController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _districtController;
  late TextEditingController _stateController;
  late TextEditingController _countryController;
  late TextEditingController _pincodeController;
  late TextEditingController _graduationController;
  late TextEditingController _experienceController;
  late TextEditingController _currentCTCController;
  late TextEditingController _yearOfPassingController;
  late TextEditingController _collegeNameController;
  late TextEditingController _collegeDistrictController;
  late TextEditingController _collegeStateController;
  late TextEditingController _areaOfInterestController;

  List<String> roles = ["Select", "Candidate", "Employee"];
  List<String> genders = ["Male", "Female", "Prefer not to say"];
  late String _genderDropDownValue = genders[0];
  List<String> degrees = [
    "Select",
    "High School Diploma / GED",
    "Associate's Degree",
    "Bachelor's Degree",
    "Master's Degree",
    "Doctorate / PhD"
  ];
  late String _degreeDropDownValue = degrees[0];
  late User user;

  final _formKey = GlobalKey<FormState>();
  late File resume;
  String resumeName = "";

  // User Service
  User createUser() {
    return createUserFromControllers(
        nameController: _nameController,
        dobController: _dobController,
        ageController: _ageController,
        genderController: _genderDropDownValue,
        emailController: _emailController,
        passwordController: _passwordController,
        mobileController: _mobileController,
        addressController: _addressController,
        streetController: _streetController,
        cityController: _cityController,
        districtController: _districtController,
        stateController: _stateController,
        countryController: _countryController,
        pincodeController: _pincodeController,
        degreeController: _degreeDropDownValue,
        graduationController: _graduationController,
        experienceController: _experienceController,
        currentCTCController: _currentCTCController,
        yearOfPassingController: _yearOfPassingController,
        collegeNameController: _collegeNameController,
        collegeDistrictController: _collegeDistrictController,
        collegeStateController: _collegeStateController,
        areaOfInterestController: _areaOfInterestController,
        resume: resume,
        profilePic: ""
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dobController = TextEditingController();
    _ageController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _mobileController = TextEditingController();
    _addressController = TextEditingController();
    _streetController = TextEditingController();
    _cityController = TextEditingController();
    _districtController = TextEditingController();
    _stateController = TextEditingController();
    _countryController = TextEditingController();
    _pincodeController = TextEditingController();
    _graduationController = TextEditingController();
    _experienceController = TextEditingController();
    _currentCTCController = TextEditingController();
    _yearOfPassingController = TextEditingController();
    _collegeNameController = TextEditingController();
    _collegeDistrictController = TextEditingController();
    _collegeStateController = TextEditingController();
    _areaOfInterestController = TextEditingController();

    User? user = UserPreferences.getUser();

    if (user != null) {
      _nameController.text = user.name ?? '';
    _dobController.text = user.dob.toIso8601String().split('T').first ?? '';
    _ageController.text = user.age.toString() ?? '';
    _emailController.text = user.email ?? '';
    _passwordController.text = user.password ?? '';
    _mobileController.text = user.mobile.toString() ?? '';
    _addressController.text = user.address ?? '';
    _streetController.text = user.street ?? '';
    _cityController.text = user.city ?? '';
    _districtController.text = user.district ?? '';
    _stateController.text = user.state ?? '';
    _countryController.text = user.country ?? '';
    _pincodeController.text = user.pincode.toString() ?? '';
    _graduationController.text = user.graduation ?? '';
    _experienceController.text = user.experience.toString() ?? '';
    _currentCTCController.text = user.currentCTC.toString() ?? '';
    _yearOfPassingController.text = user.yearOfPassing.toString() ?? '';
    _collegeNameController.text = user.collegeName ?? '';
    _collegeDistrictController.text = user.collegeDistrict ?? '';
    _collegeStateController.text = user.collegeState ?? '';
    _areaOfInterestController.text = user.areaOfInterest ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        home: Scaffold(
        body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 0,
              child: Container(
                  color: Colors.white,
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    centerTitle: true,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.blue, size: 30)),
                    title: Text(
                      widget.title,
                      style: GoogleFonts.dmSans(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
            Flexible(
                flex: 10,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(70.00)),
                  child: Container(
                      padding: const EdgeInsets.all(30),
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                          maxWidth: maxWidth, maxHeight: maxHeight),
                      color: Colors.blue,
                      child: ListView(
                        children: [
                          registrationForm(context),
                          const SizedBox(height: 20),
                          if (widget.title == 'SIGN UP')
                            const Text(
                                'By clicking register, you agree to Thozhil’s Terms and Conditions.',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white70)),
                          if (widget.title == 'SIGN UP')
                            const SizedBox(height: 20),

                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  User user = createUser();
                                  if (await AuthService.registerUser(user)) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginScreen())
                                    );
                                  } else {
                                    print('Error');
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize: Size(maxWidth, 50)),
                              child: Text(widget.title == 'SIGN UP' ? "Register" : "Apply Changes",
                                  style: GoogleFonts.dmSans(
                                      color: Colors.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        ],
                      )),
                )),
          ],
        ),
      ),
    ));
  }

  Widget registrationForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /** Name */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == "") {
                  return "Enter your name !";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** DOB */
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              )),
          const SizedBox(height: 20),

          /** Age */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _ageController,
              validator: (value) {
                if (value == "") {
                  return "Enter your age !";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your age',
                labelText: 'Age',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Gender */
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InputDecorator(
                decoration: const InputDecoration(labelText: "Gender"),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                  value: _genderDropDownValue,
                  items: genders.map((String gender) {
                    return DropdownMenuItem<String>(
                        value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _genderDropDownValue = value!;
                    });
                  },
                  isExpanded: true,
                )),
              )),
          const SizedBox(height: 20),

          /** Mail ID */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (value) {
                if (value == "") {
                  return "Enter your email id";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter mail id',
                labelText: 'Email',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Password */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == "") {
                  return "Enter your password";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter password',
                labelText: 'Password',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Mobile */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: _mobileController,
              // validator: (value) {
              //   if (value == "") {
              //     return "Enter mobile number";
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                hintText: 'Enter your mobile number',
                labelText: 'Mobile Number',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Address */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              controller: _addressController,
              maxLines: null,
              // validator: (value) {
              //   if (value == "") {
              //     return "Enter your address";
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                hintText: 'Enter address',
                labelText: 'Address',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Country */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CountryStateCityPicker(
                country: _countryController,
                state: _stateController,
                city: _cityController,
                dialogColor: Colors.grey.shade200,
                textFieldDecoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none))),
          ),
          const SizedBox(height: 20),

          /** Street */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _streetController,
              validator: (value) {
                if (value == "") {
                  return "Enter street name";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter street name',
                labelText: 'Street',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** District */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _districtController,
              validator: (value) {
                if (value == "") {
                  return "Enter pincode";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter pincode',
                labelText: 'Pincode',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Pin Code */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _pincodeController,
              // validator: (value) {
              //   if (value == "") {
              //     return "Enter pincode";
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                hintText: 'Enter pincode',
                labelText: 'Pincode',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Degree */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              value: _degreeDropDownValue,
              items: degrees.map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _degreeDropDownValue = value!;
                });
              },
              isExpanded: true,
            )),
          ),
          const SizedBox(height: 20),

          /** Graduation */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: _graduationController,
              validator: (value) {
                if (value == "") {
                  return "Enter year of graduation";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter year of graduation',
                labelText: 'Year of graduation',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Experience */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _experienceController,
              maxLines: null,
              validator: (value) {
                if (value == "") {
                  return "Enter your experience";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter experience',
                labelText: 'Experience',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Current CTC */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _currentCTCController,
              maxLines: null,
              validator: (value) {
                if (value == "") {
                  return "Enter your current CTC";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter current CTC',
                labelText: 'Current CTC (0 if NA)',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Year of passing */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              controller: _yearOfPassingController,
              // validator: (value) {
              //   if (value == "") {
              //     return "Enter Year of passing";
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                hintText: 'Enter year of passing',
                labelText: 'Year of passing',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** College Name */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _collegeNameController,
              // validator: (value) {
              //   if (value == "") {
              //     return "Enter college name";
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                hintText: 'Enter college name',
                labelText: 'College Name',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** College District */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _collegeDistrictController,
              validator: (value) {
                if (value == "") {
                  return "Enter college district";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter college district',
                labelText: 'College District',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** College State */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _collegeStateController,
              validator: (value) {
                if (value == "") {
                  return "Enter college state";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter college state',
                labelText: 'College State',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Area of interest */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _areaOfInterestController,
              // validator: (value) {
              //   if (value == "") {
              //     return "Enter area of interests";
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                hintText: 'Enter your interests',
                labelText: 'Area of interest',
              ),
            ),
          ),
          const SizedBox(height: 20),

          /** Resume */
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  PlatformFile platformFile = result.files.first;
                  setState(() {
                    resume = File(platformFile.path!);
                    resumeName = platformFile.name!;
                  });
                }
              },
              child: Text(resumeName.isEmpty ? "Upload Resume" : resumeName),
            )
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (date != null) {
      setState(() {
        _dobController.text = date.toString().split(" ")[0];
      });
    }
  }
}
