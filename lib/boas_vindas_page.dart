import 'package:brasileirao14/home_page.dart';
import 'package:brasileirao14/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoasVindasPage extends StatefulWidget {
  const BoasVindasPage({Key? key}) : super(key: key);

  @override
  _BoasVindasPageState createState() => _BoasVindasPageState();
}

class _BoasVindasPageState extends State<BoasVindasPage> {
  @override
  void initState() {
    super.initState();
    verificarToken().then((value) {
      if (value) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context)=>const HomePage(),
          ),
        );
      } else {
          Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context)=>const LoginPage(),
          ),
        );


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  verificarToken() async {
    SharedPreferences sharedPrefernce = await SharedPreferences.getInstance();
    if (sharedPrefernce.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }
}
