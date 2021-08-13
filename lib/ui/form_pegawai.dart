

import 'package:flutter/material.dart';
import 'package:sqllite/db/db_helper.dart';
import 'package:sqllite/model/model_pegawai.dart';

class FormPegawai extends StatefulWidget {
  final Pegawai pegawai;

  const FormPegawai({Key key, this.pegawai}) : super(key: key);

  @override
  _FormPegawaiState createState() => _FormPegawaiState();
}

class _FormPegawaiState extends State<FormPegawai> {
  DbHelper db = DbHelper();
  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController mobileNo;
  TextEditingController email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = TextEditingController(
        text: widget.pegawai == null ? '' : widget.pegawai.firstName);
    lastName = TextEditingController(
        text: widget.pegawai == null ? '' : widget.pegawai.lastName);
    mobileNo = TextEditingController(
        text: widget.pegawai == null ? '' : widget.pegawai.mobileNo);
    email = TextEditingController(
        text: widget.pegawai == null ? '' : widget.pegawai.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Pegawai"),
        backgroundColor: Colors.green[300],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: firstName,
            decoration: InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          TextField(
            controller: lastName,
            decoration: InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          TextField(
            controller: mobileNo,
            decoration: InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          MaterialButton(
            onPressed: () {
              upsertPegawai();
            },
            color: Colors.green[300],
            child: (widget.pegawai == null)
                ? Text("add", style: TextStyle(color: Colors.white))
                : Text(
                    "update",
                    style: TextStyle(color: Colors.white),
                  ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }

  Future<void> upsertPegawai() async {
    if(widget.pegawai != null){
      //update
      await db.updatePegawai(Pegawai.fromMap({
        'id': widget.pegawai.id,
        'firstName': firstName.text,
        'lastName': lastName.text,
        'mobileNo': mobileNo.text,
        'email': email.text
      }));
      Navigator.pop(context, 'update');
    }else{
      //insert
      await db.savePegawai(Pegawai(
        firstName: firstName.text,
        lastName: lastName.text,
        mobileNo: mobileNo.text,
        email: email.text
      ));
      Navigator.pop(context, 'save');
    }
  }
}
