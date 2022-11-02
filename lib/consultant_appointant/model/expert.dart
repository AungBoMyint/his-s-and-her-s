class ExpertModel {
  final String? id;
  final String photolink;
  final String photolink2;
  final String photolink3;
  final String name;
  final String type;
  final String description;
  final String job;
  final String rate;
  final String rating;
  final String rating2;
  final String jobTitle;
  final String jobDescription;
  final String propertyAddress;


  ExpertModel({
    this.id,
    required this.photolink,
    required this.photolink2,
    required this.photolink3,
    required this.name,
    required this.type,
    required this.description,
    required this.job,
    required this.rate,
    required this.rating,
    required this.rating2,
    required this.jobTitle,
    required this.jobDescription,
    required this.propertyAddress,

  });

  factory ExpertModel.fromJson(Map<String, dynamic> json, String id) =>
      ExpertModel(
        id: id,
        photolink: json['photolink'] as String,
        photolink2: json['photolink2'] as String,
        photolink3: json['photolink3'] as String,
        name: json['name'] as String,
        type: json['type'] as String,
        description: json['description'] as String,
        job: json['job'] as String,
        rate: json['rate'] as String,
        rating: json['rating'] as String,
        rating2: json['rating2'] as String,
        jobTitle: json['jobTitle'] as String,
        jobDescription: json['jobDescription'] as String,
        propertyAddress: json['propertyAddress'] as String,


      );

  Map<String, dynamic> toJson() => {
        'photolink': photolink,
        'photolink2': photolink2,
        'photolink3': photolink3,
        'name': name,
        'type': type,
        'description': description,
        'job': job,
        'rate': rate,
        'rating': rating,
        'rating2': rating2,
        'jobTitle': jobTitle,
        'jobDescription': jobDescription,
        'propertyAddress': propertyAddress,

      };
}
