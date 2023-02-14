import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';
import 'package:logbook/user.dart';

class UserSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "campus-entry-377206",
  "private_key_id": "fe109be75ad87f1bb5a8af92197d7de5a01411b5",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCxyL6NgRQXY0IT\nwsCbz3Li2Ar1OlvHvhGH6hmOnALlL61B8IA1Enw5A/ubTjXoX2QLD1ELJjSTuBLm\nA5PxNkxAda69BFxOFw2r5hSXvbR2BZAjTq88Xl9K52yQWipLkGIQevvdsZzmpuuA\nIG/mVz9Rnxe5XHigNrAb/GgkowtQqcbOjygL+9FzAfa28qwnUTiJkqPiZ6LLw8pf\ncsqa62gFTji4iT9Fu+2SPrKZLvhwVRHRlBbGKxuAwxPkehbqijQSTzvY4Am7vrc8\nzhoeY0/r6jcVlZE68DpV9d5DZWKXEXBfHivgjU9eO581Yk4Dp6Repw+Hsozbknu9\nnU96L9A7AgMBAAECggEAFCJjg5wYPekrB8OOfmGOpdEziyqk+qifIfuUZw8VJtvw\n7R8DLhTeBl5Z8EX5xfYzsCr3vIxYTQMo+hgdTlFIw84a0Dj+XoZZhoZ5U5FpBCrE\nybLfbAtWEyIa102sLOr4/YZ9dXyS2UO94mtfW5YK9j/5zFou0Ro7H1hFJSJlUCj8\nVxNjK2XRsbqaLD50zKJPana45vhym0GdCsqyI+4rCfn2fnhb1eZqwTDzPgbxXi1F\nHO1i+NEcNLCjy09jQUmndignlCDQma1alIjhTNrCCV31+uTSpIDZ4zH6E6Fu4If5\nX/QeV7b7CJBOLvMYA0tW7KRz9B2TM7RSD9tEFrIptQKBgQDmySro1dkhIjHeEGjZ\nZoR9jPNRmw15pKCLYFfr3aCmCk7TAOUI94ZCVONN7lp5AFyXHNQXm+WpD3ug4Ngm\nZAcx4ZPL51EQd+gH2iBrjIveB9kxvs0sjQ2u5KTeFg3TCfJrLZRz76r8PmaQnw6Y\ndBywsfw1AIrz3kbxPvqRYdCVtQKBgQDFNS1Z8aFmmDvs1yY9XM+9rd5FyUZGHN5y\n3Pe23PeldPnZ24dpsb+d/z4eQQ/a6966MpvRoS7QcaEcIeR0J8RxAAbH9hkHVPt7\n8hDYIpUMFG9RzLcbLD5zUfT/UR7itIhXt2ShU4AwPxNOImRqcUyMshY1zQ5Wy/o/\nU4n/OMeELwKBgAx65G8i4VMBXmD70i+vc4q2jJHlKJ1jYasn0plWqtFPzWNrsPcD\nK6d6n7AfK5VPh7JERNPiAlFaHP1eK1IoJptz72IfaCrT0SBbk1U9jHK9Sel+v+mg\n1xSWGLRJzQWUjB9vn4+FbmGlnjZD464q2UJU3aagGOOHKZ7yIOqrt3PhAoGAEPTQ\nkHJBQXQHewbIx+/qANIpUXDL9Q1YZyHuvq9jL7vOG9hPXVwmMKyYp7tKZLVxMitV\n0IF+Z/fNNYEIhqBAuMKa0qirYEEDWpXmst7OV/qN08e5WsHEIOBEI4vTDwUc0AX5\nxhFK7VsPCuHUJn7VaSeK11dpSzdArh89t08ngIsCgYEA4hM1cHgUF4YqsdAz+V2y\nrJ0tnOK6A9LJQtJQ3QYiwPnlvSojBDuaZJup97CAvJlb/SF+4kefeyePL7Ae8Hci\ntE/qsU2hr/WiTzgoiKimSJ4QpGXd2cuuEKGxod+i7kTlaQ8LounFTRurYErKiQRq\nmJOFU+43DZkO9PfnN8VuzMs=\n-----END PRIVATE KEY-----\n",
  "client_email": "campus-entry@campus-entry-377206.iam.gserviceaccount.com",
  "client_id": "113858324153926009547",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/campus-entry%40campus-entry-377206.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1T-n-ntLVjHt-uXrSXl-ov5BnDz1hhDMOXdC-ULvsG5w';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet1;
  static Worksheet? _userSheet2;
  static Worksheet? _userSheetLate;
  static bool loading =true;

  static Future init1() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet1 = await _getWorkSheet(spreadsheet, title: 'In ${DateFormat('dd-MM-yy').format(DateTime.now())}');

      final firstRow = UserFields1.getFields();
      _userSheet1!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }

  }
  static Future init2() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet2 = await _getWorkSheet(spreadsheet, title: 'Out ${DateFormat('dd-MM-yy').format(DateTime.now())}');

      final firstRow = UserFields2.getFields();
      _userSheet2!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future initlate() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheetLate = await _getWorkSheet(spreadsheet, title: 'Late ${DateFormat('dd-MM-yy').format(DateTime.now())}');

      final firstRow = UserFields1.getFields();
      _userSheetLate!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future<int> getRowCount1() async {
    if (_userSheet1 == null) return 0;

    final lastRow = await _userSheet1!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<int> allRows1() async {
    final lastRow = await _userSheet1!.values.allRows();

    return lastRow.length-1 ;
    loading = false;
  }

  static Future<User1?> getById1(String reg) async{
    if(_userSheet1 == null) return null;

    final json = await _userSheet1!.values.map.rowByKey(reg, fromColumn: 1);
    return json == null ? null : User1.fromJson(json);
  }


  static Future insert1(List<Map<String, dynamic>> rowList) async {
    if (_userSheet1 == null) return ;

    _userSheet1!.values.map.appendRows(rowList);
  }

  static Future<bool> update1(
      String registration,
      Map<String, dynamic> user,) async{
    if(_userSheet1==null) return false;

    return _userSheet1!.values.map.insertRowByKey(registration, user);
  }
  static Future<int> getRowCount2() async {
    if (_userSheet2 == null) return 0;

    final lastRow = await _userSheet2!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<int> allRows2() async {
    final lastRow = await _userSheet2!.values.allRows();

    return lastRow.length -1 ;
    loading = false;
  }

  static Future<User2?> getById2(String reg) async{
    if(_userSheet2 == null) return null;

    final json = await _userSheet2!.values.map.rowByKey(reg, fromColumn: 1);
    return json == null ? null : User2.fromJson(json);
  }


  static Future insert2(List<Map<String, dynamic>> rowList) async {
    if (_userSheet2 == null) return ;

    _userSheet2!.values.map.appendRows(rowList);
  }

  static Future<bool> update2(
      String registration,
      Map<String, dynamic> user,) async{
    if(_userSheet2==null) return false;

    return _userSheet2!.values.map.insertRowByKey(registration, user);
  }

  static Future<int> getRowCountlate() async {
    if (_userSheetLate == null) return 0;

    final lastRow = await _userSheetLate!.values.lastRow(fromColumn: 3,);
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<int> allRowslate() async {
    final lastRow = await _userSheetLate!.values.allRows();

    return lastRow.length-1 ;
    loading = false;
  }

  static Future<User1?> getByIdlate(String reg) async{
    if(_userSheetLate== null) return null;

    final json = await _userSheetLate!.values.map.rowByKey(reg, fromColumn: 1);
    return json == null ? null : User1.fromJson(json);
  }


  static Future insertlate(List<Map<String, dynamic>> rowList) async {
    if (_userSheetLate == null) return ;

    _userSheetLate!.values.map.appendRows(rowList);
  }

  static Future<bool> updatelate(
      String registration,
      Map<String, dynamic> user,) async{
    if(_userSheet1==null) return false;

    return _userSheetLate!.values.map.insertRowByKey(registration, user);
  }

}