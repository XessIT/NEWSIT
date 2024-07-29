import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/welcome/welcome_bloc.dart';
import '../bloc/welcome/welcome_event.dart';
import '../bloc/welcome/welcome_state.dart';
import '../repositories/profileApi.dart';
import '../ui_components/customButton.dart';
import '../ui_components/customTextfield.dart';
import '../ui_components/dropdown.dart';
import '../repositories/storage.dart';
import 'location.dart'; // Import SecureStorageService

class WelcomeScreen extends StatefulWidget {
  final String? mobile;

  const WelcomeScreen({
    Key? key,
    this.mobile,
  }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  final SecureStorageService secureStorageService = SecureStorageService();
  String? _selectedGender = 'Male'; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    // Initialize the phone controller based on widget.mobile
    _phoneController = TextEditingController(text: widget.mobile ?? '');
    _dobController = TextEditingController();
    print("Mobile Number: ${widget.mobile}");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      _dobController.text = formattedDate;
    }
  }

  void _submitForm(BuildContext context) {
    final name = _nameController.text.isNotEmpty ? _nameController.text : "Unknown";
    final mobileNumber = _phoneController.text.isNotEmpty ? _phoneController.text : "Unknown";
    final dateOfBirth = _dobController.text.isNotEmpty ? _dobController.text : "1900-01-01";
    final gender = _selectedGender ?? "do_not_wish_to_specify";

    context.read<WelcomeBloc>().add(
      SubmitWelcomeForm(
        name: name,
        mobileNumber: mobileNumber,
        dateOfBirth: dateOfBirth,
        gender: gender,
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(
        profileApiService: ProfileApiService(Dio(), secureStorageService),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: BlocConsumer<WelcomeBloc, WelcomeState>(
              listener: (context, state) {
                if (state is WelcomeSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationCategorySelection()),
                  );
                } else if (state is WelcomeFailure) {
                  _showErrorDialog(context, state.error);
                }
              },
              builder: (context, state) {
                if (state is WelcomeLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Text(
                      'Welcome!',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'How can we call you?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: "Enter your Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone number',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      controller: _phoneController,
                      hintText: widget.mobile != null ? widget.mobile! : "Enter your phone number",
                      inputType: TextInputType.phone,
                      prefixIcon: Icon(Icons.phone),
                      readOnly: widget.mobile != null, // Set readOnly based on widget.mobile
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter Date of Birth',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          controller: _dobController,
                          hintText: "Select your DOB",
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Select Gender',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    CustomDropdown(
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    SizedBox(height: 200),
                    CustomButton(
                      text: "Get Started",
                      onPressed: () => _submitForm(context),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
