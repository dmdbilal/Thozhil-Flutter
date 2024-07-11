import 'package:flutter/material.dart';
import 'package:thozhil_flutter_app/model/job.model.dart';
import 'package:thozhil_flutter_app/services/job_service.dart';
import 'package:thozhil_flutter_app/util/util_functions.dart';
import '../model/job.model.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;

  JobDetailsScreen({Key? key, required this.job}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late double maxWidth;
  late double maxHeight;

  @override
  Widget build(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;
    var job = widget.job;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                      job.logoUrl,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Text('Failed to load image');
                      },
                    )
                ),
                const SizedBox(width: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        job.role,
                        style: dmSansStyle(20, fontWeight: FontWeight.bold)
                    ),
                    Text(
                        job.company,
                        style: dmSansStyle(15)
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            children: [
                              Icon(Icons.place, color: Colors.grey, size: 20),
                              Text(job.location, style: dmSansStyle(15, color: Colors.grey))
                            ]
                        ),
                        const SizedBox(height: 10),
                        Row(
                            children: [
                              Icon(Icons.money, color: Colors.grey, size: 20),
                              Text(job.salary, style: dmSansStyle(15, color: Colors.grey))
                            ]
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(color: Colors.black12)
                      ),
                      color: Colors.white,
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Job Summary",
                                style: dmSansStyle(
                                    20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey
                                )
                            ),
                            const SizedBox(height: 10),
                            Text(
                                    "Published On: ${job.posted.day.toString().padLeft(2, '0')}-${job.posted.month.toString().padLeft(2, '0')}-${job.posted.year}\n" +
                                    "Vacancies: ${job.vacancies} Positions\n" +
                                    "Job Nature: ${job.jobType}\n" +
                                    "Salary: ₹${job.salary}\n" +
                                    "Work Location: ${job.location}\n" +
                                    "Deadline: ${job.deadline.day.toString().padLeft(2, '0')}-${job.deadline.month.toString().padLeft(2, '0')}-${job.deadline.year}\n" +
                                    "Experience: ${job.experience}"
                            )
                          ],
                        ),
                      )
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Job Description",
                    style: dmSansStyle(20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 10),
                  Text(
                      job.jobDescription,
                      style: dmSansStyle(15, color: Colors.grey)
                  ),

                  const SizedBox(height: 20),
                  Text(
                      "Qualifications",
                      style: dmSansStyle(20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 10),
                  Text(
                      job.qualifications,
                      style: dmSansStyle(15, color: Colors.grey)
                  ),

                  const SizedBox(height: 20),
                  Text(
                      "Required Skills",
                      style: dmSansStyle(20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 10),
                  Text(
                      job.requiredSkills,
                      style: dmSansStyle(15, color: Colors.grey)
                  ),

                  const SizedBox(height: 20),
                  Text(
                      "Responsibilities",
                      style: dmSansStyle(20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 10),
                  Text(
                      job.responsibilities,
                      style: dmSansStyle(15, color: Colors.grey)
                  ),

                  const SizedBox(height: 20),
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(color: Colors.blue),
                            ),
                            minimumSize: Size(maxWidth/2 - 20, 50),
                            backgroundColor: Colors.white,
                            elevation: 0
                        ),
                        child: Text(
                            'Similar Jobs',
                            style: dmSansStyle(
                                20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                            )
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (await JobService.applyJob(job.id)) {
                            Navigator.pop(context);
                            print('job applied');
                          }
                          print('error');
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            minimumSize: Size(maxWidth/2 - 20, 50),
                            backgroundColor: Colors.blue,
                            elevation: 0
                        ),
                        child: Text(
                            'Apply Now',
                            style: dmSansStyle(
                                20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            )
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
}
