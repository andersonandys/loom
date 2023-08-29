import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vines/controller/appcontroller.dart';
import 'package:vines/home_page/menu.dart';
import 'package:vines/movie/howlook.dart';
import 'package:vines/movie/suscribe.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final appcontroller = Get.put(Appcontroller());
  @override
  void initState() {
    super.initState();
    _redirectToNextPage();
  }

  void _redirectToNextPage() async {
    String expiration = "${DateTime.now().day / DateTime.now().month} ";
    print(expiration);
    await Future.delayed(const Duration(seconds: 5)); // Attendez 5 secondes
    // ignore: use_build_context_synchronously
    if (appcontroller.expirationUser == expiration) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SubscriptionPage()));
    } else {
      if (appcontroller.nbrescreen.value == 0) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Howlook()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MenuApp()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withBlue(30),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 100,
              width: 300,
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 70,
                ),
              ), // Remplacer par le contenu souhaité
            ),
          ),
        ],
      ),
    );
  }
}
