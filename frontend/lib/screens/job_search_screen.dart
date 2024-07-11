import 'package:flutter/material.dart';
import 'package:thozhil_flutter_app/services/job_service.dart';

import '../model/job.model.dart';
import '../widgets/job_card.dart';
import 'job_detail_screen.dart';

class JobSearchScreen extends SearchDelegate {
  late List<Job> jobs;

  JobSearchScreen(this.jobs);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Job> matchQuery = [];
    for (var job in jobs) {
      if (
        job.company.toLowerCase().contains(query.toLowerCase()) ||
        job.role.toLowerCase().contains(query.toLowerCase())
      ) {
        matchQuery.add(job);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return JobCard(
          context,
          result,
          () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobDetailsScreen(job: result))
          );
        }
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Job> matchQuery = [];
    for (var job in jobs) {
      if (
      job.company.toLowerCase().contains(query.toLowerCase()) ||
          job.role.toLowerCase().contains(query.toLowerCase())
      ) {
        matchQuery.add(job);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return JobCard(
            context,
            result,
                () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobDetailsScreen(job: result))
              );
            }
        );
      },
    );
  }
}
