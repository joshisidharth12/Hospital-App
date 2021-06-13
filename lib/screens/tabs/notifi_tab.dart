import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/model/hospitalModel.dart';
import 'package:hospital_app/size_config.dart';

class NotificationTab extends StatefulWidget {
  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  final aptReference =
      FirebaseDatabase.instance.reference().child('Appointments');

  List<AppointmentModel> appointments = [];

  Future<void> getAppointments() {
    aptReference.once().then((DataSnapshot snap) {
      appointments.clear();
      print(snap.value);
      var data = snap.value;
      data.forEach((key, value) {
        AppointmentModel apt = new AppointmentModel(value['pdf'], value['name'],
            value['age'], value['type'], value['status'], value['timestamp'],value['hospName']);
        appointments.add(apt);
      });
      print("Appointments has ${appointments.length}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notification",
                style: TextStyle(
                    fontFamily: "Arial Bold",
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(30),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: getProportionateScreenHeight(20),),
              Container(
                child: Expanded(
                  child: ListView.builder(
                    itemCount: appointments.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NotificationTile(
                        hospName: appointments[index].hospName,
                        timeStamp: appointments[index].timestamp,
                        status: appointments[index].status,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  NotificationTile({Key key, this.hospName, this.timeStamp, this.status})
      : super(key: key);

  String hospName, timeStamp, status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(80),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: status == "PENDING" ? Colors.red : Colors.green,
              width: 2.5),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: status == "PENDING"
                    ? Colors.red.withOpacity(0.2)
                    : Colors.green.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 10)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hospName,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(timeStamp,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: status == "PENDING" ? Colors.red : Colors.green,
                    width: 2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: status == "PENDING"
                          ? Colors.red.withOpacity(0.2)
                          : Colors.green.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5)
                ]),
            child: Text(status,
                style: TextStyle(
                    fontSize: 15,
                    color: status == "PENDING" ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
