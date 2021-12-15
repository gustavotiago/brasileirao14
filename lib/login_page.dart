import 'dart:convert';
import 'dart:html';
import 'package:brasileirao14/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _celularControle = TextEditingController();
  final _emailControle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(label: Text('e-mail')),
                  controller: _emailControle,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Por favor, Digite seu e-mail.';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(_emailControle.text)) {
                      return 'Por favor, digite um e-mail correto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(label: Text('Celular')),
                    controller: _celularControle,
                    keyboardType: TextInputType.phone,
                    validator: (phone) {
                      if (phone == null ||
                          phone.isEmpty ||
                          phone.length != 11) {
                        return 'Por favor, Digite o Telefone.';
                      }
                      return null;
                    }),
                ElevatedButton(
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (_formkey.currentState!.validate()) {
                      bool validadoLogin = await login();
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if (validadoLogin) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Text('Entrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: prefer_const_constructors
  final snackBar = SnackBar(content: Text(
      'Email inválido', textAlign: TextAlign.center,
    ),backgroundColor: Colors.redAccent,
  );

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://minhasapis.com.br/login/');
    var resposta = await http.post(
      url,
      body: {
        'emailControlo': _emailControle.text,
        'celularContole': _celularControle.text
      },
    );
    if (resposta == 200) {
      print(jsonDecode(resposta.body)['token']);
    } else {
      print(jsonDecode(resposta.body));
      return false;
    }
  }
}
