import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _celular = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                  controller: _celular,
                  keyboardType: TextInputType.phone,
                  validator: (phone) {
                    if (phone == null || phone.isEmpty) {
                      return 'Por favor Digite o Telefone.';
                    }
                    return null;
                  }),
              ElevatedButton(
                onPressed: () {},
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
