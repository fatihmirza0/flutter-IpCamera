import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ip Camera Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CameraPage(),
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late final FijkPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = FijkPlayer();

    _player.setDataSource(
      //You must find the Real Time Streaming Protocol URL of the IP camera you purchased and write it here.
      'rtsp://admin:12345678Fb@192.168.25.27:554/onvif1',
      autoPlay: true,
    ).catchError((error) {
      print('Hata: $error');
    });
  }

  @override
  void dispose() {
    _player.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade300,
        title: const Text('Camera'),
      ),
      body: Center(
        child: FijkView(
          player: _player,
          panelBuilder: (FijkPlayer player, FijkData data, BuildContext context, Size viewSize, Rect texturePos) {
            return const SizedBox.shrink();
          },
          fit: FijkFit.contain,
        ),
      ),
    );
  }
}