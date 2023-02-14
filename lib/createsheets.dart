import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/buttonWidget.dart';
import 'package:logbook/sheets_api.dart';
import 'package:logbook/user.dart';

class ModifySheets extends StatefulWidget {
  final ValueChanged<User> onSavedUser;
  final String ? data;

  ModifySheets({Key? key,
    required this.onSavedUser,
    this.data,}) : super(key: key);
  late final splitted = data?.split(',');
  @override

  State<ModifySheets> createState() => _ModifySheetsState();
}

class _ModifySheetsState extends State<ModifySheets> {
  User?user;
  @override
  void initState(){
    super.initState();

    getUsers();

  }

  Future getUsers() async{
    final user = await UserSheetsApi.getById1(widget.splitted!.elementAt(3));

  }

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

  Widget buildSubmit(List<String>? data)=> ButtonWidget(
      text: "Check-In",
      onClicked: () {
        final user = User(
          registraion: data!.elementAt(3),
          intime: DateFormat('HH:mm').format(DateTime.now()),

        );
       widget.onSavedUser(user);


      });
}

class ModifySheetsout extends StatefulWidget {
  final ValueChanged<User> onSavedUser;
  final String ? data;

  ModifySheetsout({Key? key,
    required this.onSavedUser,
    this.data,}) : super(key: key);
  late final splitted = data?.split(',');
  @override

  State<ModifySheetsout> createState() => _ModifySheetsoutState();
}

class _ModifySheetsoutState extends State<ModifySheetsout> {
  User?user;
  @override
  void initState(){
    super.initState();

    getUsers();

  }

  Future getUsers() async{
    final user = await UserSheetsApi.getById1(widget.splitted!.elementAt(3));
    if( user == null){

    }
  }

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

  Widget buildSubmit(List<String>? data)=> ButtonWidget(
      text: "Check-Out",
      onClicked: () {
        final user = User(
          registraion: data!.elementAt(3),
          outtime: DateFormat('HH:mm').format(DateTime.now()),
          intime: '',
          data : widget.data,
          date : DateFormat('dd-MM-yyyy').format(DateTime.now()),

        );
        widget.onSavedUser(user);


      });
}

