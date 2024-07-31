import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/screens/location.dart';

import 'package:read/screens/profile.dart';
import 'package:read/screens/savedNews.dart';
import 'package:read/screens/search.dart';
import '../bloc/menu/menu_bloc.dart';
import '../bloc/menu/menu_event.dart';
import '../bloc/menu/menu_state.dart';
import '../landing_page/custom_appbar.dart';
import '../repositories/profileApi.dart';
import '../repositories/storage.dart';
import '../theme/image_resource.dart';
import 'languageScreen.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final secureStorageService = SecureStorageService();
    return Scaffold(
      appBar: LeadingApp(title: "Menu"),
      body: BlocProvider(
        create: (context) => MenuBloc(ProfileApiService(Dio(), secureStorageService)),
        child: MenuBody(),
      ),
    );
  }
}

class MenuBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<MenuBloc>().add(FetchUserProfile());

    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          child: BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (state is MenuLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MenuLoaded) {
                return _buildProfileCard(state.userProfile);
              } else if (state is MenuError) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              _buildGradientButton(context, 'Saved News'),
              const SizedBox(height: 20),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Language Preferences",style: TextStyle(color: Colors.black, fontSize: 16),)),
              const SizedBox(height: 5),
              _buildListTile(
                title: 'English - English',
                icon: Icons.arrow_forward_ios,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LanguageDesign(),
                    ),
                  );
                  // Add your onTap action here
                },
              ),
              const SizedBox(height: 10),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text("App Notification")),
              SizedBox(height: 5),
              _buildCustomSwitchTile(
                title: 'All Notification',
                value: true,
                onChanged: (bool value) {},
                secondaryText: 'Breaking News',
              ),
              SizedBox(height: 10),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text("News Preferences")),
              const SizedBox(height: 5),
              _buildListTile(
                  title: 'Preferred location and category',
                  icon: Icons.arrow_forward,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationCategorySelection(),
                      ),
                    );
                    // Add your onTap action here
                  }),
              const SizedBox(height: 10),
              _buildListTile(
                  title: 'Terms & Conditions',
                  icon:Icons.arrow_forward,
                  onTap: () {
                    // Add your onTap action here
                  }),
              const SizedBox(height: 10),
              _buildListTile(
                  title: 'Privacy Policies',
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add your onTap action here
                  }),
              const SizedBox(height: 10),
              _buildListTile(
                  title: 'Share App',
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add your onTap action here
                  }),
              const SizedBox(height: 10),
              _buildListTile(
                  title: 'About Us',
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Add your onTap action here
                  }),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> userProfile) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(ImageResource.splashlogo),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProfile['name'] ?? 'Unknown',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                userProfile['mobile_number'] ?? 'Unknown',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: ListTile(
        title: Text(title,style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),),

        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: Icon(icon),
        onTap: onTap,
      ),
    );
  }

  Widget _buildCustomSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
    required String secondaryText,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16,color: Colors.black),),
            Row(
              children: [
                Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: Colors.green[300],
                  thumbColor: MaterialStateProperty.all(Colors.green[600]),

                ),
                Text(secondaryText),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SavedNewsScreen(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
