import 'package:aaya_partner/functions/show_custom_snackbar.dart';
import 'package:aaya_partner/repository/api_services/auth_services.dart';
import 'package:aaya_partner/screens/widgets/aaya_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isValidated = false;
  bool isLoading = false;
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.3,
              ),
              const Text(
                "Enter the otp",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "A code has been sent to :",
                    style: TextStyle(
                        color: Color.fromRGBO(125, 120, 120, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "+91 ${widget.phoneNumber}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              ),
              Center(
                child: Pinput(
                  controller: otpController,
                  closeKeyboardWhenCompleted: false,
                  autofocus: true,
                  senderPhoneNumber: widget.phoneNumber,
                  length: 4,
                  onChanged: (e) {
                    if (e.length == 4) {
                      isValidated = true;
                    } else {
                      isValidated = false;
                    }
                    setState(() {});
                  },
                  errorText: "Invalid OTP",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 70,
        child: AayaButtonWidget(
          buttonText: "Submit OTP",
          size: size,
          isValidated: isValidated,
          isLoading: isLoading,
          ontap: () async {
            setState(() {
              isLoading = true;
            });
            bool res = await AuthServices.submitOtp(
                otp: otpController.text, phoneNumber: widget.phoneNumber);
            if (!res) {
              otpController.clear();
              // ignore: use_build_context_synchronously
              showCustomSnackBar(context, "Invalid OTP");
            }
            // ignore: use_build_context_synchronously
            isLoading = false;
            setState(() {});
          },
        ),
      ),
    );
  }
}
