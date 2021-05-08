import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rolldicegame/models/ModelLeaderBoard.dart';
import 'package:rolldicegame/utils/AppConstants.dart';
import 'package:rxdart/subjects.dart';


class LeaderBloc {

  var _leaderList = PublishSubject<List<ModelLeaderBoard>>();

  Stream<List<ModelLeaderBoard>> get leadersList => _leaderList.stream;



  void getScoreBoardList() async{


    Firestore.instance.collection(docPlayers)
        .orderBy("score",descending: true).getDocuments().then((value) {

          var data = value.documents;
          var list = List<ModelLeaderBoard>();
          for(var item in data){
            list.add(ModelLeaderBoard.fromJson(item.data));
           }
          _leaderList.sink.add(list);



    });


  }


  dispose(){

    _leaderList.close();


  }


}


