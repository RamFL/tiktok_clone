import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/user_model.dart';

class SearchController extends GetxController {
  final Rx<List<MyUser>> _searchedUsers = Rx<List<MyUser>>([]);

  List<MyUser> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _searchedUsers.bindStream(FirebaseFirestore.instance
        .collection('Users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<MyUser> retValues = [];

      for (var element in query.docs) {
        retValues.add(MyUser.fromJson(element));
      }
      return retValues;
    }));
  }
}
