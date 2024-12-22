import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps/controllers/utills/shared_preferences.dart';

class PoetryController extends GetxController {
  RxList<String> data = MySharedPreferences.getStringList('myList').obs;
  RxBool isLoading = false.obs;
  RxInt pendingPoetry = 0.obs;

  dataLength() async {
    String id = await MySharedPreferences.getString('userId');
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance.collection('pendingFeeds').where('userId', isEqualTo: id).get();
    pendingPoetry.value = data.docs.length;
  }
}
