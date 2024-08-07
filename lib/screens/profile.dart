import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../landing_page/custom_appbar.dart';
import '../repositories/profileApi.dart';
import '../repositories/storage.dart';
import '../theme/image_resource.dart';
import 'languageScreen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final secureStorageService = SecureStorageService();

    return BlocProvider(
      create: (context) => ProfileBloc(profileApiService: ProfileApiService(Dio(), secureStorageService)),
      child: ProfileScreen(),
    );
  }
}



class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;
  late SecureStorageService _secureStorageService;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _secureStorageService = SecureStorageService();
    _profileBloc.add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeadingApp(title: "My Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(ImageResource.splashlogo),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 130,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text('Name', style: TextStyle(color: Colors.grey[700])),
                  TextFormField(
                    key: ValueKey('name-${state.name}'), // Unique key
                    initialValue: state.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          _profileBloc.add(EditName('New Name'));
                        },
                        child: Text('Edit', style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Phone Number', style: TextStyle(color: Colors.grey[700])),
                  TextFormField(
                    key: ValueKey('phone-${state.phoneNumber}'), // Unique key
                    initialValue: state.phoneNumber,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          _profileBloc.add(ChangePhoneNumber('New Phone'));
                        },
                        child: Text('Change', style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('E-mail', style: TextStyle(color: Colors.grey[700])),
                  TextFormField(
                    key: ValueKey('email-${state.email}'), // Unique key
                    initialValue: state.email,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Date of Birth', style: TextStyle(color: Colors.grey[700])),
                  TextFormField(
                    key: ValueKey('dob-${state.dateOfBirth}'), // Unique key
                    initialValue: state.dateOfBirth,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Select Gender', style: TextStyle(color: Colors.grey[700])),
                  DropdownButtonFormField<String>(
                    key: ValueKey('gender-${state.gender}'), // Unique key
                    value: state.gender.isNotEmpty ? state.gender[0].toUpperCase() + state.gender.substring(1).toLowerCase() : null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: <String>['Male', 'Female', 'Other'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      _profileBloc.add(EditGender(newValue ?? 'Male'));
                    },
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LanguageDesign(),
                          ),
                        );
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      child: Text('Logout', style: TextStyle(color: Colors.red, fontSize: 14,fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showLogoutDialogAW(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Logout',
      desc: 'Are you sure you want to logout?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await _secureStorageService.clearAllTokens();
        Navigator.of(context).pushReplacementNamed('/');
      },
    )..show();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54, // Semi-transparent dark overlay
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.normal, // Regular font
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await _secureStorageService.clearAllTokens();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Bold font
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}





