import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  ImagePicker? imagePicker;
  File? videoFile;
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker & Video Player'),
        actions: [buildPickVideo3()],
      ),
      body: controller != null ? GestureDetector(
        onTap: (){
          if(controller!.value.isPlaying){
            controller!.pause();
          }else{
            controller!.play();
          }
        },
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      ) : Container(),
    );
  }

  Padding buildPickVideo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () async {
            var video =
                await imagePicker!.pickVideo(source: ImageSource.gallery);
            videoFile = File(video!.path);
            controller = VideoPlayerController.file(videoFile!)
              ..initialize()
              ..addListener(() {})
              ..play()
              ..setLooping(true);
            setState(() {

            });
          },
          icon: const Icon(Icons.add_circle)),
    );
  }

  Padding buildPickVideo2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () async {
            controller = VideoPlayerController.asset('assets/videos/video.mp4')
              ..initialize()
              ..addListener(() {})
              ..play()
              ..setLooping(true);
            setState(() {

            });
          },
          icon: const Icon(Icons.add_circle)),
    );
  }

  Padding buildPickVideo3() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () async {
            controller = VideoPlayerController.network('https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4')
              ..initialize()
              ..addListener(() {})
              ..play()
              ..setLooping(true);
            setState(() {

            });
          },
          icon: const Icon(Icons.add_circle)),
    );
  }
}
