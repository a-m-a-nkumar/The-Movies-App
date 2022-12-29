import 'package:flutter/material.dart';

import '../discription.dart';
import '../utils/text.dart';

class tv_series extends StatelessWidget {

  final List tv;

  const tv_series({Key? key,required this.tv}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modifiedtext(text: 'Popular Shows',color: Colors.white,size: 26,),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tv.length,
                itemBuilder: (context,index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(
                        name: tv[index]['original_name'],
                        bannerurl: 'https://image.tmdb.org/t/p/w500'+tv[index]['backdrop_path'],
                        posterurl: 'https://image.tmdb.org/t/p/w500'+tv[index]['poster_path'],
                        description: tv[index]['overview'],
                        vote: tv[index]['vote_average'].toString(),
                        launch_on: tv[index]['first_air_date'],
                      )));
                    },
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height:200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500'+tv[index]['poster_path']
                                    )
                                )
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: modifiedtext(text: tv[index]['original_name']!=null?
                            tv[index]['original_name']:'Loading',
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
