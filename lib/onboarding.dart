import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wingman/provider/auth_provider.dart';
import 'package:wingman/utils/constants.dart';
import 'package:wingman/utils/state.dart';

import 'home.dart';
import 'provider/provider_list.dart';

class OnBoarding extends ConsumerStatefulWidget {
  const OnBoarding({super.key});

  @override
  ConsumerState<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends ConsumerState<OnBoarding> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var authProvider = ref.watch(ProviderList.authProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(15),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 26,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    // padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset("assets/logo.svg",
                        height: 40,
                        width: 40,
                        color: const Color.fromRGBO(90, 73, 248, 1)),
                  ),
                  Text(
                    'Looks like you are new here. Tell us a bit about yourself.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Name',
                          style: GoogleFonts.lato(
                              color: Colors.black, fontSize: 18),
                        ),
                        TextSpan(
                          text: ' *',
                          style: GoogleFonts.lato(
                              color: Colors.red.shade700, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                      controller: name,
                      onChanged: (val) {
                        // if(!formKey.currentState!.validate()){
                        //   formKey.currentState!.reset();
                        // }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*required';
                        }
                        return null;
                      },
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      decoration: txtFieldDecoration),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Email',
                          style: GoogleFonts.lato(
                              color: Colors.black, fontSize: 18),
                        ),
                        TextSpan(
                          text: ' *',
                          style: GoogleFonts.lato(
                              color: Colors.red.shade700, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*required";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "*Please enter valid email";
                        }
                        return null;
                      },
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      decoration: txtFieldDecoration),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await authProvider
                            .updateProfile(userName: name.text, email: email.text)
                            .then((value) {
                          if (authProvider.profileState == StateEnum.success) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                (route) => false);
                          }
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromRGBO(90, 73, 248, 1)),
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20),
                      child: authProvider.profileState == StateEnum.loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Continue',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
