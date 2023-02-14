import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/buttonWidget.dart';
import 'package:logbook/createsheets.dart';
import 'package:logbook/sheets_api.dart';
import 'package:logbook/user.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage1 extends StatefulWidget {
  const QRScanPage1({Key? key}) : super(key: key);

  @override
  State<QRScanPage1> createState() => _QRScanPage1State();
}

class _QRScanPage1State extends State<QRScanPage1> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async{
    super.reassemble();
    if (Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  @override
  Widget build(BuildContext context) {
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
    return SafeArea(
        child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQRView(context),
          Positioned(child: buildResult(),top: 25,),
          Positioned(
              bottom: 20,
              child: Column(
                children: [
                  Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
            ),
            child: IconButton(
              color: Color(0xff08356C),
                  icon: FutureBuilder<bool?>(
        future: controller?.getFlashStatus(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off);
          }
          else {
            return Container();
          }
        },
                  ),
                  onPressed: () async{
                    await controller?.toggleFlash();
                    setState((){

                    });
                  },
            ),
          ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary:Color(0xff08356C),
                        ),
                        child: Text('Save for Check-In',
                        style: TextStyle(
                          color: Color(0xff08356C),
                        ),
                        ),
                        onPressed: ()=>{
                          if(barcode!.code==null ){
                            Navigator.of(context).popUntil((route) => route.isFirst)
                          }
                          else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  UserFormWidget(
                                  data: barcode!.code,
                                  onSavedUser: (user) async {
                                    if( DateTime.now().hour>21  ) {
                                      await UserSheetsApi.insertlate([user.toJson()]);
                                    }
                                    else{
                                      await UserSheetsApi.insert1([user.toJson()]);
                                    }
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  } )))}
                        },
                      )
                  ),
                ],
              ))
        ],
      ),
    ));
  }
  Widget buildResult() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Text(
      barcode != null? '${barcode!.code}':'Scan',
      maxLines: 1,
      style: TextStyle(
        color: Color(0xff08356C),
      ),
    ),
  );
    Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderColor: Colors.white,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width*0.6,
      ),
    );

    void onQRViewCreated(QRViewController controller){
      setState(() => this.controller =controller);

      controller.scannedDataStream.listen((barcode)=> setState(() => this.barcode = barcode) );
    }

}

class QRScanPage2 extends StatefulWidget {
  const QRScanPage2({Key? key}) : super(key: key);

  @override
  State<QRScanPage2> createState() => _QRScanPage2State();
}

class _QRScanPage2State extends State<QRScanPage2> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async{
    super.reassemble();
    if (Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  @override
  Widget build(BuildContext context) {
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
    return SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              buildQRView(context),
              Positioned(child: buildResult(),top: 15,),
              Positioned(
                  bottom: 20,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          color: Color(0xff08356C),
                          icon: FutureBuilder<bool?>(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off);
                              }
                              else {
                                return Container();
                              }
                            },
                          ),
                          onPressed: () async{
                            await controller?.toggleFlash();
                            setState((){

                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Color(0xff08356C),
                            ),
                            child: Text('Save for Check-Out',
                              style: TextStyle(
                                color: Color(0xff08356C),
                              ),
                            ),
                            onPressed: ()=>{
                              if(barcode!.code==null ){
                                Navigator.of(context).popUntil((route) => route.isFirst)
                              }
                              else{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  UserFormWidget2(
                                      data: barcode!.code,
                                      onSavedUser: (user) async{
                                        await UserSheetsApi.insert2([user.toJson()]);
                                        Navigator.of(context).popUntil((route) => route.isFirst);

  },
  ),))}
                            },
                          )
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
  Widget buildResult() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Text(
      barcode != null? '${barcode!.code}':'Scan',
      maxLines: 10,
      style: TextStyle(
        color: Color(0xff08356C),
      ),
    ),
  );
  Widget buildQRView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderRadius: 10,
      borderColor: Colors.white,
      borderLength: 20,
      borderWidth: 10,
      cutOutSize: MediaQuery.of(context).size.width*0.6,
    ),
  );

  void onQRViewCreated(QRViewController controller){
    setState(() => this.controller =controller);

    controller.scannedDataStream.listen((barcode)=> setState(() => this.barcode = barcode) );
  }

}

