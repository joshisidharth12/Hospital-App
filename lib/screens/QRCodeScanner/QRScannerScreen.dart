import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/CustomInput.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/QRCodeScanner/pdfViewerpage.dart';
import 'package:hospital_app/services/database.dart';
import 'package:hospital_app/size_config.dart';
import 'package:intl/intl.dart';

class QRScanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  String pdfLink = "";

  String _name, _age, _emergencyNo, _aptid,date_time,_hospitalName;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bookAppointment() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _aptid = DatabaseService().createCryptoRandomString();
      DatabaseService().documentVictimFileUpload(
          _name, pdfLink, _emergencyNo, _age, "PENDING", _aptid, date_time,_hospitalName);
      Fluttertoast.showToast(
          msg: "Appointment has been booked",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.green,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    date_time = DateFormat('E-M-y '+':'+'H-m').format(now);
    print(date_time);
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "QR Code Scanner",
          style: GoogleFonts.overpass(
              fontSize: getProportionateScreenHeight(18),
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              // Put icon of your preference.
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pdfLink == "" || pdfLink == "-1"
                ? DefaultButton(
              text: 'Scan',
              onPressed: () => scanQRCode(),
            )
                : SizedBox(
              height: 1,
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            pdfLink == "" || pdfLink == "-1"
                ? SizedBox(
              height: 1,
            )
                : Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInput(
                      hintText: "Name",
                      iconImage: "assets/images/profile.png",
                      onSaved: (value) => _name = value,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    CustomInput(
                      hintText: "Age",
                      iconImage: "assets/images/ageIcon.png",
                      keyBoardType: TextInputType.number,
                      onSaved: (value) => _age = value,
                      count: 2,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    CustomInput(
                      hintText: "Emergency Number",
                      iconImage: "assets/images/smartphone.png",
                      keyBoardType: TextInputType.number,
                      onSaved: (value) => _emergencyNo = value,
                      count: 10,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    CustomInput(
                      hintText: "Hospital Name",
                      iconImage: "assets/images/smartphone.png",
                      keyBoardType: TextInputType.number,
                      onSaved: (value) => _hospitalName = value,
                      count: 10,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    DefaultButton(
                      text: "Book Appointment",
                      onPressed: () async {
                        bookAppointment();
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 1,
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                        Text(" OR "),
                        SizedBox(
                          width: 30,
                          height: 1,
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    DefaultButton(
                      text: "View PDF",
                      onPressed: () async {
                        final file =
                        await DatabaseService.loadNetwork(pdfLink);
                        openPdf(context, file);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.pdfLink = qrCode;
      });
    } on PlatformException {
      pdfLink = 'Failed to get platform version.';
    }
  }

  void openPdf(BuildContext context, File file) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(
                  file: file,
                )));
  }
}
