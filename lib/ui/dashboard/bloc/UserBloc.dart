import 'dart:math';

import 'package:rolldicegame/models/ModelScore.dart';
import 'package:rolldicegame/utils/AppConstants.dart';
import 'package:rolldicegame/utils/SessionUtils.dart';
import 'package:rxdart/subjects.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserBloc {

  // Observable objects
  var _userInfo = PublishSubject<FirebaseUser>();
  var _userScore = PublishSubject<ModelUserScore>();
  var _score = PublishSubject<int>();

  // Streams
  Stream<FirebaseUser> get currentUser => _userInfo.stream;
  Stream<ModelUserScore> get userScore => _userScore.stream;
  Stream<int> get score => _score.stream;

  // this funtion will get the user info from
  // firebase and add it to userInfo sink
  getCurrentUser() async {
    var user = await FirebaseAuth.instance.currentUser();
    _userInfo.sink.add(user);
  }

  // this function will give get the user score and left attempt from
  // session and bind them to a single object and this object is sink by
  // userScore sink
  getCurrentScore() async {
    var user = ModelUserScore();
    user.totalScore = await getSession(sesScore) ?? 0;
    user.leftChance = await getSession(sesLeftAttempt) ?? totalAttempts;
    _userScore.sink.add(user);
  }

  // Roll dice will get random number b/w 1-6
  // and save the score in session by getting last score
  // also make decrement in left session
  // them add in _score sink
  // refresh current score view
  rollDice() async {
    var score = Random().nextInt(6) + 1;

    await saveInt(sesScore, (await getSession(sesScore)?? 0) + score);
    await saveInt(
        sesLeftAttempt, (await getSession(sesLeftAttempt)?? totalAttempts ) - 1);
    _score.sink.add(score);
    getCurrentScore();
  }


  // call when class dispose
  dispose() {
    _userInfo.close();
    _userScore.close();
    _score.close();
  }
}
