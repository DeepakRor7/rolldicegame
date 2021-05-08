import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolldicegame/main.dart';
import 'package:rolldicegame/models/ModelScore.dart';
import 'package:rolldicegame/ui/dashboard/LeaderboardUI.dart';
import 'package:rolldicegame/ui/dashboard/bloc/UserBloc.dart';
import 'package:rolldicegame/utils/AppConstants.dart';
import 'package:rolldicegame/utils/SessionUtils.dart';

class DashboardUI extends StatelessWidget {
  var userInfo = UserBloc();

  @override
  Widget build(BuildContext context) {
    userInfo.getCurrentUser();
    userInfo.getCurrentScore();
    getUserLastScoreFromFirebase();

    return Scaffold(
      backgroundColor: Colors.blue[50],
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<ModelUserScore>(
            stream: userInfo.userScore,
            builder: (context, snapshot) {
              getUserLastScoreFromFirebase();
              var isAttemptLeft =
                  (snapshot.data != null && snapshot.data.leftChance > 0);
              return FloatingActionButton.extended(
                label: Text(isAttemptLeft ? "Roll Now" : "View Leader Board"),
                onPressed: () {
                  if (isAttemptLeft) {
                    userInfo.rollDice();
                    if (snapshot.data.leftChance == 1) {
                      saveScore();
                    }
                  } else {
                    context.open(LeaderScoreBoardUI());
                  }
                },
              );
            }),
      ),
      appBar: AppBar(
        title: StreamBuilder<FirebaseUser>(
            stream: userInfo.currentUser,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text(snapshot.data.phoneNumber)
                  : CircularProgressIndicator();
            }),
        actions: [
          Tooltip(
              message: "View Leader board",
              child: InkWell(
                  onTap: () {
                    context.open(LeaderScoreBoardUI());
                  },
                  child: Icon(Icons.leaderboard_sharp))),
          InkWell(
            onTap: () {
              context
                  .showBottomMsgWithAction("Do you want to log out?",
                      actionText: "Logout", dismissText: "Cancel")
                  .then((value) {
                if (value) {
                  logoutCurrentUser(context);
                }
              });
            },
            child: Tooltip(
              message: "Logout",
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Icon(Icons.logout),
              ),
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
                stream: userInfo.score,
                initialData: 1,
                builder: (context, snapshot) {
                  return Image.asset("assets/images/dice${snapshot.data}.png");
                }),
            SizedBox(
              height: 50,
            ),
            StreamBuilder<ModelUserScore>(
                stream: userInfo.userScore,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "${snapshot.data?.totalScore}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text("Your Score"),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "${snapshot.data?.leftChance}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text("Roll Left"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  /*
  * When no attempts left then get
  * score from session and save to firebase
  * */
  Future<void> saveScore() async {
    //firebase auth instance to get uuid of user
    FirebaseUser auth = await FirebaseAuth.instance.currentUser();
    var score = await getSession(sesScore);

    Firestore.instance.collection(docPlayers).document(auth.uid).setData(
        {'displayName': auth.phoneNumber, 'uid': auth.uid, 'score': score});

    return;
  }

  /*
  * Clear session and remove
  * firebase user session
  */
  void logoutCurrentUser(BuildContext context) async {
    await removeSession();
    await FirebaseAuth.instance.signOut();
    context.openReplace(Splash());
  }

  getUserLastScoreFromFirebase() async {
    var currentUserID = await FirebaseAuth.instance.currentUser();

    Firestore.instance
        .collection(docPlayers)
        .where("uid = $currentUserID")
        .getDocuments()
        .then((value) {
      if (value.documents.length > 0) {
        saveInt(sesScore, value.documents[0].data["score"]);
        saveInt(sesLeftAttempt, 0);
      }
    });
  }
}
