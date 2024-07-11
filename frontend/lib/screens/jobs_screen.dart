import 'package:flutter/material.dart';
import 'package:thozhil_flutter_app/model/job.model.dart';
import 'package:thozhil_flutter_app/screens/filter_screen.dart';
import 'package:thozhil_flutter_app/screens/job_detail_screen.dart';
import 'package:thozhil_flutter_app/screens/job_search_screen.dart';
import 'package:thozhil_flutter_app/services/job_service.dart';
import 'package:thozhil_flutter_app/util/user_preferences.dart';
import '../util/util_functions.dart';
import '../widgets/job_card.dart';
import 'drawer.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  late double maxWidth;
  late double maxHeight;
  late Future<List<Job>> jobs;
  late List<String> filters;

  @override
  void initState() {
    super.initState();

    filters = UserPreferences.getFilters();

    jobs = JobService.getAllJobs(filters);
  }

  @override
  Widget build(BuildContext context) {
    var assetsImage = const AssetImage('assets/thozhil_logo.png');
    var image = Image(image: assetsImage, fit: BoxFit.cover, height: 30);
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, color: Colors.blue, size: 35)
            );
          },
        ),
        title: Container(
          color: Colors.white,
          child: Center(
            child: image,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(Icons.notifications, color: Colors.blue, size: 30)
          )
        ],
      ),
      drawer: getDrawer(context, 2),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 10, 16),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Jobs",
                      style: dmSansStyle(20.0, fontWeight: FontWeight.bold, color: Colors.blue)
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            showSearch(
                                context: context,
                                // delegate to customize the search bar
                                delegate: JobSearchScreen(await JobService.getAllJobs([]))
                            );
                          },
                          icon: const Icon(Icons.search)
                      ),
                      IconButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const FilterScreen())
                            );
                          },
                          icon: const Icon(Icons.filter_alt)
                      ),
                    ],
                  ),
                ]),
            FutureBuilder<List<Job>>(
              future: jobs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data!.isEmpty) {
                  return Text(
                    "No Jobs available.",
                    style: dmSansStyle(14, fontWeight: FontWeight.bold, color:Colors.grey),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var job = data[index];
                          return JobCard(
                              context,
                              job,
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => JobDetailsScreen(job: job))
                                );
                              }
                          );
                        }
                    )
                  );
                } else {
                  return Text('No data');
                }
              },
            )
          ],
        )
      )
    );
  }
}
