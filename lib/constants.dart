import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF090F47);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF2D9CDB), Color(0xFF2F80ED)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 260);


List<Map> notifications=[
  {
    'name': 'Notification 1'
  },
  {
    'name': 'Notification 2'
  },
  {
    'name': 'Notification 3'
  },
  {
    'name': 'Notification 4'
  },
];

List<Map> categories = [
  {
    'name': 'Dental',
    'iconPath': 'assets/images/teeth.png',
    'c1': Color(0xFFFF9598),
    'c2': Color(0xFFFF70A7),
  },
  {
    'name': 'Wellness',
    'iconPath': 'assets/images/leaf.png',
    'c1': Color(0xFF19E5A5),
    'c2': Color(0xFF15BD92)
  },
  {
    'name': 'Homeo',
    'iconPath': 'assets/images/healbag.png',
    'c1': Color(0xFFFFC06F),
    'c2':  Color(0xFFFF793A)

  },
  {
    'name': 'Eye Care',
    'iconPath': 'assets/images/eye.png',
    'c1': Color(0xFF4DB7FF),
    'c2': Color(0xFF3E7DFF),

  },
  {
    'name': 'Skin & Hair',
    'iconPath': 'assets/images/bubbles.png',
    'c1': Color(0xFF828282),
    'c2': Color(0xFF090F47)
  },
];

List<Map> dodProducts=[
  {
    'name': 'Accu-check Activ\nTest Strip',
    'price': '112',
    'iconPath': 'assets/images/accuchek.png',
    'rate': '4.2',
  },
  {
    'name': 'Omron HEM-8712\nBP Monitor',
    'price': '150',
    'iconPath': 'assets/images/omron.png',
    'rate': '4.0',
  },
];


List<Map> brandslist =[
  {
    'name': 'Himalaya\nWellness',
    'iconPath': 'assets/images/himalaya.png',
  },

  {
    'name': 'Accu-Chek',
    'iconPath': 'assets/images/accu-chek.png',
  },

  {
    'name': 'VLCC',
    'iconPath': 'assets/images/vlcc.png',
  },

  {
    'name': 'Proteinx',
    'iconPath': 'assets/images/proteinx.png',
  },
];




