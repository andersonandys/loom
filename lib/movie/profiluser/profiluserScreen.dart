import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:vines/controller/appcontroller.dart';
import 'package:vines/login_screen/home.dart';

class ProfiluserScreen extends StatefulWidget {
  const ProfiluserScreen({Key? key}) : super(key: key);

  @override
  _ProfiluserScreenState createState() => _ProfiluserScreenState();
}

class _ProfiluserScreenState extends State<ProfiluserScreen> {
  final appcontroller = Get.put(Appcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: const CircleAvatar(
                      radius: 50,
                    ),
                    title: Text(
                      (appcontroller.nomUser.value.isEmpty)
                          ? appcontroller.email.value
                          : appcontroller.nomUser.value,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: const Text('Compte standart'),
                  ),
                  const HeightBox(20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.black.withBlue(30),
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Votre compte est standar, \n Passez a un autre niveaux de compte pour beneficier de ample avantage.\n Soutenez la creation de serie',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const HeightBox(20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Voir les offres',
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  const HeightBox(20),
                  ClipRRect(
                    borderRadius:
                        const BorderRadiusDirectional.all(Radius.circular(10)),
                    child: SettingsList(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      sections: [
                        SettingsSection(
                          tiles: [
                            SettingsTile(
                              // onPressed: (context) => toNotificationsScreen(context),
                              title: const Text('Langue'),
                              description: const Text(
                                  'La langue suupporter par defaut est le FRANÇAIS'),
                              leading: const Icon(Icons.language),
                            ),
                            SettingsTile(
                              // onPressed: (context) => toNotificationsScreen(context),
                              title: const Text('Appareil'),
                              description: const Text(
                                  'Appareil connecte a votre compte'),
                              leading: const Icon(Icons.devices_other),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const HeightBox(20),
                  ClipRRect(
                    borderRadius:
                        const BorderRadiusDirectional.all(Radius.circular(10)),
                    child: SettingsList(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      sections: [
                        SettingsSection(
                          tiles: [
                            SettingsTile(
                              // onPressed: (context) => toNotificationsScreen(context),
                              title: const Text('Inviter des amis'),
                              description: const Text(
                                  'Inviter des amis a rejoindre l application pour profiter des meilleures serie du moment'),
                              leading: const Icon(Icons.send_to_mobile_rounded),
                            ),
                            SettingsTile(
                              // onPressed: (context) => toNotificationsScreen(context),
                              title: const Text('Aide'),
                              description: const Text(
                                  'Vous renconter des problemes ? consulter notre section aide ou laissez nous message'),
                              leading: const Icon(Icons.help),
                            ),
                            SettingsTile(
                              onPressed: (context) {
                                print("object");
                                FirebaseAuth.instance.signOut();
                                Get.to(() => LoginPage());
                              },
                              title: const Text('Terme et conditions'),
                              description: const Text(
                                  'Consulter le stermes et conditions dont vous etes soumis'),
                              leading: const Icon(Icons.privacy_tip),
                            ),
                            SettingsTile(
                              onPressed: (context) {
                                print("object");
                                FirebaseAuth.instance.signOut();
                                Get.to(() => LoginPage());
                              },
                              title: const Text('Changer de compte'),
                              enabled: false,
                              description: const Text(
                                  'Si vous souhaiter utiliser un autre compte '),
                              leading: const Icon(
                                  IconsaxOutline.arrow_swap_horizontal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  HeightBox(10),
                  const Center(
                    child: Text(
                      'Vines Tout droit reserve / Version beta 0.0.1',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )),
      )),
    );
  }
}
