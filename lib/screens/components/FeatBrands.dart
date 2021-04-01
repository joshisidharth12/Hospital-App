import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/size_config.dart';


class FeatBrands extends StatelessWidget {
  const FeatBrands({
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
                "Featured Brands",
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
            height: getProportionateScreenHeight(170),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brandslist.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10,left: 10),
                      padding: EdgeInsets.all(15),
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
                      child: Column(
                        children: [
                          Container(
                            width: getProportionateScreenWidth(80),
                            height: getProportionateScreenHeight(80),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                getProportionateScreenWidth(2)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Image.asset(
                              brandslist[index]['iconPath'],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20),),
                    Text(
                      brandslist[index]['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13),
                          color: Colors.black,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
