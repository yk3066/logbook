import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logbook/buttonWidget.dart';
import 'package:logbook/createsheets.dart';
import 'package:logbook/qrCode.dart';
import 'package:logbook/user.dart';
import 'package:page_transition/page_transition.dart';
import 'sheets_api.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.initlate();
  await UserSheetsApi.init1();
  await UserSheetsApi.init2();

  runApp (MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LogBook IIIT Dharwad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage()
    );
}
}

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: Text(
          'Powered by IIIT Dharwad',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: Colors.black87
          ),
          textAlign: TextAlign.center,
        ),
      ),
        appBar:AppBar(
        title: Text("Campus Entry LogBook"),
    backgroundColor: Color(0xff08356C),
    centerTitle: true,
    ),
    body:Center(
      child: SingleChildScrollView(
      padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonWidget(
                text: 'Check-In',
                onClicked: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  QRScanPage1()));}
            ),
           SizedBox(
             height: 40,
           ),
            ButtonWidget(
                text: 'Check-Out',
                onClicked: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  QRScanPage2()));}
            ),
            SizedBox(
              height: 40,
            ),
           ButtonWidget(text: 'Statistics',
               onClicked: () async{
                final int count1 = await UserSheetsApi.allRows1();
                final int count2 = await UserSheetsApi.allRows2();
                int count = count1 + await UserSheetsApi.allRowslate();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  StatsSplash(count1: count, count2 : count2)));
               }
                          ),

          ],
        ),
      ),
    )
    );
  }
}

class StatsSplash extends StatefulWidget {
  final int? count1;
  final int? count2;
  const StatsSplash({Key? key,this.count1, this.count2}) : super(key: key);

  @override
  State<StatsSplash> createState() => _StatsSplashState();
}

class _StatsSplashState extends State<StatsSplash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
        splash: Container(
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children :[
            Center(
              child: Image(
                image: AssetImage('images/logo.png'),
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(child: loadingCircle()),
          ],
        ),
        ),
        screenFunction: () async{
          return Statistics(count1: widget.count1, count2: widget.count2,);},
        splashIconSize: 7000.0,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        curve: Curves.decelerate ,
        backgroundColor: Colors.white
    );
  }
}



class Statistics extends StatefulWidget {
  final int? count1;
  final int? count2;

  Statistics({Key? key, this.count1, this.count2}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(0xff08356C),
        title: Text("LogBook"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Students \nback in campus\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            CircleAvatar(
              backgroundColor: Color(0xff08356C),
              child: Text(
                '${widget.count1}',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              radius: 27,
            ),
            Text(
              '\nTotal Students\n gone out today \n',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            CircleAvatar(
              backgroundColor: Color(0xff08356C),
              child: Text(
                  '${widget.count2}',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              radius: 27,
            ),


        ],
        ),
      ),
    );
  }
}
