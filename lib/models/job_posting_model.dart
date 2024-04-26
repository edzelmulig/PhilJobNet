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
  });

  factory JobPosting.fromMap(Map<String, dynamic> map) {
    return JobPosting(
      jobCategory: map['jobCategory'],
      jobType: map['selectedJobType'] ?? 'NO DATA',
      jobPosition: map['jobPosition'] ?? 'NO DATA',
      companyName: map['companyName'] ?? 'NO DATA',
      jobLocation: map['jobLocation'] ?? 'NO DATA',
      jobExperience: map['jobExperience'] ?? 'NO DATA',
      minimumSalary: map['minimumSalary'] ?? 0,
      maximumSalary: map['maximumSalary'] ?? 0,
      salaryType: map['selectedSalaryType'] ?? 'NO DATA',
    );
  }
}
