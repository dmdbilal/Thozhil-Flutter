import 'package:flutter/material.dart';

import '../model/job.model.dart';
import '../util/util_functions.dart';

Widget JobCard(
    BuildContext context,
    Job job,
    VoidCallback onTap
) {
  return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(color: Colors.black12)
      ),
      color: Colors.white,
      elevation: 0,
      child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.company,
                    style: dmSansStyle(20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    job.role,
                    style: dmSansStyle(16, color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(Icons.place, color: Colors.grey, size: 20,),
                      SizedBox(width: 10,),
                      Text(
                        job.location,
                        style: dmSansStyle(15, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(Icons.money, color: Colors.grey, size: 20),
                      SizedBox(width: 10,),
                      Text(
                        job.salary,
                        style: dmSansStyle(15, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(
                      (job.posted.day - DateTime.now().day) == 0 ? "Today" : "${job.posted.day}d ago",
                    style: dmSansStyle(15, color: Colors.black38),
                  ),
                ],
              ),
            ),
          )
      )
  );
}