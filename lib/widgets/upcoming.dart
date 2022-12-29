import 'package:flutter/material.dart';

import '../discription.dart';
import '../utils/text.dart';

class up_coming_movies extends StatelessWidget {

  final List upcoming;

  const up_coming_movies({Key? key,required this.upcoming}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modifiedtext(text: 'Upcoming',color: Colors.white,size: 26,),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: upcoming.length,
                itemBuilder: (context,index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(
                        name: upcoming[index]['title'],
                        bannerurl: 'https://image.tmdb.org/t/p/w500'+upcoming[index]['backdrop_path'],
                        posterurl: 'https://image.tmdb.org/t/p/w500'+upcoming[index]['poster_path'],
                        description: upcoming[index]['overview'],
                        vote: upcoming[index]['vote_average'].toString(),
                        launch_on: upcoming[index]['release_date'],
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
                                        'https://image.tmdb.org/t/p/w500'+upcoming[index]['poster_path']
                                    )
                                )
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: modifiedtext(text: upcoming[index]['original_title']!=null?
                            upcoming[index]['original_title']:'Loading',
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
