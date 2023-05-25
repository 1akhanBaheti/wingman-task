import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wingman/utils/state.dart';
import '/provider/provider_list.dart';

import 'otp.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  TextEditingController phone = TextEditingController();
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
                    'Wingman Inc is a reputed mobile app development, and web development company, the best IT Software Solutions provider based in India, established in 2017. Apart from this, we also provide digital marketing & outsourcing services.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Text(
                    'Get Started',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: phone,
                    enabled: true,
                    validator: (value) {
                      if (value!.isEmpty) return '*Please enter mobile no.';
                      if (value.length != 10)
                        return '*Please enter valid mobile no.';
                      return null;
                    },
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w600),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red.shade600, width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red.shade600, width: 2.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        prefixIconColor: Colors.black,
                        counterText: '',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Mobile No.',
                        hintStyle: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500),
                        labelStyle: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        prefix: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(
                            '+91',
                            style: GoogleFonts.lato(
                                fontSize: 18, color: Colors.black),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!formKey.currentState!.validate()) return;
                      await authProvider.sendOTP(phone: phone.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnterOtp(
                                    phone: phone.text,
                                  )));
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromRGBO(90, 73, 248, 1)),
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20),
                      child: authProvider.sendOTPState == StateEnum.loading
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
