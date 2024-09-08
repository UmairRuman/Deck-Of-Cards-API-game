import 'dart:developer';

import 'package:api_deck_of_cards/ApiClasses/Api_model_classes/card_drawer.dart';
import 'package:api_deck_of_cards/ApiClasses/Api_model_classes/deck_creater_model.dart';
import 'package:api_deck_of_cards/ApiClasses/Api_model_classes/pile_creater.dart';
import 'package:api_deck_of_cards/ApiClasses/api_Service.dart';
import 'package:api_deck_of_cards/Constants/homepage_constants.dart';
import 'package:api_deck_of_cards/Dialoges/custom_dialog_for_New_Deck.dart';
import 'package:api_deck_of_cards/Dialoges/custom_dialog_for_drawingCards.dart';
import 'package:api_deck_of_cards/Helpers/MyShaderMask.dart';
import 'package:api_deck_of_cards/Screens/HomePage/Homepage_title.dart';
import 'package:api_deck_of_cards/Screens/MainGamePage/main_Page.dart';
import 'package:flutter/material.dart';

import '../../Dialoges/custom_dialog_for_setting_piles.dart';

class MyHomePage extends StatefulWidget {
  static const pageName = "/";
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CardApiService cardApiService = CardApiService();
  Future<NewDeckCreater>? future1;
  Future<CardDrawerFromDeck>? future2;
  Future<PileCreaterAndAdder>? future3;
  @override
  void initState() {
    super.initState();
  }

  void onClickStartGame() {
    future1 = cardApiService.newShuffledCardCreation('/new');

    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: future1,
          builder: (context, AsyncSnapshot<NewDeckCreater> snapshotMain) {
            if (snapshotMain.connectionState == ConnectionState.waiting) {
              return const MyCustomDialog();
            } else if (snapshotMain.hasError) {
              return const AlertDialog(
                title: Text('Error'),
                content: Text('Failed to load data'),
              );
            } else if (snapshotMain.connectionState == ConnectionState.done) {
              /////// Main ///////////////
              // log("[Deck ID : ${snapshotMain.data!.deck_id}]");
              // log("[cards in deck : ${snapshotMain.data!.remaining}]");
              String deckId = snapshotMain.data!.deck_id!;
              future2 = cardApiService.drawCardFromDeck("/$deckId");
              /////////Seccond Future
              return FutureBuilder(
                future: future2,
                builder: (context, secondSnapshot) {
                  if (secondSnapshot.hasError) {
                    log("Error occured");
                    return const AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to load data'),
                    );
                  } else if (secondSnapshot.connectionState ==
                          ConnectionState.active ||
                      secondSnapshot.connectionState ==
                          ConnectionState.waiting) {
                    return const MyCustomDialogForDrawingCardFromDeck();
                  } else if (secondSnapshot.connectionState ==
                          ConnectionState.done &&
                      snapshotMain.hasData) {
                    ///////3rd FutureBuilder////////////////////
                    String deckId = secondSnapshot.data!.deckId!;
                    int counter = 0;
                    List<String> pileOneCodeList = [];
                    List<String> pileOneImageList = [];
                    List<String> pileOneValueList = [];
                    List<String> pileTwoCodeList = [];
                    List<String> pileTwoImageList = [];
                    List<String> pileTwoValueList = [];
                    int remainingCards = secondSnapshot.data!.remaining!;
                    log("Remaining Cards After removing   ${remainingCards.toString()}");
                    while (counter < 52) {
                      String cardToBeAdd =
                          secondSnapshot.data!.cards![counter].code!;
                      if (counter % 2 == 0) {
                        // log("Pile One ${secondSnapshot.data!.cards![counter].code}");
                        pileOneValueList
                            .add(secondSnapshot.data!.cards![counter].value!);
                        pileOneImageList
                            .add(secondSnapshot.data!.cards![counter].image!);
                        pileOneCodeList
                            .add(secondSnapshot.data!.cards![counter].code!);
                        future3 = cardApiService.addingCardsToPile(
                            deckId: "/$deckId",
                            pileUrl: "/pile",
                            pileName: "/pile1",
                            operationOnPile: "/add/?cards=$cardToBeAdd");
                      } else {
                        log("Pile Two ${secondSnapshot.data!.cards![counter].code}");
                        pileTwoValueList
                            .add(secondSnapshot.data!.cards![counter].value!);
                        pileTwoImageList
                            .add(secondSnapshot.data!.cards![counter].image!);
                        pileTwoCodeList
                            .add(secondSnapshot.data!.cards![counter].code!);
                        future3 = cardApiService.addingCardsToPile(
                            deckId: "/$deckId",
                            pileUrl: "/pile",
                            pileName: "/pile2",
                            operationOnPile: "/add/?cards=$cardToBeAdd");
                      }
                      counter++;
                    }
                    return FutureBuilder(
                      future: future3,
                      builder: (context, thirdSnapshot) {
                        if (thirdSnapshot.hasError) {
                          log("Error occured");
                          return const AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to load data'),
                          );
                        } else if (thirdSnapshot.connectionState ==
                                ConnectionState.active ||
                            thirdSnapshot.connectionState ==
                                ConnectionState.waiting) {
                          return const MyCustomDialogForSettingPile();
                        } else if (thirdSnapshot.connectionState ==
                                ConnectionState.done &&
                            thirdSnapshot.hasData) {
                          // log("Deck Id from third Snaphot ${thirdSnapshot.data!.deckId}");
                          String deckId = thirdSnapshot.data!.deckId!;
                          return MainPage(
                            deckId: deckId,
                            pileOneCodeList: pileOneCodeList,
                            pileOneImageList: pileOneImageList,
                            pileOneValueList: pileOneValueList,
                            pileTwoCodeList: pileTwoCodeList,
                            pileTwoImageList: pileTwoImageList,
                            pileTwoValueList: pileTwoValueList,
                          );
                        } else {
                          return const AlertDialog(
                            title: Text('No Data'),
                            content: Text('No data available'),
                          );
                        }
                      },
                    );
                  } else {
                    return const AlertDialog(
                      title: Text('No Data'),
                      content: Text('No data available'),
                    );
                  }
                },
              );
            } else {
              //Main /////////////////////////////
              return const AlertDialog(
                title: Text('No Data'),
                content: Text('No data available'),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 5,
            ),
            const Expanded(
                flex: 10,
                child: Row(children: [
                  Spacer(
                    flex: 20,
                  ),
                  Expanded(flex: 60, child: HomePageTitle()),
                  Spacer(
                    flex: 20,
                  ),
                ])),
            const Spacer(
              flex: 5,
            ),
            Expanded(
                flex: 60, child: Image.network(HomePageConstants.imagePath)),
            const Spacer(
              flex: 5,
            ),
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    const Spacer(
                      flex: 30,
                    ),
                    Expanded(
                        flex: 40,
                        child: ShaderMask(
                          shaderCallback: MyShaderMask.shaderMaskCallBack,
                          child: FloatingActionButton(
                            onPressed: onClickStartGame,
                            backgroundColor: Colors.white,
                            child: const Text(
                              "Start Game",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        )),
                    const Spacer(
                      flex: 30,
                    ),
                  ],
                )),
            const Spacer(
              flex: 5,
            )
          ],
        ),
      ),
    );
  }
}
