class NameModel {
  String? firstName;
  String? lastName;
  String? codeName;

  NameModel({
    required this.firstName,
    required this.lastName,
    required this.codeName,
  });

  NameModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    codeName = json['codeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['codeName'] = codeName;
    return data;
  }
}
