import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key? key}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      color: Colors.transparent,
      width: size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Container(
              width: 120,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(100),
                    dashPattern: [8, 8],
                    strokeWidth: 2,
                    color: Colors.black,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Ajouter \n\ une storie',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            ListView.builder(
              // physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              padding: const EdgeInsets.only(left: 10),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(7)),
                      // child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(7),
                      //     child: Image.network(
                      //       "https://cdn.pixabay.com/photo/2016/10/18/21/22/beach-1751455_1280.jpg",
                      //       fit: BoxFit.cover,
                      //     )),
                    ),
                    const Positioned(
                      top: 10,
                      left: 10,
                      child: CircleAvatar(
                          // backgroundImage: NetworkImage(
                          //     "https://cdn.pixabay.com/photo/2017/01/20/00/30/maldives-1993704_1280.jpg"),
                          ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(7),
                                  bottomRight: Radius.circular(7))),
                          height: 30,
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            'Anderson',
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                  ],
                );
              },
            )
          ],
        ),
      ),
    ));
  }
}
