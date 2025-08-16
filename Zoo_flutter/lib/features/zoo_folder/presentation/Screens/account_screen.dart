import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'register_screen.dart';
import '../Widgets/switch_button.dart';
import '../cubit/color_cubit.dart';

enum SocialMedia { facebook, instagram, email, linkedin, whatsapp }

class Account extends StatefulWidget {
  final String name;
  final String email;
  // ignore: prefer_typing_uninitialized_variables
  final image;

  const Account({super.key, required this.name, required this.email, required this.image});
  @override
  // ignore: library_private_types_in_public_api
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Widget imageBuilder(w) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Image.asset(
        'assets/sold.png',
        fit: BoxFit.cover,
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: const SwitchExample(),
          title: const Text("Account"),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton (
              icon: const Icon(Icons.logout),
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setBool("isLoggedIn", false);
                Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const RegisterScreen(),
                    ));
              },
            )
          ],
        ),
        body: BlocBuilder<ThemeCubit,ThemeState>(builder: (context, state) {
          return ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image ?? 'https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg'),
                    radius: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Tickets",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        TextButton(onPressed: () {}, child: const Text("See All")),
                      ]),
                  SizedBox(
                    height: h / 7,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        imageBuilder(70),
                        const SizedBox(
                          width: 10,
                        ),
                        imageBuilder(70),
                        const SizedBox(
                          width: 10,
                        ),
                        imageBuilder(70),
                        const SizedBox(
                          width: 10,
                        ),
                        imageBuilder(70),
                        const SizedBox(
                          width: 10,
                        ),
                        imageBuilder(70),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Reach us",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => share(SocialMedia.facebook),
                        // ignore: deprecated_member_use
                        icon: FaIcon(FontAwesomeIcons.facebookSquare,
                            size: h / 23, color: Colors.blue),
                      ),
                      IconButton(
                        
                          onPressed: () => share(SocialMedia.instagram),
                          icon: FaIcon(
                            // ignore: deprecated_member_use
                            FontAwesomeIcons.instagramSquare,
                            size: h / 23,
                            color: Colors.redAccent,
                          )),
                      IconButton(
                          onPressed: () => share(SocialMedia.linkedin),
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            size: h / 23,
                            color: const Color.fromARGB(255, 7, 69, 120),
                          )),
                      IconButton(
                          onPressed: () => share(SocialMedia.whatsapp),
                          icon: FaIcon(
                            // ignore: deprecated_member_use
                            FontAwesomeIcons.whatsappSquare,
                            size: h / 23,
                            color: Colors.lightGreenAccent,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ]);
        }));
  }

  Future share(SocialMedia socialMedia) async {
    final urls = {
      SocialMedia.facebook: 'https://www.facebook.com/majeed.omer.9/',
      SocialMedia.instagram: 'https://www.instagram.com/majeedomer1/',
      SocialMedia.linkedin:
          'https://www.linkedin.com/in/mom-two-581275243/?fbclid=IwAR3e2Zjk4ri6GEfaUCfvRNcNq9BQCGyP52inwZLOuwko0yjQ2tPsObTQTnI',
      SocialMedia.whatsapp: 'https://api.whatsapp.com/07508610867'
    };
    final url = urls[socialMedia]!;

    // ignore: deprecated_member_use
    if (!await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    }
  }
}
