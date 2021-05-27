import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/size_config.dart';
import 'package:provider/provider.dart';

/*class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({
    Key key,
  }) : super(key: key);

  @override
  _DealOfTheDayState createState() => _DealOfTheDayState();
}*/

class DealOfTheDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final hospital = Provider.of<QuerySnapshot>(context);
    for(var doc in hospital.docs){
      print(doc.data());
    }

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Deal of the day",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "More",
                style: TextStyle(
                  color: Color(0xFF006AFF),
                  fontSize: getProportionateScreenHeight(16),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Container(
            height: 270,
            margin: EdgeInsets.only(bottom: 15),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dodProducts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 12, left: 12, bottom: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 10,
                            spreadRadius: 4,
                            offset: Offset(0, 6))
                      ]),
                  width: getProportionateScreenWidth(165),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          dodProducts[index]['iconPath'],
                          width: getProportionateScreenWidth(178),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFEEEEF0),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )),
                        height: getProportionateScreenHeight(154),
                      ),
                      Spacer(),
                      Text(
                        dodProducts[index]['name'],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(14),
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${dodProducts[index]['price']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: Color(0xFFFFC000),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: getProportionateScreenHeight(14),
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(dodProducts[index]['rate'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                      )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
