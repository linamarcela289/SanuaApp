

import 'package:app/Models/Procedure.dart';
import 'package:app/Models/token.dart';
import 'package:flutter/material.dart';

class procedures_screen_add_edit extends StatefulWidget {
  final Token token;
  final Procedure procedure;

procedures_screen_add_edit({required this.token, required this.procedure});
  
  @override
  _procedures_screen_add_editState createState() => _procedures_screen_add_editState();
}

class _procedures_screen_add_editState extends State<procedures_screen_add_edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.procedure.id == 0 
        ? 'Nuevo procedimiento' 
        : widget.procedure.description
        ),
      ),
      body: Center(
        child: Text(
           widget.procedure.id == 0 
           ? 'Nuevo procedimiento' 
           : widget.procedure.description
           ),
      ),
    );
  }
}