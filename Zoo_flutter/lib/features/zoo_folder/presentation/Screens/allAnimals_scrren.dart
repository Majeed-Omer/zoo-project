import 'package:flutter/material.dart';  
  
  
class All_animals extends StatelessWidget {  
  
  List<String> images = [  
    "assets/bear.jpg",  
    "assets/Cobra.jpg",  
    "assets/eagle.jpg",  
    "assets/flamingo.webp",
    "assets/frog.jpg", 
    "assets/graff.jpg", 
    "assets/kro.jpg", 
    "assets/lion-zoo.jpg", 
    "assets/lizard.jpg", 
    "assets/monkey.jpg", 
    "assets/owl.jpg",   
    "assets/parrot.jpg", 
    "assets/zebra.jpg", 
    "assets/snacks.jpg", 
    "assets/sparrow.jpg", 
    "assets/elephant.jpg", 
    "assets/turkey.jpg",   
    "assets/turtle.jpg", 
  ];  
  
  @override  
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width; 
     
    return Scaffold(  
        appBar: AppBar(  
          title: Text("All animals"),  
        ),  
        body: Container(  
            padding: EdgeInsets.all(12.0),  
            child: GridView.builder(  
              itemCount: images.length,  
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 4.0,  
                  mainAxisSpacing: 4.0  
              ),  
              itemBuilder: (BuildContext context, int index){  
                return Image.asset(images[index], fit: BoxFit.fill,
              width: w / 2.5,
              height: h / 6.3,);  
              },  
            )),  
      ); 
     
  }  
}  