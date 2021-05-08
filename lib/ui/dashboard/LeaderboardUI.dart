

import 'package:flutter/material.dart';
import 'package:rolldicegame/models/ModelLeaderBoard.dart';
import 'package:rolldicegame/ui/dashboard/bloc/LeaderBloc.dart';
import 'package:rolldicegame/utils/AppConstants.dart';
class LeaderScoreBoardUI extends StatelessWidget{


  final  bloc = LeaderBloc();


  @override
  Widget build(BuildContext context) {
    bloc.getScoreBoardList();
    return Scaffold(

      appBar: AppBar(automaticallyImplyLeading: true,
      title: Text("Leader Board"),
      ),

      body: Center(child: viewLeaderView( context)),

    );



  }


 // Handle the view by getting score board if their are
//  scores then list View render all the results
  //



Widget viewLeaderView(BuildContext context) {


    return StreamBuilder<List<ModelLeaderBoard>>(
      stream: bloc.leadersList,
      builder: (context, snapshot) {

        return snapshot.hasData ?
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(itemBuilder: (BuildContext context, int index) {
            var leader = snapshot.data[index];
            return Container(
              height: 60,
              child: Row(
                children: [
                  Text("${leader.score}",style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: appPrimaryColor),),
                  SizedBox(width: 10,),
                  Text("${leader.displayName}",style: TextStyle(fontSize: 18,color: Colors.black),),
                ],
              ),
            );

          },itemCount: snapshot.data.length,),
        ) : context.logoIconWidget();
      }
    );


}







}