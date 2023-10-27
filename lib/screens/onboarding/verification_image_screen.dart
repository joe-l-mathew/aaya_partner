import 'dart:io';

import 'package:aaya_partner/repository/api_services/onboarding_services.dart';
import 'package:aaya_partner/screens/widgets/aaya_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VerficationImageScreen extends StatefulWidget {
  const VerficationImageScreen({super.key, required this.onNext});
  final Function(XFile verificationImage) onNext;

  @override
  State<VerficationImageScreen> createState() => _VerficationImageScreenState();
}

class _VerficationImageScreenState extends State<VerficationImageScreen> {
  bool isLoading = false;
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: size.width * 0.9,
            height: size.height * 0.6,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(227, 229, 239, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: selectedImage != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text("Verification Image"),
                      ),
                      Center(
                        child: Container(
                          height: size.width * 0.8,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(selectedImage!.path)))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            selectedImage = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            if (selectedImage != null) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.8,
                            height: 55.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.camera_alt),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(selectedImage != null
                                    ? "Retake"
                                    : "Click to take your photo")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () async {
                        XFile? curremtSelectedImage = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (curremtSelectedImage != null) {
                          selectedImage = curremtSelectedImage;
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: size.width * 0.8,
                        height: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Click to take your photo")
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 60,
        child: AayaButtonWidget(
            size: size,
            isValidated: selectedImage != null,
            ontap: () async {
              setState(() {
                isLoading = true;
              });
              bool isSuccess = await OnboardingServices.addVerificationImage(
                  selectedImage!.path);
              setState(() {
                isLoading = false;
              });
              if (isSuccess) {
                widget.onNext(selectedImage!);
              }
            },
            isLoading: isLoading,
            buttonText: "Next"),
      ),
    );
  }
}
