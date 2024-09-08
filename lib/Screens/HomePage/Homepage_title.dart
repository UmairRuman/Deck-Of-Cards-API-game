import 'package:api_deck_of_cards/Helpers/MyShaderMask.dart';
import 'package:flutter/material.dart';

class HomePageTitle extends StatelessWidget {
  const HomePageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: MyShaderMask.shaderMaskCallBack,
      child: const Text(
        "Deck Of Cards",
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "Philosopher",
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
