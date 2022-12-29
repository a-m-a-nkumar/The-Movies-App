import 'package:flutter/material.dart';

import '../discription.dart';
import '../utils/text.dart';

class toprated_movies extends StatelessWidget {

  final List toprated;

  const toprated_movies({Key? key,required this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modifiedtext(text: 'Top Rated Movies',color: Colors.white,size: 26,),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: toprated.length,
                itemBuilder: (context,index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(
                        name: toprated[index]['title'],
                        bannerurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['backdrop_path'],
                        posterurl: 'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path'],
                        description: toprated[index]['overview'],
                        vote: toprated[index]['vote_average'].toString(),
                        launch_on: toprated[index]['release_date'],
                      )));
                    },
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height:200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500'+toprated[index]['poster_path']
                                    )
                                )
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: modifiedtext(text: toprated[index]['title']!=null?
                            toprated[index]['title']:'Loading',
                                color: Colors.white,size:15),
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
