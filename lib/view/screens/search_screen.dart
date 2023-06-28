import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/search_controller.dart';
import 'package:tiktok_clone/model/user_model.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());
  // final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          title: TextFormField(
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for user!',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  MyUser user = searchController.searchedUsers[index];

                  return SafeArea(
                    child: ListTile(
                      onTap: () {
                        Get.to(
                          () => ProfileScreen(
                            uid: user.uid,
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
