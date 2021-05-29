class HospitalModel{
  int beds;
  String image;
  String location;
  String name;
  List<String> speciality;

  HospitalModel(
  {this.beds, this.image, this.location, this.name, this.speciality});

  /*HospitalModel.fromJson(Map<String, dynamic> json) {
    bed = json['bed'];
    image = json['image'];
    location = json['location'];
    name = json['name'];
    speciality = json['speciality'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bed'] = this.bed;
    data['image'] = this.image;
    data['location'] = this.location;
    data['name'] = this.name;
    data['speciality'] = this.speciality;
    return data;
  }*/
}