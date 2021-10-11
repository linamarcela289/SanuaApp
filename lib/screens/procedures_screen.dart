import 'dart:convert';

import 'package:app/Models/Procedure.dart';
import 'package:app/Models/token.dart';
import 'package:app/components/loader_component.dart';
import 'package:app/helpers/constans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        child: Text('Procedimientos'),
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
}