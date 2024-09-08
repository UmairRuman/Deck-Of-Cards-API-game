// ignore_for_file: public_member_api_docs, sort_constructors_first

class CardDrawerFromDeck {
  bool? success;
  String? deckId;
  List<Cards>? cards;
  int? remaining;

  CardDrawerFromDeck({this.success, this.deckId, this.cards, this.remaining});

  CardDrawerFromDeck.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    deckId = json['deck_id'];
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(Cards.fromJson(v));
      });
    }
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['deck_id'] = this.deckId;
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    data['remaining'] = this.remaining;
    return data;
  }
}

class Cards {
  String? code;
  String? image;
  Images? images;
  String? value;
  String? suit;

  Cards({this.code, this.image, this.images, this.value, this.suit});

  Cards.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    image = json['image'];
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
    value = json['value'];
    suit = json['suit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['image'] = this.image;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    data['value'] = this.value;
    data['suit'] = this.suit;
    return data;
  }
}

class Images {
  String? svg;
  String? png;

  Images({this.svg, this.png});

  Images.fromJson(Map<String, dynamic> json) {
    svg = json['svg'];
    png = json['png'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['svg'] = this.svg;
    data['png'] = this.png;
    return data;
  }
}
