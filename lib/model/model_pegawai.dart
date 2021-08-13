class Pegawai{
  int id;
  String firstName;
  String lastName;
  String mobileNo;
  String email;


  Pegawai({this.id, this.firstName, this.lastName, this.email, this.mobileNo});

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic> ();

    if(id != null){
      map['id'] = id;
    }
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['mobileNo'] = mobileNo;
    map['email'] = email;

    return map;
  }

  Pegawai.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.firstName = map['firstName'];
    this.lastName = map['lastName'];
    this.mobileNo = map['mobileNo'];
    this.email = map['email'];
  }
}

