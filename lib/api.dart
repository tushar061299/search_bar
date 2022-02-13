class RandomApi {
  RandomApi({
    required this.name,
    required this.gender,
    required this.location,
    // required this.city,
    // required this.state,
    // required this.number,
  });

  dynamic gender;
  String name;
  Map<dynamic, dynamic> location;
  // num number;
  // String city;
  // String state;

  factory RandomApi.fromJson(Map<String, dynamic> json) {
    return RandomApi(
      name: json['name'],
      gender: json['gender'],
      location: json['location'],
      // city: json['city'],
      // state: json['state'],
      // number: json['number'],
    );
  }
}

List<RandomApi> fakeList = [];
