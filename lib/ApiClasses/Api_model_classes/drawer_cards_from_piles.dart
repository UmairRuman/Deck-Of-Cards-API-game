class PileCardDrawer {
  bool? success;
  String? deckId;
  int? remaining;
  Piles? piles;
  List<Cards>? cards;

  PileCardDrawer(
      {this.success, this.deckId, this.remaining, this.piles, this.cards});

  PileCardDrawer.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    deckId = json['deck_id'];
    remaining = json['remaining'];
    piles = json['piles'] != null ? Piles.fromJson(json['piles']) : null;
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['deck_id'] = deckId;
    data['remaining'] = remaining;
    if (piles != null) {
      data['piles'] = piles!.toJson();
    }
    if (cards != null) {
      data['cards'] = cards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Piles {
  Discard? discard;

  Piles({this.discard});

  Piles.fromJson(Map<String, dynamic> json) {
    discard =
        json['discard'] != null ? Discard.fromJson(json['discard']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (discard != null) {
      data['discard'] = discard!.toJson();
    }
    return data;
  }
}

class Discard {
  int? remaining;

  Discard({this.remaining});

  Discard.fromJson(Map<String, dynamic> json) {
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['remaining'] = remaining;
    return data;
  }
}

class Cards {
  String? image;
  String? value;
  String? suit;
  String? code;

  Cards({this.image, this.value, this.suit, this.code});

  Cards.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    value = json['value'];
    suit = json['suit'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = image;
    data['value'] = value;
    data['suit'] = suit;
    data['code'] = code;
    return data;
  }
}
