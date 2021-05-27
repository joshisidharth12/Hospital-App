import 'package:flutter/material.dart';
import 'package:hospital_app/size_config.dart';

class CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                CartItems(),
                CartItems(),
                CartItems(),
                CartItems(),
                CartItems(),
                CartItems(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(20),
      height: getProportionateScreenHeight(20),
      decoration: BoxDecoration(
        color: Colors.white,
          border: Border.all(color: Colors.black,width: 3),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(23),
              bottomLeft: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            blurRadius: 30,
            spreadRadius: 1,
            offset: Offset(0,6)
          )
        ]
      ),
    );
  }
}
