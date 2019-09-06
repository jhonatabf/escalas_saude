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

class _HomeState extends State<Home> {
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
          tituloApp,
          style: TextStyle(color: Colors.grey[700]),
        ),
        iconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
      ),
      body: base(),
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
            icon: Icon(Icons.home),
            title: Text('Escalas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Hospitais'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_calendar),
            title: Text('Pacientes'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
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
            "ESCALAS DISPONÍVEIS",
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
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: titulosEscalas.length,
            itemBuilder: (context, index) {
              int item = index;
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Color(0xFFFFDDDDDD),
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () {},
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
}

