class Usersmodel {
  int? id;
  String? name;
  String? username;
  String? email;
  late Map<String, dynamic> address;
  String? phone;
  String? website;
  late Map<String, dynamic> company;

  Usersmodel(
    int? id,
    String? name,
    String username,
    String email,
    Map<String, dynamic> address,
    String? phone,
    String website,
    Map<String, dynamic> company,
  ) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.email = email;
    this.address = address;
    this.phone = phone;
    this.website = website;
    this.company = company;
  }
  Usersmodel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    address = json["address"];
    phone = json["phone"];
    website = json["website"];
    company = json["company"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["username"] = username;
    data["email"] = email;
    data["address"] = address;
    data["phone"] = phone;
    data["website"] = website;
    data["company"] = company;
    return data;
  }
}
