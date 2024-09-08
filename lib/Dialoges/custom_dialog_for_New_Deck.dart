import 'package:flutter/material.dart';

class MyCustomDialog extends StatelessWidget {
  const MyCustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.3, 0.5, 1],
              tileMode: TileMode.mirror,
              colors: [
                Colors.red,
                Colors.pink,
                Colors.purple,
              ]),
        ),
        child: const Column(
          children: [
            Spacer(
              flex: 10,
            ),
            Expanded(
                flex: 80,
                child: Row(
                  children: [
                    Spacer(
                      flex: 15,
                    ),
                    Expanded(flex: 10, child: CircularProgressIndicator()),
                    Spacer(
                      flex: 10,
                    ),
                    Expanded(
                        flex: 60,
                        child: Text(
                          "Creating a Shuffled Deck",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: "Philosopher",
                              fontWeight: FontWeight.bold),
                        )),
                    Spacer(
                      flex: 5,
                    )
                  ],
                )),
            Spacer(
              flex: 10,
            )
          ],
        ),
      ),
    );
  }
}
