class Job {
  final String id;
  final String role;
  final String company;
  final String location;
  final String locationType;
  final String salary;
  final String jobType;
  final String jobDescription;
  final String qualifications;
  final String requiredSkills;
  final String responsibilities;
  final int vacancies;
  final String experience;
  final DateTime deadline;
  final DateTime posted;
  final String logoUrl;

  Job({
    required this.id,
    required this.role,
    required this.company,
    required this.location,
    required this.locationType,
    required this.salary,
    required this.jobType,
    required this.jobDescription,
    required this.qualifications,
    required this.requiredSkills,
    required this.responsibilities,
    required this.vacancies,
    required this.experience,
    required this.deadline,
    required this.posted,
    required this.logoUrl
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      role: json['role'],
      company: json['company'],
      location: json['location'],
      locationType: json['location_type'],
      salary: json['salary'],
      jobType: json['job_type'],
      jobDescription: json['job_description'],
      qualifications: json['qualifications'],
      requiredSkills: json['required_skills'],
      responsibilities: json['responsibilities'],
      vacancies: json['vacancies'],
      experience: json['experience'],
      deadline: DateTime.parse(json['deadline']),
      posted: DateTime.parse(json['posted']),
      logoUrl: json['logo']
    );
  }
}