import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vines/constant/bddconstant.dart';
import 'package:vines/home_page/menu.dart';

class Logincontroller extends GetxController {
  final Rx<TextEditingController> emailController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailregisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordregisterController =
      TextEditingController().obs;
  final Rx<TextEditingController> confirmregisterPasswordController =
      TextEditingController().obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var instance = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  // variable de globale
  var isLoading = false.obs;
  var loadingGoogle = false.obs;
  messagesuccess(message) {
    Get.snackbar("Success", message,
        colorText: Colors.white,
        shouldIconPulse: true,
        backgroundColor: Colors.greenAccent,
        icon: const Icon(
          IconsaxBold.check,
          color: Colors.white,
        ));
  }

  messageerror(message) {
    Get.snackbar("Echec", message,
        colorText: Colors.white,
        shouldIconPulse: true,
        backgroundColor: Colors.red,
        icon: const Icon(
          IconsaxBold.close_square,
          color: Colors.white,
        ));
  }
  // function pour la connexion utilisateur par mail et mot de passe

  Future<void> signInWithEmailAndPassword(context) async {
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      // Connexion réussie
      // Vous pouvez naviguer vers une autre page ici
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const MenuApp(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Une erreur s'est produite";
      messageerror(errorMessage);
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        errorMessage = "Aucun utilisateur trouvé pour cet e-mail.";
        messageerror(errorMessage);
        isLoading.value = false;
      } else if (e.code == 'wrong-password') {
        errorMessage = "Mot de passe incorrect.";
        messageerror(errorMessage);
        isLoading.value = false;
      } else if (e.code == 'invalid-email') {
        errorMessage = "Adresse e-mail invalide.";
        messageerror(errorMessage);
        isLoading.value = false;
      } else if (e.code == 'weak-password') {
        errorMessage = "Le mot de passe doit comporter au moins 8 caractères.";
        messageerror(errorMessage);
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  // function pour la creation de compte par adress mail et mot de passe
  Future<void> registerWithEmailAndPassword(context) async {
    isLoading.value = true;
    if (emailregisterController.value.text.isEmpty) {
      messageerror("Nous vous prions de saisir votre adress mail");
      isLoading.value = false;
    } else if (passwordregisterController.value.text.isEmpty) {
      messageerror("Nous vous prions de saisir un mot de passe");
      isLoading.value = false;
    } else if (confirmregisterPasswordController.value.text.isEmpty) {
      messageerror("Nous vous prions de confirmer le mot de passe");
      isLoading.value = false;
    } else if (passwordregisterController.value.text !=
        confirmregisterPasswordController.value.text) {
      messageerror("Les mots de passe ne correspondent pas.");
      isLoading.value = false;
    } else {
      try {
        final credential = await _auth.createUserWithEmailAndPassword(
          email: emailregisterController.value.text,
          password: passwordregisterController.value.text,
        );

        saveuser(credential.user?.photoURL, credential.user?.email,
            credential.user?.displayName, credential.user?.uid);
        isLoading.value = false;
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const MenuApp(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          messageerror("Cet e-mail est déjà utilisé.");
          isLoading.value = false;
        } else if (e.code == 'invalid-email') {
          messageerror("Adresse e-mail invalide.");
          isLoading.value = false;
        } else if (e.code == 'weak-password') {
          messageerror("Le mot de passe doit comporter au moins 8 caractères.");
          isLoading.value = false;
        }
      } finally {
        isLoading.value = false;
      }
    }
  }

  // function pour la connexion avec google
  Future<void> signInWithGoogle(context) async {
    loadingGoogle.value = true;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );

        // Vérifier si l'utilisateur existe déjà avec cette adresse e-mail
        final existingUser =
            await _auth.fetchSignInMethodsForEmail(googleSignInAccount.email);
        if (existingUser.isEmpty) {
          // Aucun utilisateur avec cette adresse e-mail n'existe
          // Connectez l'utilisateur avec le compte Google
          final dataUser = await _auth.signInWithCredential(credential);
          saveuser(dataUser.user?.photoURL, dataUser.user?.email,
              dataUser.user?.displayName, dataUser.user?.uid);
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MenuApp(),
            ),
          );
        } else {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const MenuApp(),
            ),
          );
        }
      } else {
        // L'utilisateur a annulé la connexion
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        messageerror(
            "Un compte avec des informations d'identification différentes existe déjà.");
        loadingGoogle.value = false;
      } else if (e.code == 'invalid-credential') {
        messageerror(
            "Informations d'identification non valides pour la connexion Google.");
        loadingGoogle.value = false;
      } else if (e.code == 'operation-not-allowed') {
        messageerror("La connexion avec Google n'est pas autorisée.");
        loadingGoogle.value = false;
      } else if (e.code == 'user-disabled') {
        messageerror("L'utilisateur a été désactivé.");
        loadingGoogle.value = false;
      } else {
        messageerror("Erreur de connexion avec Google : ${e.code}");
        loadingGoogle.value = false;
      }
    } finally {
      loadingGoogle.value = false;
    }
  }

  saveuser(avatar, mail, nom, uid) {
    String expiration = "${DateTime.now().day}/${DateTime.now().month + 1}";
    var data = {
      "nom": "",
      "avatar": avatar,
      "typecompte": 0,
      "expiration": expiration,
      "datecreat": DateTime.now(),
      "nbrescreen": 1,
      "mail": mail,
      'readi': true,
      "phone": "",
      "uid": uid,
    };
    instance.collection(Bddconstant.UserF).doc(uid).set(data);
  }
}
