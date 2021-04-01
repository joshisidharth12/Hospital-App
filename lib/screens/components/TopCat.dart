import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/size_config.dart';

class TopCat extends StatelessWidget {
  const TopCat({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Top Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(14),
          ),
          Container(
            height: 135,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 10,bottom: 15,left: 5),
                  // padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 10,
                            spreadRadius: 4,
                            offset: Offset(0, 6))
                      ]),
                  width: getProportionateScreenWidth(64),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              categories[index]['c1'],
                              categories[index]['c2']
                            ],
                          ),
                        ),
                        child: Image.asset(
                          categories[index]['iconPath'],
                          width: getProportionateScreenWidth(16),
                        ),
                      ),
                      Spacer(),
                      Text(
                        categories[index]['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize:
                            getProportionateScreenWidth(12)),
                      ),
                      Spacer(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}