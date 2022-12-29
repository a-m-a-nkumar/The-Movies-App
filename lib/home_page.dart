import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/search_page.dart';
import 'package:movies_app/widgets/upcoming.dart';

import 'package:movies_app/model/user_model.dart';
import 'package:movies_app/utils/text.dart';
import 'package:movies_app/widgets/Popularshows.dart';
import 'package:movies_app/widgets/toprated.dart';
import 'package:movies_app/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  User? user = FirebaseAuth.instance.currentUser;
  user_model loggedInUser = user_model();

  List trendingmovies=[];
  List topratedmovies=[];
  List tv=[];
  List upcomingmovies=[];


  //late String query;
  final String apikey='8b40b3efd37f96b9b49ef33e1eeaa9ba';
  final readaccesstoken='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YjQwYjNlZmQzN2Y5NmI5YjQ5ZWYzM2UxZWVhYTliYSIsInN1YiI6IjYzYTZlYzVlMzg5ZGExMDA3YTc3MDczNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Nm_E5FK_MNfH88OgmiqyroyFgBE0S6zVvfnseNf0Yd4';

  @override
  void initState() {
    // TODO: implement initState
    loadmovies();
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = user_model.fromMap(value.data());
      setState(() {});
    });
  }

  loadmovies()async{
  TMDB tmdbWithCustomLogs= TMDB(
      ApiKeys(apikey,readaccesstoken),
      logConfig: ConfigLogger(
      showLogs: true,
    showErrorLogs: true,
  ));
  Map trendingresult=await tmdbWithCustomLogs.v3.trending.getTrending();
  Map topratedresult=await tmdbWithCustomLogs.v3.movies.getTopRated();
  Map tvresult=await tmdbWithCustomLogs.v3.tv.getPopular();

  Map upcomingresult=await tmdbWithCustomLogs.v3.movies.getUpcoming();
  setState(() {
    trendingmovies=trendingresult['results'];
    topratedmovies=topratedresult['results'];
    tv=tvresult['results'];
    upcomingmovies=upcomingresult['results'];
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: modifiedtext(text:'Welcome ${loggedInUser.firstname},',color:Colors.black,size: 20,),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: search_page());
          }, icon: Icon(Icons.search,color: Colors.black,))
        ],
      ),
      drawer: Drawer(

        backgroundColor: Colors.black,
        child:
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60,50,60,0),
                      child: Container(
                          height: 300,
                          width: 300,
                          child: Image.asset(
                            'assets/user.png',
                            color: Colors.white,
                          )
                      ),
                    ),
                    modifiedtext(text:'${loggedInUser.firstname}',color:Colors.white,size: 20,),
                      Padding(
                      padding: EdgeInsets.fromLTRB(0, 350, 0, 0),
                      child: Container(
                        height: 50,
                        width: 200,

                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if(states.contains(MaterialState.pressed)){
                                return Colors.black26;
                              }
                              return Colors.grey;
                            }),                      ),
                          child:Text('Sign Out'),
                          onPressed: (){
                            logout(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
      ),
      body: ListView(

        children: [
          trending_movies(trending:trendingmovies),
          toprated_movies(toprated: topratedmovies),
          tv_series(tv:tv),
          up_coming_movies(upcoming: upcomingmovies),
        ],
      ),
      backgroundColor: Colors.black,
    );

  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => login_page()));
  }
}