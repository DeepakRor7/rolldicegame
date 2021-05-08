import 'dart:math';

import 'package:rolldicegame/models/ModelScore.dart';
import 'package:rolldicegame/utils/SessionUtils.dart';
import 'package:rxdart/subjects.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserBloc {
  var _userInfo = PublishSubject<FirebaseUser>();
  var _userScore = PublishSubject<ModelUserScore>();

  var _score = PublishSubject<int>();

  Stream<FirebaseUser> get currentUser => _userInfo.stream;

  Stream<ModelUserScore> get userScore => _userScore.stream;

  Stream<int> get score => _score.stream;

  getCurrentUser() async {
    var user = await FirebaseAuth.instance.currentUser();
    _userInfo.sink.add(user);
  }

  getCurrentScore() async {
    var user = ModelUserScore();
    user.totalScore = await getSession(sesScore) ?? 0;
    user.leftChance = await getSession(sesLeftAttempt) ?? 0;
    _userScore.sink.add(user);
  }

  rollDice() async {
    var score = Random().nextInt(6) + 1;

    await saveInt(sesScore, (await getSession(sesScore)?? 0) + score);
    await saveInt(
        sesLeftAttempt, (await getSession(sesLeftAttempt)?? 0 ) + 1);
    _score.sink.add(score);
    getCurrentScore();
  }

  dispose() {
    _userInfo.close();
    _userScore.close();
    _score.close();
  }
}
