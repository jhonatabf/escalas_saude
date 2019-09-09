import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String tituloApp = "Minhas escalas";
String sloganApp = "Sua solução para verificar a condição do paciente";
final titulosEscalas = ['Braden', 'MEWS'];
final paginas = ['braden', 'mews'];
final coresincone = [Colors.orange, Colors.cyan];
final subtitulosEscalas = [
  'Risco para Úlcera por Pressão',
  'National Early Warning Score'
];
int _selectedIndex = 0;

const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const List<Widget> _widgetOptions = <Widget>[
  Text(
    'Index 0: Escalas',
    style: optionStyle,
  ),
  Text(
    'Index 1: Hospitais',
    style: optionStyle,
  ),
  Text(
    'Index 2: Pacientes',
    style: optionStyle,
  ),
];

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MaterialApp(
    title: tituloApp,
    debugShowCheckedModeBanner: false,
    home: Braden(title: 'Escala Braden'),
  ));
}

class Braden extends StatefulWidget {
  Braden({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BradenState createState() => _BradenState();
}

class _BradenState extends State<Braden> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget base() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(14, 20, 12, 5),
          child: Text(
            "Braden",
            style: TextStyle(color: Colors.grey[600]),
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
//
      ],

    );
  }
}

