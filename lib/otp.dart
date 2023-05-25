import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wingman/home.dart';
import 'package:wingman/onboarding.dart';

import 'provider/provider_list.dart';
import 'utils/state.dart';

class EnterOtp extends ConsumerStatefulWidget {
  const EnterOtp({super.key, required this.phone});
  final String phone;
  @override
  ConsumerState<EnterOtp> createState() => _EnterOtpState();
}

class _EnterOtpState extends ConsumerState<EnterOtp> {
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = ref.watch(ProviderList.authProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(15),
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
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
                'Enter OTP',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'OTP has been sent to +91-${widget.phone}',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  otpField(controller: otp1),
                  otpField(controller: otp2),
                  otpField(controller: otp3),
                  otpField(controller: otp4),
                  otpField(controller: otp5),
                  otpField(controller: otp6),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'resend',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      color: const Color.fromRGBO(90, 73, 248, 1),
                      fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if((otp1.text +
                              otp2.text +
                              otp3.text +
                              otp4.text +
                              otp5.text +
                              otp6.text).length<6)return;
                  await authProvider
                      .verifyOTP(
                          otp: otp1.text +
                              otp2.text +
                              otp3.text +
                              otp4.text +
                              otp5.text +
                              otp6.text)
                      .then((value) {
                    if (authProvider.verifyOTPState == StateEnum.success) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => value == true
                                ? const Home()
                                : const OnBoarding()),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid OTP')));
                    }
                  });
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromRGBO(90, 73, 248, 1)),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20),
                  child: authProvider.verifyOTPState == StateEnum.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Verify',
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
        ));
  }

  otpField({required TextEditingController controller}) {
    return SizedBox(
      height: 55,
      width: 50,
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        style: GoogleFonts.lato(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          counterText: '',
          labelStyle: GoogleFonts.lato(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),

        // decoration: const InputDecoration(
        //     border: OutlineInputBorder(),
        //     counterText: '',
        //     hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
