import 'dart:async';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:vines/constant/bddconstant.dart';
import 'package:vines/controller/appcontroller.dart';

class WatchVideo extends StatefulWidget {
  WatchVideo({Key? key, required this.idcompte, required this.idserie})
      : super(key: key);
  String idcompte;
  String idserie;
  @override
  _WatchVideoState createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> with WidgetsBindingObserver {
  // late VideoPlayerController _controller;
  // appino

  @override
  void didPause() async {
    int currentPosition = _videoPlayerController.value.position.inMilliseconds;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('video_position_${widget.videoUrl}', currentPosition);
    _videoPlayerController.dispose();
  }

  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(
          showFullscreenButton: false,
          showSeekButtons: true,
          enterFullscreenOnStart: true,
          // exitFullscreenOnEnd: true,
          settingsButtonAvailable: false);

  int currentVideoIndex = 0;
  final appcontroller = Get.put(Appcontroller());
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection(Bddconstant.seriF)
        .doc(widget.idserie)
        .collection(Bddconstant.videoF)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        // ignore: invalid_use_of_protected_member
        appcontroller.videonomw.value.add(element["videourl"]);
      }
    });
    _loadVideoUrls();
    WidgetsBinding.instance!.addObserver(this);
  }

  Future<void> _loadVideoUrls() async {
    // appino
    // ignore: deprecated_member_use
    _videoPlayerController = VideoPlayerController.network(
      appcontroller.videonomw.value[currentVideoIndex],
    )..initialize().then((value) {
        setState(() {});
        _videoPlayerController.play();
        _videoPlayerController.addListener(_videoPlayerListener);
      });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  void _videoPlayerListener() {
    print("commance");
    print(_videoPlayerController.value.duration);
    // print(object)
    if (_videoPlayerController.value.position >=
        _videoPlayerController.value.duration) {
      // Video has ended, move to the next video
      if (currentVideoIndex < appcontroller.videonomw.value.length - 1) {
        currentVideoIndex++;
        _videoPlayerController.pause();
        _videoPlayerController.removeListener(_videoPlayerListener);
        _videoPlayerController.dispose();
        // ignore: deprecated_member_use
        _videoPlayerController = VideoPlayerController.network(
            appcontroller.videonomw.value[currentVideoIndex])
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController.play();
            _videoPlayerController.addListener(_videoPlayerListener);
          });
      } else {
        // All videos have been played, navigate to another page
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OtherPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_videoPlayerController.value.isInitialized) {
      return Scaffold(
        body: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController,
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black.withBlue(30),
        body: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Page'),
      ),
      body: Center(
        child: Text('All videos have been played.'),
      ),
    );
  }
}
