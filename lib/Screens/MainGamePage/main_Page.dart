import 'dart:developer';

import 'package:api_deck_of_cards/ApiClasses/Api_model_classes/drawer_cards_from_piles.dart';
import 'package:api_deck_of_cards/ApiClasses/api_Service.dart';
import 'package:api_deck_of_cards/Constants/mainpage_constants.dart';
import 'package:api_deck_of_cards/Helpers/MyShaderMask.dart';
import 'package:api_deck_of_cards/Screens/PilesScreen.dart/pile_one_screen.dart';
import 'package:api_deck_of_cards/Screens/PilesScreen.dart/pile_two_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const pageName = "/mainPage";
  final String deckId;
  final List<String> pileOneCodeList;
  final List<String> pileOneImageList;
  final List<String> pileOneValueList;
  final List<String> pileTwoCodeList;
  final List<String> pileTwoImageList;
  final List<String> pileTwoValueList;
  const MainPage({
    super.key,
    required this.deckId,
    required this.pileOneCodeList,
    required this.pileOneImageList,
    required this.pileOneValueList,
    required this.pileTwoCodeList,
    required this.pileTwoImageList,
    required this.pileTwoValueList,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isClickOnCardFromGrid = false;
  int? indexOfCardToRemoveFromFirstPile;
  int? indexOfCardToRemoveFromSecondPile;
  int? indexOfCardToRemoveFromThirdPile;
  String? cardValueOfThirdPile;
  String? cardCodeOfThirdPile;
  String? cardValueOfFirstPile;
  String? cardValueOfSecondPile;
  String? cardCodeOfFirstPile;
  String? cardCodeOfSecondPile;
  FlipCardController? controller;
  FlipCardController? controller2;
  CardApiService cardApiService = CardApiService();
  Future<PileCardDrawer>? future1;
  Future<PileCardDrawer>? future2;
  Future<PileCardDrawer>? future3;
  @override
  void initState() {
    super.initState();
    controller = FlipCardController();
    controller2 = FlipCardController();
  }

  void onTopCardStackClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PileOneScreen(
            pileOneCodeList: widget.pileOneCodeList,
            pileOneImageList: widget.pileOneImageList,
            pileOneValueList: widget.pileOneValueList);
      },
    ));
  }

  void onBottomCardStackClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return PileTwoScreen(
            onClickOnCard: onCLickCardFromGrid,
            pileTwoCodeList: widget.pileTwoCodeList,
            pileTwoImageList: widget.pileTwoImageList,
            pileTwoValueList: widget.pileTwoValueList);
      },
    ));
  }

  void onClickDrawCard() {
    setState(() {
      isClickOnCardFromGrid = false;
      future1 = cardApiService.drawCardFromTop(
          deckId: "/${widget.deckId}", pileUrl: "/pile", pileName: "/pile1");

      future2 = cardApiService.drawCardFromTop(
          deckId: "/${widget.deckId}", pileUrl: "/pile", pileName: "/pile2");
      controller!.toggleCard();
      controller2!.toggleCard();
    });
  }

  void onCLickCardFromGrid(int index) {
    setState(() {
      isClickOnCardFromGrid = true;
      String cardCode = widget.pileTwoCodeList[index];
      log("Card Code : $cardCode");
      future3 = cardApiService.drawCardByName(
          deckId: "/${widget.deckId}",
          pileUrl: "/pile",
          pileName: "/pile2",
          operationOnPileUrl: "/draw/?cards=$cardCode");
      future1 = cardApiService.drawCardFromTop(
          deckId: "/${widget.deckId}", pileUrl: "/pile", pileName: "/pile1");
      controller!.toggleCard();
      controller2!.toggleCard();
    });
  }

  void onNextMove() {
    setState(() {
      if (cardValueOfFirstPile!.length > 1) {
        switch (cardValueOfFirstPile) {
          case "ACE":
            cardValueOfFirstPile = "15";
            break;
          case "KING":
            cardValueOfFirstPile = "14";
            break;
          case "JACK":
            cardValueOfFirstPile = "12";
            break;
          case "QUEEN":
            cardValueOfFirstPile = "13";
            break;
        }
      }
      if (cardValueOfSecondPile!.length > 1) {
        switch (cardValueOfSecondPile) {
          case "ACE":
            cardValueOfSecondPile = "15";
            break;
          case "KING":
            cardValueOfSecondPile = "14";
            break;
          case "JACK":
            cardValueOfSecondPile = "12";
            break;
          case "QUEEN":
            cardValueOfSecondPile = "13";
            break;
        }
      }
      if (cardValueOfThirdPile!.length > 1) {
        switch (cardValueOfThirdPile) {
          case "ACE":
            cardValueOfThirdPile = "15";
            break;
          case "KING":
            cardValueOfThirdPile = "14";
            break;
          case "JACK":
            cardValueOfThirdPile = "12";
            break;
          case "QUEEN":
            cardValueOfThirdPile = "13";
            break;
        }
      }

      int pileOneCardIntegerValue = int.parse(cardValueOfFirstPile!);
      int pileTwoCardIntegerValue = int.parse(cardValueOfSecondPile!);
      if (indexOfCardToRemoveFromFirstPile! >= 0 &&
          indexOfCardToRemoveFromSecondPile! >= 0) {
        if (pileOneCardIntegerValue > pileTwoCardIntegerValue) {
          //Add the card of second pile in first
          widget.pileOneCodeList
              .add(widget.pileTwoCodeList[indexOfCardToRemoveFromSecondPile!]);
          widget.pileOneValueList
              .add(widget.pileTwoValueList[indexOfCardToRemoveFromSecondPile!]);
          widget.pileOneImageList
              .add(widget.pileTwoImageList[indexOfCardToRemoveFromSecondPile!]);
          //Remove the card from the second pile
          widget.pileTwoValueList.removeAt(indexOfCardToRemoveFromSecondPile!);
          widget.pileTwoCodeList.removeAt(indexOfCardToRemoveFromSecondPile!);
          widget.pileTwoImageList.removeAt(indexOfCardToRemoveFromSecondPile!);

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Computer Won this Move")));
        } else if (pileOneCardIntegerValue < pileTwoCardIntegerValue) {
          //Add the card of First pile in Second
          widget.pileTwoCodeList
              .add(widget.pileOneCodeList[indexOfCardToRemoveFromFirstPile!]);
          widget.pileTwoValueList
              .add(widget.pileOneValueList[indexOfCardToRemoveFromFirstPile!]);
          widget.pileTwoImageList
              .add(widget.pileOneImageList[indexOfCardToRemoveFromFirstPile!]);
          //Remove the card from the First Pile
          widget.pileOneValueList.removeAt(indexOfCardToRemoveFromFirstPile!);
          widget.pileOneCodeList.removeAt(indexOfCardToRemoveFromFirstPile!);
          widget.pileOneImageList.removeAt(indexOfCardToRemoveFromFirstPile!);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("You Won this Move")));
        } else {
          // //Add the first Pile card in first one again
          // widget.pileOneCodeList
          //     .add(widget.pileOneCodeList[indexOfCardToRemoveFromFirstPile!]);
          // widget.pileOneValueList
          //     .add(widget.pileOneValueList[indexOfCardToRemoveFromFirstPile!]);
          // widget.pileOneImageList
          //     .add(widget.pileOneImageList[indexOfCardToRemoveFromFirstPile!]);
          // //Add the Second Pile card in Second one again
          // widget.pileTwoCodeList
          //     .add(widget.pileTwoCodeList[indexOfCardToRemoveFromSecondPile!]);
          // widget.pileTwoValueList
          //     .add(widget.pileTwoValueList[indexOfCardToRemoveFromSecondPile!]);
          // widget.pileTwoImageList
          //     .add(widget.pileTwoImageList[indexOfCardToRemoveFromSecondPile!]);
        }
      }
      controller!.toggleCard();
      controller2!.toggleCard();
    });
  }

  // void onNextMove() {
  // future2!.then((drawnCard) {
  //   // Assuming drawnCard contains the details of the drawn card
  //   if (drawnCard.cards != null && drawnCard.cards!.isNotEmpty) {
  //     String drawnCardCode = drawnCard.cards![0].code!;

  //     // Find the index of the drawn card in pileTwoCodeList
  //     int indexToRemove = widget.pileTwoCodeList.indexOf(drawnCardCode);

  //     if (indexToRemove != -1) {
  //       // Remove the card from pileTwoValueList and pileTwoImageList
  //       setState(() {
  //         widget.pileTwoCodeList.removeAt(indexToRemove);
  //         widget.pileTwoValueList.removeAt(indexToRemove);
  //         widget.pileTwoImageList.removeAt(indexToRemove);
  //         controller!.toggleCard();
  //       });
  //     }
  //   }
  // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 5,
          ),
          Expanded(
              flex: 38,
              child: Row(
                children: [
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                    flex: 30,
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 5,
                        ),
                        Expanded(
                            flex: 40,
                            child: InkWell(
                              onTap: onTopCardStackClick,
                              child: Image.asset(
                                  fit: BoxFit.fill,
                                  MainPageConstant.stackOFCardsBackImage),
                            )),
                        const Spacer(
                          flex: 25,
                        ),
                        Expanded(
                            flex: 15,
                            child: ShaderMask(
                                shaderCallback: MyShaderMask.shaderMaskCallBack,
                                child: const Text(
                                  "Remaining Cards :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: MainPageConstant.fontFamily,
                                      fontWeight: FontWeight.bold),
                                ))),
                        Expanded(
                            flex: 15,
                            child: ShaderMask(
                                shaderCallback: MyShaderMask.shaderMaskCallBack,
                                child: Text(
                                  "${widget.pileOneValueList.length}",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontFamily: MainPageConstant.fontFamily,
                                      fontWeight: FontWeight.bold),
                                ))),
                        const Spacer(
                          flex: 5,
                        )
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                    flex: 45,
                    child: FutureBuilder(
                      future: future1,
                      builder: (context, snapshotOfCommputerPile) {
                        if (snapshotOfCommputerPile.hasError) {
                          return const AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to load data'),
                          );
                        } else if (snapshotOfCommputerPile.connectionState ==
                            ConnectionState.none) {
                          log("Connection.none");
                          return Image.network(
                              MainPageConstant.cardBackImagePath);
                        } else if (snapshotOfCommputerPile.connectionState ==
                                ConnectionState.active ||
                            snapshotOfCommputerPile.connectionState ==
                                ConnectionState.waiting) {
                          log("Connection is on  waiting ");
                          return Image.network(
                              MainPageConstant.cardBackImagePath);
                        } else if (snapshotOfCommputerPile.connectionState ==
                                ConnectionState.done &&
                            snapshotOfCommputerPile.hasData) {
                          // log(snapshotOfCommputerPile.data!.deckId!);
                          // log(snapshotOfCommputerPile.data!.cards![0].value!);
                          cardValueOfFirstPile =
                              snapshotOfCommputerPile.data!.cards![0].value!;
                          cardCodeOfFirstPile =
                              snapshotOfCommputerPile.data!.cards![0].code!;
                          int indexToRemove = widget.pileOneCodeList.indexOf(
                              snapshotOfCommputerPile.data!.cards![0].code!);

                          indexOfCardToRemoveFromFirstPile = indexToRemove;
                          log("Index From First Pile: $indexToRemove");
                          // widget.pileOneCodeList.removeAt(indexToRemove);
                          // widget.pileOneValueList.removeAt(indexToRemove);
                          // widget.pileOneImageList.removeAt(indexToRemove);
                          return FlipCard(
                              // autoFlipDuration: const Duration(seconds: 3),
                              side: CardSide.BACK,
                              controller: controller,
                              direction: FlipDirection.HORIZONTAL,
                              flipOnTouch: false,
                              speed: 3000,
                              front: Image.network(
                                  MainPageConstant.cardBackImagePath),
                              back: Image.network(snapshotOfCommputerPile
                                  .data!.cards![0].image!));
                        } else {
                          return const AlertDialog(
                            title: Text('No Data'),
                            content: Text('No data available'),
                          );
                        }
                      },
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  )
                ],
              )),
          const Spacer(
            flex: 3,
          ),
          Expanded(
              flex: 8,
              child: Row(
                children: [
                  const Spacer(
                    flex: 30,
                  ),
                  Expanded(
                    flex: 40,
                    child: InkWell(
                      onTap: onNextMove,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1,
                                color: Colors.black,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(20)),
                        child: ShaderMask(
                          shaderCallback: MyShaderMask.shaderMaskCallBack,
                          child: const Text(
                            "Next Move",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Philosopher",
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 30,
                  )
                ],
              )),
          const Spacer(
            flex: 3,
          ),
          Expanded(
              flex: 38,
              child: Row(
                children: [
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                      flex: 45,
                      child: FutureBuilder(
                        future: future2,
                        builder: (context, snapshotOfUserPile) {
                          if (snapshotOfUserPile.hasError) {
                            return const AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to load data'),
                            );
                          } else if (snapshotOfUserPile.connectionState ==
                              ConnectionState.none) {
                            return Image.network(
                                MainPageConstant.cardBackImagePath);
                          } else if (snapshotOfUserPile.connectionState ==
                                  ConnectionState.active ||
                              snapshotOfUserPile.connectionState ==
                                  ConnectionState.waiting) {
                            return Image.network(
                                MainPageConstant.cardBackImagePath);
                          } else if (snapshotOfUserPile.connectionState ==
                                  ConnectionState.done &&
                              snapshotOfUserPile.hasData) {
                            // log(snapshotOfUserPile.data!.cards![0].image!);
                            // log(snapshotOfUserPile.data!.cards![0].value!);
                            cardValueOfSecondPile =
                                snapshotOfUserPile.data!.cards![0].value;
                            cardCodeOfSecondPile =
                                snapshotOfUserPile.data!.cards![0].code;
                            int indexToRemove = widget.pileTwoCodeList.indexOf(
                                snapshotOfUserPile.data!.cards![0].code!);
                            indexOfCardToRemoveFromSecondPile = indexToRemove;
                            log("Index From Second Pile: $indexToRemove");
                            // widget.pileTwoCodeList.removeAt(indexToRemove);
                            // widget.pileTwoValueList.removeAt(indexToRemove);
                            // widget.pileTwoImageList.removeAt(indexToRemove);
                            return FlipCard(
                                speed: 3000,
                                flipOnTouch: false,
                                side: CardSide.BACK,
                                controller: controller2,
                                direction: FlipDirection.HORIZONTAL,
                                front: Image.network(
                                    MainPageConstant.cardBackImagePath),
                                back: isClickOnCardFromGrid == true
                                    ? FutureBuilder(
                                        future: future3,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            const AlertDialog(
                                              title: Text('ErrorFound'),
                                              content:
                                                  Text('No data available'),
                                            );
                                          } else if (snapshot.connectionState ==
                                                  ConnectionState.active ||
                                              snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            snapshot.data!.cards![0].code;
                                            cardCodeOfThirdPile =
                                                snapshot.data!.cards![0].code;
                                            cardValueOfThirdPile =
                                                snapshot.data!.cards![0].value;
                                            int indexToRemoveFromThird = widget
                                                .pileTwoCodeList
                                                .indexOf(snapshot
                                                    .data!.cards![0].code!);

                                            indexOfCardToRemoveFromThirdPile =
                                                indexToRemove;
                                            log("Data From Grid View click ${snapshot.data!.deckId}");
                                            return Image.network(snapshot
                                                .data!.cards![0].image!);
                                          }
                                          return const AlertDialog(
                                            title: Text('No Data'),
                                            content: Text('No data available'),
                                          );
                                        })
                                    : Image.network(snapshotOfUserPile
                                        .data!.cards![0].image!));
                          } else {
                            return const AlertDialog(
                              title: Text('No Data'),
                              content: Text('No data available'),
                            );
                          }
                        },
                      )),
                  const Spacer(
                    flex: 5,
                  ),
                  Expanded(
                    flex: 30,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 15,
                            child: ShaderMask(
                                shaderCallback: MyShaderMask.shaderMaskCallBack,
                                child: const Text(
                                  "Remaining Cards : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: MainPageConstant.fontFamily,
                                      fontWeight: FontWeight.bold),
                                ))),
                        Expanded(
                            flex: 15,
                            child: ShaderMask(
                                shaderCallback: MyShaderMask.shaderMaskCallBack,
                                child: Text(
                                  "${widget.pileTwoValueList.length}",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontFamily: MainPageConstant.fontFamily,
                                      fontWeight: FontWeight.bold),
                                ))),
                        const Spacer(
                          flex: 5,
                        ),
                        Expanded(
                            flex: 40,
                            child: InkWell(
                              onTap: onBottomCardStackClick,
                              child: Image.asset(
                                  fit: BoxFit.fill,
                                  MainPageConstant.stackOFCardsBackImage),
                            )),
                        const Spacer(
                          flex: 5,
                        ),
                        Expanded(
                            flex: 15,
                            child: InkWell(
                              mouseCursor: SystemMouseCursors.click,
                              onTap: onClickDrawCard,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(20)),
                                child: ShaderMask(
                                  shaderCallback:
                                      MyShaderMask.shaderMaskCallBack,
                                  child: const Text(
                                    "Draw Card ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Philosopher",
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        const Spacer(
                          flex: 5,
                        )
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  )
                ],
              )),
          const Spacer(
            flex: 5,
          )
        ],
      ),
    );
  }
}
