import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/size_config.dart';
class QRScanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  String pdfLink = "";

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "QR Code Scanner",
            style: TextStyle(fontSize: getProportionateScreenHeight(18),
            color: Colors.black,
            fontFamily: 'Overpass Bold'),
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
            children: <Widget>[
              Text(
                'Scan Result',
                style: TextStyle(
                  fontSize: 16,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '$pdfLink',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(72)),
              DefaultButton(
                text: 'Scan',
                onPressed: () => scanQRCode(),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              pdfLink == "" ? SizedBox():DefaultButton(
                text: "View PDF",
                onPressed: (){
                  print("View PDF");
                },
              )

            ],
          ),
        ),
      );

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
}
