import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/size_config.dart';

class NotificationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
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
              Container(
                child: Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Text(notifications[index]['name'],style: TextStyle(fontSize: getProportionateScreenWidth(15)),),
                            Container(
                              color: Color(0xFFC4C4C4).withOpacity(0.46),
                              height: getProportionateScreenHeight(20),
                            ),
                            SizedBox(height: getProportionateScreenHeight(5),),
                            Container(
                              color: Color(0xFFC4C4C4).withOpacity(0.23),
                              height: getProportionateScreenHeight(76),
                            )
                          ],
                        ),
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
