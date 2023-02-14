class UserFields {
  static final String data = 'Student';
  static final String date = 'Date';
  static final String registration = 'Registration';
  static final String intime = 'In-time';
  static final String outtime = 'Out-time';


  static List<String> getFields() => [ registration,intime, outtime,data,date,];
}

class User {
  final String? registraion;
  final String? data;
  final String? date;
  final String? intime;
  final String? outtime;

  const User({
    this.registraion,
    this.data,
    this.date,
    this.intime,
    this.outtime
  });

  static User fromJson(Map<String, dynamic> json) => User(
      registraion : json[UserFields.registration],
      intime: json[UserFields.intime],
      outtime : json[UserFields.outtime],
      data: json[UserFields.data],
      date: json[UserFields.date],

  );

  Map<String, dynamic> toJson() =>{
    UserFields.registration: registraion,
    UserFields.intime : intime,
    UserFields.outtime : outtime,
    UserFields.data : data,
    UserFields.date : date,
  };
}




