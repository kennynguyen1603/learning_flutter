import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Load a Lottie file from your assets
        // Lottie.asset('assets/lotties/LottieLogo1.json'),

        // Giả sử trong trường hợp hình ảnh quá lớn, bạn có thể sử dụng FittedBox để điều chỉnh kích thước của Lottie animation
        FittedBox(
          fit: BoxFit.contain,
          child: Lottie.asset('assets/lotties/LottieLogo1.json'),
        ),

        // Load a Lottie file from a remote url
        Lottie.network(
          'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
        ),

        Lottie.network(
          'https://telegram.org/file/464001484/1/bzi7gr7XRGU.10147/815df2ef527132dd23',
          decoder: LottieComposition.decodeGZip,
        ),

        // Lottie.asset(
        //   'assets/LightningBug_file.tgs',
        //   decoder: LottieComposition.decodeGZip,
        // ),

        // // Load an animation and its images from a zip file
        // Lottie.asset('assets/lottiefiles/angel.zip'),
      ],
    );
  }
}
