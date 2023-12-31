import 'dart:io';
import 'package:aaya_partner/repository/api_services/onboarding_services.dart';
import 'package:aaya_partner/screens/widgets/aaya_button_widget.dart';
import 'package:aaya_partner/screens/widgets/aaya_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentVerificationScreen extends StatefulWidget {
  final Function() ontap;
  const DocumentVerificationScreen({super.key, required this.ontap});

  @override
  State<DocumentVerificationScreen> createState() =>
      _DocumentVerificationScreenState();
}

class _DocumentVerificationScreenState
    extends State<DocumentVerificationScreen> {
  bool isLoading = false;
  TextEditingController aadharNoController = TextEditingController();
  TextEditingController panNoController = TextEditingController();
  TextEditingController drivingController = TextEditingController();
  XFile? aadharFront;
  XFile? aadarBack;
  XFile? panFront;
  XFile? panBack;
  String? aadarNo;
  String? panN;
  XFile? drivingFront;
  XFile? drivingBack;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(227, 229, 239, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: size.width * 0.07, bottom: 12),
                      child: const Text(
                        "Aadhar Details *",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AayaTextFromField(
                        onChanged: (e) {
                          setState(() {});
                        },
                        size: size,
                        hintText: "Enter Aadhar number",
                        maxLength: 12,
                        controller: aadharNoController,
                        inputType: TextInputType.number,
                        autoFocous: false),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            XFile? pickingImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickingImage != null) {
                              aadharFront = pickingImage;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              image: aadharFront == null
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(aadharFront!.path),
                                      ),
                                    ),
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.camera_alt_rounded),
                                Text(aadharFront == null
                                    ? "Pick Front"
                                    : "Change Front"),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            XFile? pickingImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickingImage != null) {
                              aadarBack = pickingImage;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              image: aadarBack == null
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(aadarBack!.path),
                                      ),
                                    ),
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.camera_alt_rounded),
                                Text(aadarBack == null
                                    ? "Pick Back"
                                    : "Change Back"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: size.width * 0.07, bottom: 12),
                      child: const Text(
                        "Pan Card Details *",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AayaTextFromField(
                        onChanged: (e) {
                          setState(() {});
                        },
                        size: size,
                        hintText: "Enter Pan Card number",
                        maxLength: 12,
                        controller: panNoController,
                        inputType: TextInputType.text,
                        autoFocous: false),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            XFile? pickingImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickingImage != null) {
                              panFront = pickingImage;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              image: panFront == null
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(panFront!.path),
                                      ),
                                    ),
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.camera_alt_rounded),
                                Text(panFront == null
                                    ? "Pick Front"
                                    : "Change Front"),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            XFile? pickingImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickingImage != null) {
                              panBack = pickingImage;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              image: panBack == null
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(panBack!.path),
                                      ),
                                    ),
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.camera_alt_rounded),
                                Text(panBack == null
                                    ? "Pick Back"
                                    : "Change Back"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: size.width * 0.07, bottom: 12),
                      child: const Text(
                        "Driving License Details (Optional)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    AayaTextFromField(
                        onChanged: (e) {
                          setState(() {});
                        },
                        size: size,
                        hintText: "Enter Driving License ID",
                        maxLength: 12,
                        controller: drivingController,
                        inputType: TextInputType.text,
                        autoFocous: false),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            XFile? pickingImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickingImage != null) {
                              drivingFront = pickingImage;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              image: drivingFront == null
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(drivingFront!.path),
                                      ),
                                    ),
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.camera_alt_rounded),
                                Text(drivingFront == null
                                    ? "Pick Front"
                                    : "Change Front"),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            XFile? pickingImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickingImage != null) {
                              drivingBack = pickingImage;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              image: drivingBack == null
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(drivingBack!.path),
                                      ),
                                    ),
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(Icons.camera_alt_rounded),
                                Text(drivingBack == null
                                    ? "Pick Back"
                                    : "Change Back"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              child: AayaButtonWidget(
                  size: size,
                  isValidated: aadharFront != null &&
                      aadarBack != null &&
                      panFront != null &&
                      panBack != null &&
                      aadharNoController.text.length == 12 &&
                      panNoController.text.isNotEmpty,
                  ontap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    bool isSuccess = await OnboardingServices.verifyDocuments(
                        DocumentVerificationModel(
                            aadharNo: aadharNoController.text,
                            panNumber: panNoController.text,
                            aadharFront: aadharFront!.path,
                            panBack: panBack!.path,
                            panFront: panFront!.path,
                            aadharBack: aadarBack!.path,
                            drivingNumber: drivingController.text,
                            drivingBack:
                                drivingBack != null ? drivingBack!.path : null,
                            drivingFront: drivingFront != null
                                ? drivingFront!.path
                                : null));
                    setState(() {
                      isLoading = false;
                    });

                    if (isSuccess) {
                      widget.ontap();
                    }
                  },
                  isLoading: isLoading,
                  buttonText: "Submit"),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
