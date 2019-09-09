import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String tituloApp = "Minhas escalas";

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MaterialApp(
    title: tituloApp,
    debugShowCheckedModeBanner: false,
    home: Pacientes(title: 'Cadastro de Pacientes'),
  ));
}

class Pacientes extends StatefulWidget {
  Pacientes({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PacientesState createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  void _onItemTapped(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.grey[700]),
        ),
        iconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
      ),
      body: base(),
    );
  }

  Widget base() {
    return Column(
      children: <Widget>[
      Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(14, 20, 12, 5),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome do paciente',
              focusColor: Colors.green,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(14, 20, 12, 5),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                ),
              ),
              labelText: 'Nome do hospital',
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(14, 20, 12, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(""),
              ),
              RaisedButton(
                color: Colors.green,
                elevation: 0,
                child: Text("Salvar Paciente",
                    style: TextStyle(color: Colors.white)),
                onPressed: () {},
              )
            ],
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Color(0xFFFFDDDDDD),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
