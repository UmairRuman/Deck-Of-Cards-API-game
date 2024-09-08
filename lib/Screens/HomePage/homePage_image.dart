import 'package:api_deck_of_cards/Constants/homepage_constants.dart';
import 'package:flutter/material.dart';

class HomePageImage extends StatelessWidget {
  const HomePageImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(HomePageConstants.imagePath);
  }
}
