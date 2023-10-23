import 'package:aaya_partner/repository/api_services/auth_services.dart';
import 'package:aaya_partner/screens/auth/otp_screen.dart';
import 'package:aaya_partner/screens/auth/widgets/circle_widget.dart';
import 'package:aaya_partner/screens/widgets/aaya_button_widget.dart';
import 'package:aaya_partner/screens/widgets/aaya_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isValidated = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleWidget(),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.1),
              child: const Text(
                "Welcome to Aaya",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AayaTextFromField(
                autoFocous: true,
                focusNode: focusNode,
                maxLength: 10,
                inputType: TextInputType.phone,
                size: size,
                hintText: "97XXXXXX88",
                controller: phoneNumberController,
                onChanged: (val) {
                  if (val.isEmpty) {
                    isValidated = false;
                  }
                  if (val.length == 10) {
                    isValidated = true;
                    focusNode.unfocus();
                  } else {
                    isValidated = false;
                  }
                  setState(() {});
                },
                prefix: '+91'),
            const SizedBox(
              height: 20,
            ),
            AayaButtonWidget(
              buttonText: "Continue",
              size: size,
              isValidated: isValidated,
              isLoading: isLoading,
              ontap: () async {
                setState(() {
                  isLoading = true;
                });
                await AuthServices.sentOtp(
                    phoneNumber: phoneNumberController.text);
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OtpScreen(
                      phoneNumber: phoneNumberController.text,
                    ),
                  ),
                );
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
