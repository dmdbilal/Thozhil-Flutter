import 'package:flutter/material.dart';
import 'package:thozhil_flutter_app/screens/jobs_screen.dart';
import 'package:thozhil_flutter_app/util/user_preferences.dart';
import '../util/util_functions.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late double maxWidth;
  late double maxHeight;
  late TextEditingController _roleController;
  late TextEditingController _skillController;
  late TextEditingController _locationController;
  late TextEditingController _salaryController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _roleController = TextEditingController();
    _skillController = TextEditingController();
    _locationController = TextEditingController();
    _salaryController = TextEditingController();

    _roleController.text = UserPreferences.getFilters()[0];
    _skillController.text = UserPreferences.getFilters()[1];
    _locationController.text = UserPreferences.getFilters()[2];
    _salaryController.text = UserPreferences.getFilters()[3];
  }
  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            "Filter results",
            style: dmSansStyle(25, fontWeight: FontWeight.bold, color: Colors.blue)
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.blue, size: 30)
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /** Role */
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _roleController,
                      validator: (value) {
                        if (value == "") {
                          return "Enter role of interest";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter role',
                        labelText: 'Role',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /** Skills */
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _skillController,
                      validator: (value) {
                        if (value == "") {
                          return "Enter your skills";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter skills',
                        labelText: 'Skills',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /** Location */
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _locationController,
                      validator: (value) {
                        if (value == "") {
                          return "Enter location";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter location',
                        labelText: 'Location',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /** Salary */
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _salaryController,
                      validator: (value) {
                        if (value == "") {
                          return "Enter expected salary";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter salary',
                        labelText: 'Salary',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(color: Colors.blue),
                            ),
                            minimumSize: Size(maxWidth/3, 50),
                            backgroundColor: Colors.white,
                            elevation: 0
                        ),
                        child: Text(
                            'Cancel',
                            style: dmSansStyle(
                                20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                            )
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          UserPreferences.setFilters([_roleController.text, _skillController.text, _locationController.text, _salaryController.text]);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => JobsScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            minimumSize: Size(maxWidth/3, 50),
                            backgroundColor: Colors.blue,
                            elevation: 0
                        ),
                        child: Text(
                            'Apply',
                            style: dmSansStyle(
                                20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )
                        ),
                      ),
                      SizedBox(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
