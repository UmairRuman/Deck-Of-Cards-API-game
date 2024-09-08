import 'dart:convert';
import 'dart:developer';

import 'package:api_deck_of_cards/ApiClasses/Api_model_classes/card_drawer.dart';
import 'package:api_deck_of_cards/ApiClasses/Api_model_classes/deck_creater_model.dart';
import 'package:api_deck_of_cards/ApiClasses/Api_model_classes/drawer_cards_from_piles.dart';
import 'package:api_deck_of_cards/ApiClasses/Api_model_classes/pile_creater.dart';
import 'package:http/http.dart';

extension on Response {
  bool get isSuccess => statusCode == 200;
}

abstract class ApiServices {
  String get baseUrl => "https://www.deckofcardsapi.com/api/deck";
  String get shuffleRemainingUrl => "";
  dynamic fetch(
      {String deckIdUrl = "",
      String operationOnDeckUrl = "",
      String pileUrl = "",
      String pileNameUrl = "",
      String operationOnPileUrl = ""}) async {
    var response = await get(Uri.parse(baseUrl +
        deckIdUrl +
        operationOnDeckUrl +
        pileUrl +
        pileNameUrl +
        operationOnPileUrl));
    if (response.isSuccess) {
      log('Fetch called ');
      return jsonDecode(response.body);
    }
    return null;
  }
}

class CardApiService extends ApiServices {
  Future<NewDeckCreater> newShuffledCardCreation(String newDeckID) async {
    Map<String, dynamic> newDeck = await fetch(deckIdUrl: newDeckID);
    return NewDeckCreater.fromMap(newDeck);
  }

  Future<CardDrawerFromDeck> drawCardFromDeck(String deckId) async {
    Map<String, dynamic> drawDeck =
        await fetch(deckIdUrl: deckId, operationOnDeckUrl: "/draw/?count=52");
    log("Fetch Function called");
    return CardDrawerFromDeck.fromJson(drawDeck);
  }

  Future<PileCreaterAndAdder> addingCardsToPile(
      {required String deckId,
      required String pileUrl,
      required String pileName,
      required String operationOnPile}) async {
    Map<String, dynamic> createPile = await fetch(
        deckIdUrl: deckId,
        pileUrl: pileUrl,
        pileNameUrl: pileName,
        operationOnPileUrl: operationOnPile);
    return PileCreaterAndAdder.fromJson(createPile);
  }

  Future<PileCardDrawer> drawCardByName(
      {required String deckId,
      required String pileUrl,
      required String pileName,
      required String operationOnPileUrl}) async {
    Map<String, dynamic> drawCard = await fetch(
        deckIdUrl: deckId,
        pileUrl: pileUrl,
        pileNameUrl: pileName,
        operationOnPileUrl: operationOnPileUrl);
    return PileCardDrawer.fromJson(drawCard);
  }

  Future<PileCardDrawer> drawCardFromTop(
      {required String deckId,
      required String pileUrl,
      required String pileName,
      String operationOnPileUrl = "/draw/random/?count=1"}) async {
    Map<String, dynamic> drawCard = await fetch(
        deckIdUrl: deckId,
        pileUrl: pileUrl,
        pileNameUrl: pileName,
        operationOnPileUrl: operationOnPileUrl);
    return PileCardDrawer.fromJson(drawCard);
  }

  Future<PileCardDrawer> drawCardFromBottom(
      {required String deckId,
      required String pileUrl,
      required String pileName,
      String operationOnPileUrl = "/draw/bottom"}) async {
    Map<String, dynamic> drawCard = await fetch(
        deckIdUrl: deckId,
        pileUrl: pileUrl,
        pileNameUrl: pileName,
        operationOnPileUrl: operationOnPileUrl);
    return PileCardDrawer.fromJson(drawCard);
  }

  Future<PileCardDrawer> drawCardRandomly(
      {required String deckId,
      required String pileUrl,
      required String pileName,
      String operationOnPileUrl = "/draw/random"}) async {
    Map<String, dynamic> drawCard = await fetch(
        deckIdUrl: deckId,
        pileUrl: pileUrl,
        pileNameUrl: pileName,
        operationOnPileUrl: operationOnPileUrl);
    return PileCardDrawer.fromJson(drawCard);
  }
}
