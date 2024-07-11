import 'package:flutter/material.dart';
import 'package:thozhil_flutter_app/screens/signup_screen.dart';
import 'package:thozhil_flutter_app/util/user_preferences.dart';
import 'package:thozhil_flutter_app/widgets/network_image_with_loader.dart';
import '../model/user.model.dart';
import '../widgets/profile_tile.dart';
import '../widgets/pdf_viewer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser() ?? User.dummy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
        ),
        actions: [
          IconButton(
            color: Colors.blue,
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(title: 'Edit Profile'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _buildProfileHeader(),

            const SizedBox(height: 20),

            // Personal Information Section
            _buildSectionTitle("Personal Informations"),
            _buildPersonalInfo(),

            // Educational Background Section
            _buildSectionTitle("Educational Background"),
            _buildEducationalBackground(),

            // Professional Qualifications Section
            _buildSectionTitle("Professional Qualifications"),
            _buildProfessionalQualifications(),

            // Resume Section
            _buildResumeSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        NetworkImageWithLoader(
          imageSrc: user.profilePic.isNotEmpty
              ? user.profilePic
              : 'https://t4.ftcdn.net/jpg/04/10/43/77/360_F_410437733_hdq4Q3QOH9uwh0mcqAhRFzOKfrCR24Ta.jpg',
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(user.email, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      children: [
        ProfileTile(title: 'DOB', value: user.dob.toIso8601String().split('T').first),
        ProfileTile(title: 'Age', value: user.age),
        ProfileTile(title: 'Gender', value: user.gender),
        ProfileTile(title: 'Mail', value: user.email),
        ProfileTile(title: 'Password', value: '..........'),
        ProfileTile(title: 'Mobile', value: user.mobile),
        ProfileTile(title: 'Address', value: user.address),
        ProfileTile(title: 'Street', value: user.street),
        ProfileTile(title: 'City', value: user.city),
        ProfileTile(title: 'District', value: user.district),
        ProfileTile(title: 'State', value: user.state),
        ProfileTile(title: 'Country', value: user.country),
        ProfileTile(title: 'Pincode', value: user.pincode),
        const Divider(thickness: 2),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEducationalBackground() {
    return Column(
      children: [
        ProfileTile(title: 'Degree', value: user.degree),
        ProfileTile(title: 'Year of graduation', value: user.graduation),
        ProfileTile(title: 'Year of passing out', value: user.yearOfPassing),
        ProfileTile(title: 'College Name', value: user.collegeName),
        ProfileTile(title: 'College District', value: user.collegeDistrict),
        ProfileTile(title: 'College State', value: user.collegeState),
        const Divider(thickness: 2),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProfessionalQualifications() {
    return Column(
      children: [
        ProfileTile(title: 'Year of Experience', value: user.experience),
        ProfileTile(title: 'Current CTC', value: user.currentCTC),
        ProfileTile(title: 'Area of interest', value: user.areaOfInterest),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildResumeSection() {
    return Row(
      children: [
        const Expanded(
          child: Text('Resume', style: TextStyle(fontSize: 15)),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PDFScreen(path: user.resume.path)),
              );
            },
            child: const Text(
              'View resume',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
