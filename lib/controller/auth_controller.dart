import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/model/user_model.dart';
import 'package:tiktok_clone/view/screens/auth/login_screen.dart';
import 'package:tiktok_clone/view/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  User get user => _user.value!;
  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  // To pick the profile image from gallery
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture !');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //Register and signup user
  void signUp(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String downloadUrl = await _uploadProPic(image);

        MyUser user = MyUser(
            name: username,
            profilePic: downloadUrl,
            email: email,
            uid: credential.user!.uid);

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Empty Field", "Please fill all the field");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error occurred Creating User", e.toString());
    }
  }

  //Upload profile pic in FireStore and download the uploaded image url
  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('ProfilePictures')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadPic = ref.putFile(image);
    TaskSnapshot snapshot = await uploadPic;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();

    return imageDwnUrl;
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print("Login Successfully");
      } else {
        Get.snackbar("Empty Field", "Please fill all the field");
      }
    } catch (e) {
      Get.snackbar("Error occurred to login", e.toString());
    }
  }

  void signOut () async {
    await FirebaseAuth.instance.signOut();
  }
}
