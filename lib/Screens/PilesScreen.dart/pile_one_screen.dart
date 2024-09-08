import 'package:flutter/material.dart';

class PileOneScreen extends StatefulWidget {
  final List<String> pileOneCodeList;
  final List<String> pileOneImageList;
  final List<String> pileOneValueList;
  const PileOneScreen({
    super.key,
    required this.pileOneCodeList,
    required this.pileOneImageList,
    required this.pileOneValueList,
  });

  @override
  State<PileOneScreen> createState() => _PileOneScreenState();
}

class _PileOneScreenState extends State<PileOneScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.pileOneValueList.length,
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Image.network(widget.pileOneImageList[index]),
        );
      },
    );
  }
}
