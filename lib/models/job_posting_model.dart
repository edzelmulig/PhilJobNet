import 'package:cloud_firestore/cloud_firestore.dart';

class JobPosting {
  String? jobCategory;
  String? jobType;
  String? jobPosition;
  String? companyName;
  String? jobLocation;
  String? jobExperience;
  int? minimumSalary;
  int? maximumSalary;
  String? salaryType;
  Timestamp? datePosted;

  JobPosting({
    this.jobCategory,
    this.jobType,
    this.jobPosition,
    this.companyName,
    this.jobLocation,
    this.jobExperience,
    this.minimumSalary,
    this.maximumSalary,
    this.salaryType,
    this.datePosted,
  });

  factory JobPosting.fromMap(Map<String, dynamic> map) {
    return JobPosting(
      jobCategory: map['jobCategory'],
      jobType: map['jobType'] ?? 'NO DATA',
      jobPosition: map['jobPosition'] ?? 'NO DATA',
      companyName: map['companyName'] ?? 'NO DATA',
      jobLocation: map['jobLocation'] ?? 'NO DATA',
      jobExperience: map['jobExperience'] ?? 'NO DATA',
      minimumSalary: map['minimumSalary'] ?? 0,
      maximumSalary: map['maximumSalary'] ?? 0,
      salaryType: map['salaryType'] ?? 'NO DATA',
      datePosted: map['datePosted'],
    );
  }
}
