

import 'package:flutter/material.dart';
import 'package:rolldicegame/models/ModelLeaderBoard.dart';
import 'package:rolldicegame/ui/dashboard/bloc/LeaderBloc.dart';
import 'package:rolldicegame/utils/AppConstants.dart';
class LeaderScoreBoardUI extends StatelessWidget{


  final  bloc = LeaderBloc();


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(automaticallyImplyLeading: true,
      title: Text("Leader Board"),
      ),
      floatingActionButton: FloatingActionButton.extended(label: Text("data"), onPressed: () {

        bloc.getScoreBoardList();

      },),
      body: viewLeaderView( context),

    );



  }

Widget  viewLeaderView(BuildContext context) {


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
        ) :Center(

          child: context.logoIconWidget(),

        );
      }
    );


}







}