import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'allAnimals_scrren.dart';

import 'animals_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = CarouselController();
  int activateIndex = 0;
  final sliderImages = [
    'assets/corn.jpg',
    'assets/rabbit.jpg',
    'assets/panda.jpg',
    'assets/tiger.webp'
  ];
  Widget itemBuilder(p, n) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return animal_details(p, n);
        }));
      },
      borderRadius: BorderRadius.circular(18),
      splashColor: Colors.blue[900],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
            Image.asset(
              p,
              fit: BoxFit.fill,
              width: w / 2.5,
              height: h / 6.3,
            ),
            Text(
              n,
              style: TextStyle(fontSize: h/40 , fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }

  Widget builImage(String sliderImage, int index) => Container(
        color: Colors.grey,
        child: Image.asset(
          sliderImage,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      );

      void animateToSlide(int index) => controller.animateTo(index.toDouble(), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  Widget buildIndicator() { 
    final h = MediaQuery.of(context).size.height;
    return AnimatedSmoothIndicator(
        activeIndex: activateIndex,
        count: sliderImages.length,
        effect: SwapEffect(dotHeight: (h / 55), dotWidth: (h / 55), activeDotColor: Colors.green),
        onDotClicked: animateToSlide,
      );
  }
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        elevation: 0.0,
        leading: const CircleAvatar(backgroundImage: AssetImage('assets/logo.jpg'),),
      ),
      body: ListView(
        children:[ Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Center(
                child: Stack(children: [
                  CarouselSlider.builder(
                      itemCount: sliderImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final sliderImage = sliderImages[index];
                        return builImage(sliderImage, index);
                      },
                      options: CarouselOptions(
                          height: (h / 6) + (w / 6),
                          viewportFraction: 1,
                          autoPlay: true,
                          
                          onPageChanged: ((index, reason) =>
                              setState(() => activateIndex = index)),
                          autoPlayInterval: const Duration(seconds: 2))),
                  Container(alignment: Alignment.center, padding: const EdgeInsets.symmetric(vertical: 10),child: buildIndicator(),),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mammals",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
          return All_animals();
        }));
                  }, child: const Text("See All")),
                ],
              ),
              SizedBox(
                height: h / 5,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    itemBuilder("assets/lion-zoo.jpg", "lion"),
                    const SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/elephant.jpg", "elephant"),
                    const SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/monkey.jpg", "monkey"),
                    const SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/zebra.jpg", "zebra"),
                    const SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/graff.jpg", "graff"),
                    const SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/bear.jpg", "bear"),
                    
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Birds",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
          return All_animals();
        }));
                  }, child: Text("See All")),
                ],
              ),
              SizedBox(
                height: h / 5,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                   
                    itemBuilder("assets/eagle.jpg", "eagle"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/owl.jpg", "owl"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/turkey.jpg", "turkey"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/sparrow.jpg", "sparrow"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/flamingo.webp", "flamingo"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/parrot.jpg", "parrot"),
                    
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reptiles",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
          return All_animals();
        }));
                  }, child: Text("See All")),
                ],
              ),
              SizedBox(
                height: h / 5,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    
                    itemBuilder("assets/kro.jpg", "crocodile"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/snacks.jpg", "snake"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/turtle.jpg", "turtle"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/lizard.jpg", "lizard"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/Cobra.jpg", "cobra"),
                    SizedBox(
                      width: 10,
                    ),
                    itemBuilder("assets/frog.jpg", "frog"),
                    
                  ],
                ),
              ),
            ],
          ),
        ),]
      ),
    );
  }
}
