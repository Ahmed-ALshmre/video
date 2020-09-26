import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class SamplePlayer extends StatefulWidget {
  SamplePlayer({Key key}) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
 String url1;
  List url=[
    'https://firebasestorage.googleapis.com/v0/b/videypalyer.appspot.com/o/video%2F9-25%2F1601053875841asd?alt=media&token=885fbb77-1630-4b3a-9323-a484869bf4a7'
    , 'https://firebasestorage.googleapis.com/v0/b/videypalyer.appspot.com/o/video%2F9-25%2F1601053875841asd?alt=media&token=885fbb77-1630-4b3a-9323-a484869bf4a7'
  ];

  FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(url1),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        // height: 300,
        //     width: 300,
            child: ListView.builder(

                itemCount: url.length,
                itemBuilder: (c , index){

              return Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    height: 300,
                    width: 300,
                    child: FlickVideoPlayer(
                        flickManager: flickManager
                    ),
                  ),
                ],
              );
            })

      ),
    );
  }

}