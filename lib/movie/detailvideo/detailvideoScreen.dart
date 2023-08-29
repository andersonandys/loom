import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailvideoScreen extends StatefulWidget {
  const DetailvideoScreen({Key? key}) : super(key: key);

  @override
  _DetailvideoScreenState createState() => _DetailvideoScreenState();
}

class _DetailvideoScreenState extends State<DetailvideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              HeightBox(10),
              const Text(
                'Vos serie en cours de lecture',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              const HeightBox(10),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                      300, // Largeur maximale souhaitée pour chaque élément
                  mainAxisSpacing: 8, // Espacement vertical entre les éléments
                  crossAxisSpacing:
                      8, // Espacement horizontal entre les éléments
                  childAspectRatio:
                      0.8, // Ratio de largeur sur hauteur des éléments
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7)),
                    child: const Text(
                      "User name is",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
