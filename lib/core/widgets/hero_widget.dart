import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, this.title});

  final String? title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Hero widget to create a hero animation
        Hero(
          tag: 'hero-tag',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              'assets/images/windows-10-microsoft-operating-system-wallpaper-preview.jpg', // Replace with your image asset
              fit: BoxFit.cover,
              width: double.infinity,
              // height: 300,
            ),
          ),
        ),

        // Positioned(
        //   bottom: 50,
        //   left: 20,
        //   child: Text(
        //     title ?? 'Hero Animation',
        //     style: const TextStyle(
        //       color: Colors.white,
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        Text(
          title ?? 'Hero Animation',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
          ),
        ),
      ],
    );
  }
}
