import 'dart:convert';

import 'package:app/Models/Procedure.dart';
import 'package:app/Models/token.dart';
import 'package:app/components/loader_component.dart';
import 'package:app/helpers/constans.dart';
import 'package:app/screens/procedures_screen_add_edit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProceduresScreen extends StatefulWidget {

 final Token token;

ProceduresScreen({required this.token});

  @override
  
  _ProceduresScreenState createState() => _ProceduresScreenState();
}

class _ProceduresScreenState extends State<ProceduresScreen> {
 List<Procedure> _procedure = [];
  bool _showLoader = false;

@override
  void initState() {
    super.initState();
    _getProcedures();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Procedimientos'),
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
          context, 
    MaterialPageRoute(
      builder: (context) => procedures_screen_add_edit(
        token: widget.token,
        procedure: Procedure(description: "", id: 0, price: 0),)
      ),
    );
         },
        ),
    );
  }

  void  _getProcedures () async {
   setState(() {
     _showLoader = true;
   });
    var url = Uri.parse('${Constans.apiUrl}/api/Procedures');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization' : 'bearer ${widget.token.token}',
        
      },
    );
    
    setState(() {
       _showLoader = false;
    });
  
  var body = response.body;
  var decodeJson = jsonDecode(body);
  if(decodeJson != null){
   for(var item in decodeJson){
     _procedure.add(Procedure.fromJson(item));
   }
  }
   print(_procedure);
  }

Widget _getContent() {
  return _procedure.length == 0
  ? _noContent()
  : _getListView();
  }

  Widget _noContent() {
    return Container(
      margin: EdgeInsets.all(20) ,
      child: Center(
  child:  Text(
    'No hay procedimientos almacenados',
  style: TextStyle(
    fontSize: 16,
    fontWeight:  FontWeight.bold
      ),  
      ),
    ),
  );
}

  Widget _getListView() {
    return ListView(
      children: _procedure.map((e){
        return Card(
          child: InkWell(
            onTap: () {
            Navigator.push(
          context, 
    MaterialPageRoute(
      builder: (context) => procedures_screen_add_edit(
        token: widget.token,
        procedure: Procedure(description: "", id: 0, price: 0),)
      ),
    );
            },
            child: Container(
              margin:  EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.description, 
                        style: TextStyle(
                          fontSize: 16,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  SizedBox(height: 5,),
                     Row(
                       children: [
                         Text(
                    '${NumberFormat.currency(symbol : '\$').format(e.price)}', 
                    style: TextStyle(
                          fontWeight: FontWeight.bold,
                          ),
                    ),
                       ],
                     ),
                ],
              ),
            ),
          ),
        );
        
      }).toList(),
    ); 
  }
}