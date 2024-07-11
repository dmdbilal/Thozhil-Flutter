import 'package:flutter/material.dart';
import 'package:thozhil_flutter_app/screens/interships_screen.dart';
import 'package:thozhil_flutter_app/screens/jobs_screen.dart';
import 'package:thozhil_flutter_app/screens/profile_screen.dart';
import 'package:thozhil_flutter_app/util/user_preferences.dart';
import 'package:thozhil_flutter_app/widgets/network_image_with_loader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/util_functions.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

/** Drawer Screens
 * 1. Home
 * 2. Jobs
 * 3. Internships
 * 4. Success signals
 * 5. How it works
 * 6. FAQs
 */

Widget getDrawer(BuildContext context, int screen) {
  return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10,),
                    NetworkImageWithLoader(
                      imageSrc: (UserPreferences.getUser()?.profilePic?.isNotEmpty ?? false)
                          ? UserPreferences.getUser()!.profilePic
                          : 'https://t4.ftcdn.net/jpg/04/10/43/77/360_F_410437733_hdq4Q3QOH9uwh0mcqAhRFzOKfrCR24Ta.jpg',
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Mohamed Bilal",
                            style: dmSansStyle(20, fontWeight: FontWeight.bold)
                        ),
                        Text(
                            "B.Tech IT",
                            style: dmSansStyle(15, color: Colors.black45)
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                          },
                          child: Text(
                              "view profile",
                              style: dmSansStyle(18, fontWeight: FontWeight.bold, color: Colors.blue)
                          )
                        )
                      ],
                    )
                  ],
                ),
              )
          ),

          ListTile(
            title: Text(
                "Home",
                style: dmSansStyle(
                    18,
                    fontWeight: FontWeight.bold,
                    color: screen == 1 ? Colors.blue : Colors.black45
                )
            ),
            leading: Icon(
              Icons.home_outlined,
              color: screen == 1 ? Colors.blue : Colors.black45
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
              );
            },
          ),
          ListTile(
            title: Text(
                "Jobs",
                style: dmSansStyle(
                    18,
                    fontWeight: FontWeight.bold,
                    color: screen == 2 ? Colors.blue : Colors.black45
                )
            ),
            leading: Icon(
                Icons.shopping_bag_outlined,
                color: screen == 2 ? Colors.blue : Colors.black45
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const JobsScreen()),
              );
            },
          ),
          ListTile(
            title: Text(
                "Internships",
                style: dmSansStyle(
                    18,
                    fontWeight: FontWeight.bold,
                    color: screen == 3 ? Colors.blue : Colors.black45
                )
            ),
            leading: Icon(
                Icons.card_travel,
                color: screen == 3 ? Colors.blue : Colors.black45
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InternshipsScreen()),
              );
            },
          ),
          ListTile(
            title: Text(
                "Success Signal",
                style: dmSansStyle(
                    18,
                    fontWeight: FontWeight.bold,
                    color: screen == 4 ? Colors.blue : Colors.black45
                )
            ),
            leading: Icon(
                Icons.playlist_add_check,
                color: screen == 4 ? Colors.blue : Colors.black45
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
                "How it works?",
                style: dmSansStyle(
                    18,
                    fontWeight: FontWeight.bold,
                    color: screen == 5 ? Colors.blue : Colors.black45
                )
            ),
            leading: Icon(
                Icons.how_to_reg_outlined,
                color: screen == 5 ? Colors.blue : Colors.black45
            ),
            onTap: () async {
              await launchUrl(Uri.parse('https://www.thozhil.co.in/how_it_works'), mode: LaunchMode.inAppWebView,);
            },
          ),
          ListTile(
            title: Text(
                "FAQs",
                style: dmSansStyle(
                    18,
                    fontWeight: FontWeight.bold,
                    color: screen == 6 ? Colors.blue : Colors.black45
                )
            ),
            leading: Icon(
                Icons.question_answer_outlined,
                color: screen == 6 ? Colors.blue : Colors.black45
            ),
            onTap: () async {
              await launchUrl(Uri.parse('https://www.thozhil.co.in/faq'), mode: LaunchMode.inAppWebView,);
            },
          ),
          const ListTile(),
          ListTile(
            title: Text("\t\tLogout", style: dmSansStyle(18, fontWeight: FontWeight.bold, color: Colors.black45)),
            onTap: () async {
              await UserPreferences.setLoggedIn(false);
              UserPreferences.getInstance().clear();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false
              );
            },
          ),
        ],
      )
  );
}