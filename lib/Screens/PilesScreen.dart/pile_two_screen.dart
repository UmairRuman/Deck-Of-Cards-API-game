import 'package:flutter/material.dart';

class PileTwoScreen extends StatefulWidget {
  final List<String> pileTwoCodeList;
  final List<String> pileTwoImageList;
  final List<String> pileTwoValueList;

  void Function(int) onClickOnCard;
  PileTwoScreen({
    super.key,
    required this.onClickOnCard,
    required this.pileTwoCodeList,
    required this.pileTwoImageList,
    required this.pileTwoValueList,
  });

  @override
  State<PileTwoScreen> createState() => _PileTwoScreenState();
}

class _PileTwoScreenState extends State<PileTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.pileTwoValueList.length,
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Material(
            child: InkWell(
                onTap: () {
                  widget.onClickOnCard(index);
                  // widget.indexOfCard = index;
                  Navigator.pop(context);
                },
                child: Image.network(widget.pileTwoImageList[index])),
          ),
        );
      },
    );
  }
}
