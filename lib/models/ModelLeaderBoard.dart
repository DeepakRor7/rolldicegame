



import 'dart:convert';


  ModelLeaderBoard modelLeaderBoardFromJson(String str) => ModelLeaderBoard.fromJson(json.decode(str));

  String modelLeaderBoardToJson(ModelLeaderBoard data) => json.encode(data.toJson());

  class ModelLeaderBoard {
  ModelLeaderBoard({
  this.score,
  this.uid,
  this.displayName,
  });

  int score;
  String uid;
  String displayName;

  factory ModelLeaderBoard.fromJson(Map<String, dynamic> json) => ModelLeaderBoard(
  score: json["score"],
  uid: json["uid"],
  displayName: json["displayName"],
  );

  Map<String, dynamic> toJson() => {
  "score": score,
  "uid": uid,
  "displayName": displayName,
  };
  }



