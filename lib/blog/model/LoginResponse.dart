class LoginResponse {
  String? token;
  String? userEmail;
  String? userNicename;
  String? userDisplayName;
  String? firstName;
  String? lastName;
  int? userId;
  // List<Null>? mbMyTopics;
  // Null? mbMyPreference;
  String? mbloggerProfileImage;

  LoginResponse(
      {this.token,
        this.userEmail,
        this.userNicename,
        this.userDisplayName,
        this.firstName,
        this.lastName,
        this.userId,
        // this.mbMyTopics,
        // this.mbMyPreference,
        this.mbloggerProfileImage});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userEmail = json['user_email'];
    userNicename = json['user_nicename'];
    userDisplayName = json['user_display_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userId = json['user_id'];
    // if (json['mb_my_topics'] != null) {
    //   mbMyTopics = <Null>[];
    //   json['mb_my_topics'].forEach((v) {
    //     mbMyTopics!.add(new Null.fromJson(v));
    //   });
    // }
    // mbMyPreference = json['mb_my_preference'];
    mbloggerProfileImage = json['mblogger_profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_email'] = this.userEmail;
    data['user_nicename'] = this.userNicename;
    data['user_display_name'] = this.userDisplayName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_id'] = this.userId;
    // if (this.mbMyTopics != null) {
    //   data['mb_my_topics'] = this.mbMyTopics!.map((v) => v.toJson()).toList();
    // }
    // data['mb_my_preference'] = this.mbMyPreference;
    data['mblogger_profile_image'] = this.mbloggerProfileImage;
    return data;
  }
}
