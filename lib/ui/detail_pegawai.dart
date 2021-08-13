import 'package:flutter/material.dart';
import 'package:sqllite/model/model_pegawai.dart';

class DetailPage extends StatelessWidget {
  final Pegawai pegawai;

  const DetailPage(this.pegawai, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("First Name : ${pegawai.firstName}"),
            Text("Last Name : ${pegawai.lastName}"),
            Text("mobileNo : ${pegawai.mobileNo}"),
            Text("Email : ${pegawai.email}"),
          ],
        ),
      ),
    );
  }
}
