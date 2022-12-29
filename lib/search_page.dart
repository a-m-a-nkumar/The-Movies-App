import 'package:flutter/material.dart';

class search_page extends SearchDelegate<String>{



  final movies=[];
  final recentmovies=[
    "Wednesday",
    "Ulice",
    "The Godfather",
    "Strange World"

  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return[
      IconButton(onPressed:(){
        query="";
      }, icon: Icon(Icons.clear,color: Colors.white,))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
     Navigator.pop(context);
    }, icon: AnimatedIcon(
    icon: AnimatedIcons.menu_arrow,color: Colors.white,
    progress: transitionAnimation,    ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList=query.isEmpty ? recentmovies:movies;
    return Container(
      color: Colors.black,
      child: ListView.builder(itemBuilder: (context,index)=>ListTile(
        leading: Icon(Icons.movie),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
      ),
    );
  }
  
}
