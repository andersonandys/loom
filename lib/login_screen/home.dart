import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vines/controller/logincontroller.dart';
import 'package:vines/login_screen/registerScreen.dart';
import 'package:vines/movie/constant/widgetConstant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final logincontroller = Get.put(Logincontroller());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      appBar: AppBar(
        backgroundColor: const Color(0xff181818),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Vines',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: 2,
              width: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(47, 105, 255, 1),
                    Color.fromRGBO(0, 192, 169, 1),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeightBox(20),
                      const Center(
                        child: Text(
                          'Content de te revoir',
                          style: TextStyle(
                              fontSize: 19,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const HeightBox(20),
                      const Center(
                        child: Text(
                          'Payer un abonnement c est soutenir la creation de meilleur contenu',
                          style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const HeightBox(30),
                      const Text(
                        'Adress email',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const HeightBox(5),
                      TextFormFieldwidget(
                        colors: Colors.grey.shade800,
                        colortext: Colors.white,
                        controller: logincontroller.emailController.value,
                        obscureText: false,
                      ),
                      const HeightBox(10),
                      const Text(
                        'Mot de passe',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const HeightBox(5),
                      TextFormFieldwidget(
                        colors: Colors.grey.shade800,
                        colortext: Colors.white,
                        controller: logincontroller.passwordController.value,
                        obscureText: true,
                      ),
                    ],
                  ),
                  const HeightBox(20),
                  const Center(
                    child: Text(
                      'Vous acceptez les termes et conditions en vous connectant',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const HeightBox(20),
                  TextButton(
                    onPressed: () {
                      // Action to perform when the button is pressed
                      logincontroller.signInWithEmailAndPassword(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: const BorderSide(color: Colors.transparent),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(
                            double.infinity, 60), // Adjust the height as needed
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Connexion',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const WidthBox(30),
                        if (logincontroller.isLoading.isTrue)
                          const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                      ],
                    ),
                  ),
                  const HeightBox(20),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: const RegisterScreen(),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Creez un compte',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const HeightBox(30),
                  TextButton(
                    onPressed: () {
                      // Action to perform when the button is pressed
                      logincontroller.signInWithGoogle(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: const BorderSide(color: Colors.white),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(
                            double.infinity, 60), // Adjust the height as needed
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Connexion avec GOOGLE',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const WidthBox(30),
                        if (logincontroller.loadingGoogle.isTrue)
                          const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
