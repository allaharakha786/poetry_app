import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/getxControllers/poetry_controller.dart';
import 'package:google_maps/controllers/utills/notification_file.dart';
import 'package:quickalert/quickalert.dart';

void showCustomAlertDialog(BuildContext context, GlobalKey<FormState> key, String id) {
  PoetryController poetryController = Get.put(PoetryController());

  TextEditingController nameController = TextEditingController();
  TextEditingController textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFF4A6990),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Center(
            child: Text(
          'Post your poetry',
          style: TextStyle(color: Colors.white, fontFamily: 'boldFont'),
        )),
        content: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add your name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: const Color.fromARGB(170, 255, 255, 255),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: const Color.fromARGB(170, 255, 255, 255),
                  )),
                  hintText: 'Enter name',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'boldFont'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                style: TextStyle(color: Colors.white, fontFamily: 'boldFont'),
                controller: textController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill this field';
                  }
                  return null;
                },
                maxLines: 3,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: const Color.fromARGB(170, 255, 255, 255),
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: const Color.fromARGB(170, 255, 255, 255),
                  )),
                  hintStyle: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'boldFont'),
                  hintText: 'Enter poetry',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xFF20375A),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'boldFont'),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xFF20375A), // Dark blue, // Button color
                    ),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        poetryController.isLoading.value = true;
                        await FirebaseFirestore.instance.collection('pendingFeeds').doc().set({'name': nameController.text, 'text': textController.text, 'userId': id, 'time': '${DateTime.now()}'}).then((value) {
                          poetryController.isLoading.value = false;
                          Get.back();
                        });
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Your poetry is successfully submitted and is now under review!',
                        );
                        poetryController.dataLength();

                        Future.delayed(Duration(seconds: 2), () {
                          NotificationFile().showNotification('Poetry Under Review', 'Your poetry is under review and will be approved soon', 'pending');
                        });
                      }
                    },
                    child: Obx(() {
                      return poetryController.isLoading.value
                          ? Center(child: SpinKitThreeBounce(size: 30, color: Colors.white))
                          : Text(
                              'Add Poetry',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'boldFont'),
                            );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
