import 'package:flutter/material.dart';
import 'package:movies_app/utils/text.dart';

class Description extends StatelessWidget {
  final String name,description,bannerurl,posterurl,launch_on;
  final String vote;
  const Description({Key? key,required this.name,required this.description,required this.bannerurl,required this.posterurl,required this.launch_on,required this.vote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(bannerurl,fit: BoxFit.cover,),
                  )),

                ],
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container
                (
                  child: modifiedtext(text:'⭐ Average Rating -' +vote,color: Colors.yellow,size:25)
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: modifiedtext(text: name!=null?name:'Not Loaded', color: Colors.white, size: 24),
            ),
            Container(
              padding:EdgeInsets.only(left: 10),
                  child:modifiedtext(text: 'Releasing on - '+launch_on, color: Colors.white, size: 15,)
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width:100,
                  child:Image.network(posterurl),
                ),
                Flexible(
                  child: Container(
                    child: modifiedtext(text: description, color: Colors.white, size: 18),
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
