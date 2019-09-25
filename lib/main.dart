import 'dart:convert';
import 'dart:io';

import 'package:escalas_saude/cadastros/pacientes.dart';
import 'package:escalas_saude/escalas/braden.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './escalas/braden.dart';
import 'package:path_provider/path_provider.dart';
import 'package:date_format/date_format.dart';

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
String tituloPagina = "Minhas Escalas";

const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MaterialApp(
    title: tituloApp,
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class MenuPacientes {
  static const String nova = 'Avaliar';
  static const String editar = 'Editar';
  static const String apagar = 'Apagar';

  static const List<String> escolhas = <String>[
    nova,
    editar,
    apagar,
  ];
}

class _HomeState extends State<Home> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pacienteController = TextEditingController();
  List _pacienteList = [];

  @override
  void initState() {
    super.initState();
    _readData("pacientes").then((data) {
      setState(() {
        _pacienteList = json.decode(data);
      });
    });
  }

  void _addPaciente() {
    setState(() {
      Map<String, dynamic> newPaciente = Map();
      if (_pacienteController.text != "") {
        newPaciente["title"] = _pacienteController.text;
        _pacienteController.text = "";
        final dataFormatada = formatDate(
            new DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
        newPaciente["data"] = "Cadastrado em: " + dataFormatada;
        _pacienteList.add(newPaciente);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          tituloApp,
          style: TextStyle(color: Colors.grey[700]),
        ),
        iconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
      ),
      body: paginas(_selectedIndex),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(tituloApp),
              accountEmail: Text(sloganApp),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "Ms",
                  style: TextStyle(fontSize: 40.0, color: Colors.green),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.green,
                size: 40.0,
              ),
              title: Text("Sobre o Aplicativo",
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold)),
              subtitle: Text(
                "O que podemos ajudar?",
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.developer_mode,
                color: Colors.green,
                size: 40.0,
              ),
              title: Text("Sobre o Desenvolvedor",
                  style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold)),
              subtitle: Text(
                "O que podemos fazer por você?",
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_calendar),
            title: Text('Pacientes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Escalas'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            switch (_selectedIndex) {
              case 0:
                tituloPagina = "Meus Pacientes";
                paginas(_selectedIndex);
                break;
              case 1:
                tituloPagina = "Minhas Escalas";
                paginas(_selectedIndex);
                break;
            }
          });
        },
      ),
    );
  }

  Widget paginas(index) {
    Widget home;
    switch (index) {
      case 0:
        home = paciente();
        break;
      case 1:
        home = base();
        break;
    }
    return home;
  }

  Widget base() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(14, 20, 12, 5),
          child: Text(
            tituloPagina,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: titulosEscalas.length,
            itemBuilder: (context, index) {
              int item = index;
              return Container(
//                decoration: const BoxDecoration(
//                  border: Border(
//                    bottom: BorderSide(
//                      width: 1.0,
//                      color: Color(0xFFFFDDDDDD),
//                    ),
//                  ),
//                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Braden(title: 'Escala Braden')),
                    );
                  },
                  leading: Icon(
                    Icons.content_copy,
                    color: coresincone[index],
                    size: 30.0,
                  ),
                  title: Text(titulosEscalas[index].toString(),
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    subtitulosEscalas[index].toString(),
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget paciente() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(14, 20, 12, 5),
          child: Text(
            "Cadastrar novo paciente",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(14, 20, 12, 5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                  margin: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  height: 50,
                  child: TextField(
                    controller: _pacienteController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                      focusColor: Colors.green,
                    ),
                  ),
                ),
              ),
              Container(
                height: 44,
                child: FlatButton(
                  color: Colors.green,
                  child: Text("Salvar", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _addPaciente();
                    _saveData("pacientes");
                  },
                ),
              ),
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
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(14, 20, 12, 5),
          child: Text(
            "Meus Pacientes",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _pacienteList.length,
            itemBuilder: (context, index) {
              
              int item = index;
              return Container(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      _pacienteList[index]['title'].substring(0, 2),
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  title: Text(_pacienteList[index]['title'].toString(),
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    _pacienteList[index]['data'].toString(),
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                              print("ola");
                              _MenuPaciente();
                      }),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _MenuPaciente() async{
    await showMenu(
      context: context,
      position: RelativeRect.fill,
      items: MenuPacientes.escolhas.map((String escolha) {
          return PopupMenuItem<String>(
            value: escolha,
            child: Text(escolha.toString()),
          );
        }).toList(),

      elevation: 8.0,
    );
  }


  Widget menuPaciente() {
      return new PopupMenuButton<String>(
      onSelected: acaoMenuPaciente,
      itemBuilder: (BuildContext context) {
        print("oi");
        return MenuPacientes.escolhas.map((String escolha) {
          return PopupMenuItem<String>(
            value: escolha,
            child: Text(escolha.toString()),
          );
        }).toList();
      },
    );
  }

  void acaoMenuPaciente(String selecao) {
    print("Teste");
  }

  Future<File> _getFile(banco) async {
    final diretorioDb = await getApplicationDocumentsDirectory();
    final arquivo = '${diretorioDb.path}/$banco.json';
    File file = new File(arquivo);
    var fileExist = await file.exists();
    if (fileExist = false) {
      file.writeAsString("");
    }
    return file;
  }

  Future<File> _saveData(banco) async {
    String data = json.encode(_pacienteList);
    final file = await _getFile(banco);
    return file.writeAsString(data);
  }

  Future<String> _readData(banco) async {
    try {
      final file = await _getFile(banco);
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  void novoPaciente() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Pacientes(title: 'Cadastro de paciente')),
    );
  }
}
