class DoctorModel{
  String d_name,department,speciality;
  bool status;

  DoctorModel(this.d_name, this.department, this.speciality, this.status);
}

class AppointmentModel{
  String pdf,name,age,type,status,timestamp,hospName;
  AppointmentModel(
      this.pdf, this.name, this.age,
      this.type, this.status, this.timestamp,this.hospName);
}