class PileCreaterAndAdder {
  bool? success;
  String? deckId;
  int? remaining;
  Piles? piles;

  PileCreaterAndAdder({this.success, this.deckId, this.remaining, this.piles});

  PileCreaterAndAdder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    deckId = json['deck_id'];
    remaining = json['remaining'];
    piles = json['piles'] != null ? new Piles.fromJson(json['piles']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['deck_id'] = this.deckId;
    data['remaining'] = this.remaining;
    if (this.piles != null) {
      data['piles'] = this.piles!.toJson();
    }
    return data;
  }
}

class Piles {
  Discard? discard;

  Piles({this.discard});

  Piles.fromJson(Map<String, dynamic> json) {
    discard =
        json['discard'] != null ? new Discard.fromJson(json['discard']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.discard != null) {
      data['discard'] = this.discard!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remaining'] = this.remaining;
    return data;
  }
}
