class RegistrationResponse {
  RegistrationData? registrationData;
  String? message;

  RegistrationResponse({this.registrationData, this.message});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    registrationData = json['data'] != null ? new RegistrationData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.registrationData != null) {
      data['data'] = this.registrationData!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class RegistrationData {
  String? firstName;
  String? lastName;
  String? userEmail;
  String? userLogin;

  RegistrationData({this.firstName, this.lastName, this.userEmail, this.userLogin});

  RegistrationData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userEmail = json['user_email'];
    userLogin = json['user_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_email'] = this.userEmail;
    data['user_login'] = this.userLogin;
    return data;
  }
}
