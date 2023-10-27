import 'package:aaya_partner/constants/enums.dart';
import 'package:aaya_partner/controller/worker_controller.dart';
import 'package:aaya_partner/functions/get_location.dart';
import 'package:aaya_partner/functions/validate_email_id.dart';
import 'package:aaya_partner/repository/api_services/onboarding_services.dart';
import 'package:aaya_partner/screens/onboarding/document_verification_screen.dart';
import 'package:aaya_partner/screens/onboarding/verification_image_screen.dart';
import 'package:aaya_partner/screens/onboarding/verification_pending_screen.dart';
import 'package:aaya_partner/screens/widgets/aaya_button_widget.dart';
import 'package:aaya_partner/screens/widgets/aaya_text_field.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class WorkerOnboardingScreen extends StatefulWidget {
  const WorkerOnboardingScreen({super.key});

  @override
  State<WorkerOnboardingScreen> createState() => _WorkerOnboardingScreenState();
}

class _WorkerOnboardingScreenState extends State<WorkerOnboardingScreen> {
  FocusNode emailFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  PageController pageController = PageController();
  int selectedPageNumber = 1;
  DateTime? selectedDOB;
  Gender gender = Gender.male;
  XFile? profileImage;
  XFile? verificationImage;
  Position? position;
  bool isLoading = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This function will be called after the build is complete.
      getCurrentLocation().then((value) => position = value);

      if (Get.find<WorkerController>()
          .userData
          .value!
          .workerDetails
          .verificationImage
          .isNotEmpty) {
        pageController.animateToPage(2,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      } else if (Get.find<WorkerController>()
          .userData
          .value!
          .email
          .isNotEmpty) {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.15,
            child: SafeArea(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(),
                      ),
                      child: const Center(
                        child: Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.2,
                      height: 1,
                      color: Colors.black,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: selectedPageNumber >= 2
                            ? Theme.of(context).primaryColor
                            : null,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          "2",
                          style: TextStyle(
                              color: selectedPageNumber >= 2
                                  ? Colors.white
                                  : null),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.2,
                      height: 1,
                      color: Colors.black,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(),
                        color: selectedPageNumber >= 3
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          "3",
                          style: TextStyle(
                              color: selectedPageNumber >= 3
                                  ? Colors.white
                                  : null),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  selectedPageNumber = value + 1;
                });
              },
              controller: pageController,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Fill your personal details",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(227, 229, 239, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AayaTextFromField(
                                  onChanged: (e) {
                                    setState(() {});
                                  },
                                  titleText: "Name",
                                  size: size,
                                  hintText: "Name",
                                  controller: nameController,
                                  inputType: TextInputType.name,
                                  autoFocous: Get.find<WorkerController>()
                                      .userData
                                      .value!
                                      .email
                                      .isEmpty,
                                ),
                                AayaTextFromField(
                                  focusNode: emailFocusNode,
                                  onChanged: (e) {
                                    setState(() {});
                                  },
                                  titleText: "Email Id",
                                  size: size,
                                  hintText: "Email Id",
                                  controller: emailController,
                                  inputType: TextInputType.emailAddress,
                                  autoFocous: false,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 22, top: 8.0, bottom: 8),
                                  child: Text("DOB"),
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      emailFocusNode.unfocus();
                                      selectedDOB = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now().subtract(
                                          Duration(days: (365.25 * 14).toInt()),
                                        ),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now().subtract(
                                          Duration(days: (365.25 * 14).toInt()),
                                        ),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                  primary: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: size.width * 0.8,
                                      height: 55.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 24,
                                          ),
                                          selectedDOB == null
                                              ? Text(
                                                  "Pick an date",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .hintColor),
                                                )
                                              : Text(
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(selectedDOB!),
                                                ),
                                        ],
                                      )),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 22, top: 8.0, bottom: 8, right: 22),
                                  child: Text("Gender"),
                                ),
                                Center(
                                  child: Container(
                                    width: size.width * 0.8,
                                    height: 55.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: Gender.male,
                                                groupValue: gender,
                                                onChanged: (val) {
                                                  setState(() {
                                                    gender = val!;
                                                  });
                                                },
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Text(
                                                "Male",
                                                style: TextStyle(
                                                    fontWeight:
                                                        gender == Gender.male
                                                            ? FontWeight.bold
                                                            : null),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: Gender.female,
                                                groupValue: gender,
                                                onChanged: (val) {
                                                  setState(() {
                                                    gender = val!;
                                                  });
                                                },
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Text(
                                                "Female",
                                                style: TextStyle(
                                                    fontWeight:
                                                        gender == Gender.female
                                                            ? FontWeight.bold
                                                            : null),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: Gender.other,
                                                groupValue: gender,
                                                onChanged: (val) {
                                                  setState(() {
                                                    gender = val!;
                                                  });
                                                },
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Text(
                                                "Other",
                                                style: TextStyle(
                                                    fontWeight:
                                                        gender == Gender.other
                                                            ? FontWeight.bold
                                                            : null),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 22, top: 8.0, bottom: 8, right: 22),
                                  child: Text("Profile Photo"),
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      profileImage = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (profileImage != null) {
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      width: size.width * 0.8,
                                      height: 55.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.camera_alt),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(profileImage != null
                                              ? "Click to change selected Image"
                                              : "Click to select your photo")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AayaButtonWidget(
                            size: size,
                            isValidated: nameController.text.isNotEmpty &&
                                isEmailValid(emailController.text) &&
                                selectedDOB != null,
                            ontap: () async {
                              String? profileImagePath;
                              if (profileImage != null) {
                                profileImagePath = profileImage!.path;
                              }
                              setState(() {
                                isLoading = true;
                              });
                              bool isSuccess =
                                  await OnboardingServices.addBasicData(
                                model: BasicDetailModel(
                                    profileImage: profileImagePath,
                                    dob: selectedDOB!,
                                    email: emailController.text,
                                    gender: gender,
                                    latitude: position!.latitude,
                                    longitude: position!.longitude,
                                    name: nameController.text),
                              );
                              setState(() {
                                isLoading = false;
                              });
                              if (isSuccess) {
                                await pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              }
                            },
                            isLoading: isLoading,
                            buttonText: "Next")
                      ],
                    ),
                  ),
                ),
                VerficationImageScreen(
                  onNext: (recievedVerificationImage) async {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                ),
                DocumentVerificationScreen(
                  ontap: () {
                    Get.offAll(
                      const VerificationPandingScreen(),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
