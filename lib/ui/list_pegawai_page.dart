

import 'package:flutter/material.dart';
import 'package:sqllite/db/db_helper.dart';
import 'package:sqllite/model/model_pegawai.dart';
import 'package:sqllite/ui/detail_pegawai.dart';
import 'package:sqllite/ui/form_pegawai.dart';

class ListPegawaiPage extends StatefulWidget {
  const ListPegawaiPage({Key key}) : super(key: key);

  @override
  _ListPegawaiPageState createState() => _ListPegawaiPageState();
}

class _ListPegawaiPageState extends State<ListPegawaiPage> {
  List<Pegawai> listPegawai = [];
  DbHelper db = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pegawai"),
        backgroundColor: Colors.green[300],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Pegawai pegawai = listPegawai[index];
          return ListTile(
            onTap: () {
              _openFormEdit(pegawai);
            },
            contentPadding: EdgeInsets.all(16),
            title: Text(
              "${pegawai.firstName} ${pegawai.lastName}",
              style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepOrangeAccent),
            ),
            subtitle: Text("${pegawai.email}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                AlertDialog hapus = AlertDialog(
                  title: Text("Information"),
                  content: Container(
                    height: 100,
                    child: Column(
                      children: [
                        Text(
                            "Apakah anda yakin ingin hapus data ${pegawai.email}?"),
                      ],
                    ),
                  ),
                  actions: [
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () {
                        //delete
                        _deletePegawai(pegawai, index);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                );
                showDialog(context: context, builder: (context) => hapus);
              },
            ),
            leading: IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {
                  //detail
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(pegawai)));
                }),
          );
        },
        itemCount: listPegawai.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFormCreate();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[300],
      ),
    );
  }

  //method yang pertama kali dijalankan untuk mendapatkan daftar pegawai
  Future<void> _getAllPegawai() async {
    var list = await db.getAllPegawai();
    setState(() {
      listPegawai.clear();
      list.forEach((pegawai) {
        listPegawai.add(Pegawai.fromMap(pegawai));
      });
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormPegawai()));
    if (result == 'save') {
      await _getAllPegawai();
    }
  }

  Future<void> _deletePegawai(Pegawai pegawai, int position) async {
    await db.deletePegawai(pegawai.id);

    setState(() {
      listPegawai.removeAt(position);
    });
  }

  Future<void> _openFormEdit(Pegawai pegawai) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormPegawai(pegawai: pegawai)));
    if (result == 'update') {
      await _getAllPegawai();
    }
  }
}
