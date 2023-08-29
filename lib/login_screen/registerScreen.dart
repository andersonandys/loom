import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vines/controller/logincontroller.dart';
import 'package:vines/movie/constant/widgetConstant.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final logincontroller = Get.put(Logincontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: Text(
                      'Creation de compte',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const HeightBox(30),
                  const Text(
                    'Adress email',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const HeightBox(5),
                  TextFormFieldwidget(
                    colors: Colors.grey.shade300,
                    colortext: Colors.black,
                    controller: logincontroller.emailregisterController.value,
                    obscureText: false,
                  ),
                  const HeightBox(10),
                  const Text(
                    'Mot de passe',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const HeightBox(5),
                  TextFormFieldwidget(
                    colors: Colors.grey.shade300,
                    colortext: Colors.black,
                    controller:
                        logincontroller.passwordregisterController.value,
                    obscureText: true,
                  ),
                  const HeightBox(5),
                  const Text(
                    'Confirmation',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const HeightBox(5),
                  TextFormFieldwidget(
                    colors: Colors.grey.shade300,
                    colortext: Colors.black,
                    controller:
                        logincontroller.confirmregisterPasswordController.value,
                    obscureText: true,
                  ),
                  const HeightBox(20),
                  const Center(
                    child: Text(
                      'Vous acceptez les termes et conditions en vous connectant',
                      style: TextStyle(),
                    ),
                  ),
                  const HeightBox(20),
                  TextButton(
                    onPressed: () {
                      // Action to perform when the button is pressed
                      logincontroller.registerWithEmailAndPassword(context);
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
                ],
              ),
            ),
          ))),
    );
  }
}
