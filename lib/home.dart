import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman/sign_in.dart';
import 'package:wingman/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
      padding: const EdgeInsets.only(left: 15, right: 15),
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(
                  'Hi $name,',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromRGBO(90, 73, 248, 1)),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            child: Text(
              'HOME SCREEN',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade400),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              name = '';
              onboard = false;
              token = '';

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => SignIn()),
                  (route) => false);
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color.fromRGBO(255, 12, 12, 1)),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                'Log out',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }
}
