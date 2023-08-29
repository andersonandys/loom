import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vines/controller/appcontroller.dart';
import 'package:vines/login_screen/registerScreen.dart';

class Howlook extends StatefulWidget {
  const Howlook({Key? key}) : super(key: key);

  @override
  _HowlookState createState() => _HowlookState();
}

class _HowlookState extends State<Howlook> {
  final appcontroller = Get.put(Appcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withBlue(10),
      appBar: AppBar(
        title: const Text(
          'Qui regarde ?',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.black.withBlue(10),
      ),
      body: Obx(() => Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ActionChip(
                      onPressed: () {
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      side: const BorderSide(color: Colors.orange),
                      backgroundColor: Colors.orange,
                      avatar: const Icon(
                        IconsaxBold.add_circle,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: const Text(
                        'Ajouter un utilisateur',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
              if (appcontroller.nbrescreen.value == 0)
                const Text(
                  'Ajouter un compte',
                  style: TextStyle(color: Colors.white),
                ),
              if (appcontroller.nbrescreen.value > 0)
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        300, // Largeur maximale souhaitée pour chaque élément
                    mainAxisSpacing:
                        8, // Espacement vertical entre les éléments
                    crossAxisSpacing:
                        8, // Espacement horizontal entre les éléments
                    childAspectRatio:
                        0.8, // Ratio de largeur sur hauteur des éléments
                  ),
                  itemBuilder: (context, index) {
                    // var serie = appcontroller.serieList[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(7)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          // child: CachedNetworkImage(
                          //   imageUrl: serie["posterurl"],
                          //   fit: BoxFit.cover,
                          //   placeholder: (context, url) => const Center(
                          //     child: SizedBox(
                          //       height: 30,
                          //       width: 30,
                          //       child: CircularProgressIndicator(),
                          //     ),
                          //   ),
                          //   errorWidget: (context, url, error) =>
                          //       const Icon(Icons.error),
                          // ),
                        ),
                      ),
                    );
                  },
                )
            ],
          )),
    );
  }
}
