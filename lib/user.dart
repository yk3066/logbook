class UserFields1 {
  static final String data = 'Student';
  static final String date = 'Date';
  static final String registration = 'Registration';
  static final String intime = 'In-time';


  static List<String> getFields() => [ registration,data,date, intime];
}

class User1 {
  final String registraion;
  final String? data;
  final String? date;
  final String? intime;

  const User1({
    required this.registraion,
    this.data,
    this.date,
    this.intime,
  });

  static User1 fromJson(Map<String, dynamic> json) => User1(
      registraion : json[UserFields1.registration],
      data: json[UserFields1.data],
      date: json[UserFields1.date],
      intime: json[UserFields1.intime]
  );

  Map<String, dynamic> toJson() =>{
    UserFields1.registration: registraion,
    UserFields1.data : data,
    UserFields1.date : date,
    UserFields1.intime : intime,
  };
}




class UserFields2 {
  static final String data = 'Student';
  static final String date = 'Date';
  static final String registration = 'Registration';
  static final String outtime = 'Out-time';


static List<String> getFields() => [ registration,data,date, outtime];
}

class User2 {
  final String registraion;
  final String? data;
  final String? date;
  final String? outtime;

  const User2({
   required this.registraion,
    this.data,
    this.date,
    this.outtime,
});

  static User2 fromJson(Map<String, dynamic> json) => User2(
    registraion : json[UserFields2.registration],
    data: json[UserFields2.data],
    date: json[UserFields2.date],
    outtime: json[UserFields2.outtime]
  );

  Map<String, dynamic> toJson() =>{
    UserFields2.registration: registraion,
    UserFields2.data : data,
    UserFields2.date : date,
    UserFields2.outtime : outtime,
  };
}


