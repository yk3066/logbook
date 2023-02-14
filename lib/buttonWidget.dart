import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/createsheets.dart';
import 'package:logbook/qrCode.dart';
import 'package:logbook/user.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

   ButtonWidget({
    Key? key,
    required this.text,

    required this.onClicked,
  }): super (key: key);



  @override
  Widget build (BuildContext context) => ElevatedButton(
  style: ElevatedButton.styleFrom(
    primary: Color(0xff08356C),
  minimumSize: Size.fromHeight(50),
  shape: StadiumBorder(),
  ),
  child: FittedBox(
  child: Text(
  text,
  style: TextStyle(fontSize: 20, color: Colors.white),
  ), ),// Text// FittedBox
  onPressed: onClicked,
  );
}// ElevatedButton

class UserFormWidget extends StatefulWidget {
   final ValueChanged<User> onSavedUser;
   final String? data;


   UserFormWidget({
    Key?key,
    required this.onSavedUser,
    this.data,
}) : super(key:key);

   late final splitted = data?.split(',');

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildSubmit(widget.splitted),
        ),
        appBar:AppBar(
          title: Text("LogBook"),
          backgroundColor: Color(0xff08356C),
          centerTitle: true,

        ),
        body:Center(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Column(
            children: [
              buildRegistraion(widget.splitted),
              SizedBox(
                height: 17,
              ),
              buildName(widget.splitted),
              SizedBox(
                height: 17,
              ),
            ],
          ),
          ),
        )
      ),
    );

  }
  Widget buildRegistraion(List<String>?data)=> Text(
    "${data!.elementAt(3)}"
  );

  Widget buildName(List<String>?data)=> Text(
      "${data!.elementAt(0)}"
  );

  Widget buildSubmit(List<String>?data)=> ButtonWidget(
      text: "Check-In",
      onClicked: () {
        final user = User(

            registraion: data!.elementAt(3),
            outtime: DateFormat('HH:mm').format(DateTime.now()),
            intime: null,
            data : widget.data,
            date : DateFormat('dd-MM-yyyy').format(DateTime.now()),
            );
        widget.onSavedUser(user);

      });
}



class loadingCircle extends StatelessWidget {
  const loadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(
        color: Color(0xff08356C),
      ),
    );
  }
}
