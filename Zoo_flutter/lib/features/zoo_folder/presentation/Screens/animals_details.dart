import 'package:flutter/material.dart';

class animal_details extends StatefulWidget {
  String p;
  String n;

  animal_details(this.p, this.n);

  @override
  _animal_detailsState createState() => _animal_detailsState();
}

class _animal_detailsState extends State<animal_details> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width; 
    return Scaffold(
      appBar: AppBar(
        title: Text("animal_detail"),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.p,
              width: double.infinity,
              fit: BoxFit.fill,
              height: h/2 ,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.n,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Lions have strong, compact bodies and powerful forelegs, teeth and jaws for pulling down and killing prey. Their coats are yellow-gold, and adult males have shaggy manes that range in color from blond to reddish-brown to black. The length and color of a lion's mane is likely determined by age, genetics and hormones. Young lions have light spotting on their coats that disappears as they grow.Without their coats, lion and tiger bodies are so similar that only experts can tell them apart."),
            )
          ],
        ),
      ),
    );
  }
}
