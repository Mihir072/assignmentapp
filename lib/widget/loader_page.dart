import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/loader.json',
      width: 250,
      height: 250,
      fit: BoxFit.cover,
    );
  }
}
