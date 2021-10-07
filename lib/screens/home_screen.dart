import 'package:app/Models/token.dart';
import 'package:app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Token token;

  HomeScreen({required this.token});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App'),
      ),
      body: _getBody(), 
      drawer: _getUserMenu(),
    );
  }

Widget _getBody() {
  return Container(
    margin: EdgeInsets.all(30),
    child: Center(
      child: Text( 'Bienvenid@ ${widget.token.user.fullName}',
      style: TextStyle(
        fontSize: 20,
        fontWeight:  FontWeight.bold
      ),
      ),
    ),
  );
}

  Widget _getUserMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image(
              image: AssetImage('assets/carro.jpg'),
            ),
            ),
            ListTile(
              leading: Icon(Icons.two_wheeler),
              title: Text("Marcas"),
              onTap: () {},
            ),
              ListTile(
              leading: Icon(Icons.two_wheeler),
              title: Text("Procedimientos"),
              onTap: () {},
            ),
              ListTile(
              leading: Icon(Icons.two_wheeler),
              title: Text("Tipos de Documento"),
              onTap: () {},
            ),
              ListTile(
              leading: Icon(Icons.two_wheeler),
              title: Text("Tipos de Vehículos"),
              onTap: () {},
            ),
              ListTile(
              leading: Icon(Icons.two_wheeler),
              title: Text("Usuarios"),
              onTap: () {},
            ),
              Divider(
            color: Colors.black, 
            height: 2,
          ),
           ListTile(
            leading: Icon(Icons.face),
            title: const Text('Editar Perfil'),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () { 
               Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                builder: (context) => LoginScreen()
      ),
    );
            },
          ),
        ],
      ),
    );
  }
}