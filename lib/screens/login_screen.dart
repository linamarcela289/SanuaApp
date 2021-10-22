import 'dart:convert';
import 'package:app/Models/token.dart';
import 'package:app/components/loader_component.dart';
import 'package:app/helpers/constans.dart';
import 'package:app/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   String _email ='sandra@yopmail.com';
   String _emailError ='';
   bool _emailShowError = false;
   String _password ='';
   String _passwordError ='123456';
   bool _passwordShowError = false;
   bool _remenberme = true;
   bool _passwordshow = false;
   bool _showLoader = false;
   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40,),
                _showLogo(),
                SizedBox(height: 20,),
                _showEmail(),
                _showPassword(),
                _showRemenberme(),
                _showButtons(),
              ],
            ),
            
          ),
          _showLoader ? LoaderComponent(text: 'Por favor espere...') : Container(),
        ],
      ),
    );
  }

   Widget _showLogo() {
    return Image(
      image: AssetImage('assets/logo.jpg'),
      width: 300,
      fit: BoxFit.fill,
    );
  }

 Widget _showEmail() {
   return Container(
     padding: EdgeInsets.all(10),
     child: TextField(
        autofocus: true,
       keyboardType: TextInputType.emailAddress,
     decoration: InputDecoration(
       hintText: 'Ingresa tu email...',
       labelText: 'Email',
       errorText: _emailShowError ? _emailError : null,
       prefixIcon: Icon(Icons.alternate_email),
       suffixIcon: Icon(Icons.email),
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(10)
         ),
     ),
     onChanged: (value){
       _email = value;
     },
     ),
   );
 }

  Widget _showPassword() {
return Container(
     padding: EdgeInsets.all(10),
     child: TextField(
      obscureText: !_passwordshow,
      decoration: InputDecoration(
        hintText: 'Ingresa tu password...',
       labelText: 'Password',
       errorText: _passwordShowError ? _passwordError : null,
       prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _passwordshow ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordshow = !_passwordshow;
              });
            }, 
          ),
       border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
         ),
     ),
   onChanged: (value) {
          _password = value;
        },
     ),
   );

  }

   Widget _showRemenberme() {
     return CheckboxListTile(
       title: Text('Recordarme'),
       value: _remenberme,
       onChanged: (value) { 
         setState(() {
           _remenberme = value!;
         });
         
        }, 
       
     );
  }

Widget _showButtons() {
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
           child: ElevatedButton(
          child: Text('Iniciar sesión'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Colors.orange;
              }
          ),
          ),
          onPressed: () => _login(),
            
          ),
        ),
        SizedBox(width: 20,),
         Expanded(
           child: ElevatedButton(
            child: Text('Nuevo usuario'),
               style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Colors.purple;
              }
          ),
          ),
            onPressed: (){},
               ),
         ),
      ],
    ),
  );
}

  void _login() async {
    setState(() {
      _passwordshow = false;
    });

    if(!_validateFields()) {
      return;
    }
  setState(() {
      _showLoader = true;
    });
   
    Map<String, dynamic> request = {
      'userName': _email,
      'password': _password,
    };
var url = Uri.parse('${Constans.apiUrl}/api/Account/CreateToken');
    var response = await http.post(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      },
      body: jsonEncode(request),
    );

      setState(() {
      _showLoader = false;
    });

if(response.statusCode >= 400){
  setState(() {
    _passwordShowError = true;
    _passwordError = "Email o password incorectos";
  });
  return;
}
  var body = response.body;
  var decodeJson = jsonDecode(body);
  var token = Token.fromJson(decodeJson);
  Navigator.pushReplacement(
    context, 
    MaterialPageRoute(
      builder: (context) => HomeScreen(token: token,)
      ),
    );
  }


  bool _validateFields() {
    bool isValid = true;

    if (_email.isEmpty) {
      isValid  = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar tu email.';
    } else if (!EmailValidator.validate(_email)) {
      isValid  = false;
      _emailShowError = true;
      _emailError = 'Debes ingresar un email válido.';
    } else {
      _emailShowError = false;
    }

  if (_password.isEmpty) {
      isValid  = false;
      _passwordShowError = true;
      _passwordError = 'Debes ingresar tu password.';
    } else if (_password.length < 6) {
      isValid  = false;
      _passwordShowError = true;
      _passwordError = 'Debes ingresar un passwprd minimo de 6 carácteres.';
    } else {
      _passwordShowError = false;
    }


    setState(() { });
    return isValid;
  }
}