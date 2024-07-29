import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customButton.dart';

class CustomDropdown extends StatefulWidget {
  final ValueChanged<String> onChanged;

  CustomDropdown({required this.onChanged});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedGender = 'male'; // Default selected gender

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          _showGenderDialog(context);
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background color grey[100]
            borderRadius: BorderRadius.circular(10), // Rounded border radius
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedGender!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showGenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedGender = _selectedGender; // Store the initial selected gender

        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Container(
            width: 343,
            height: 370,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Gender",
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w700, color: Colors.black)),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.cancel),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildGenderOption('male', () {
                            selectedGender = 'male';
                          }),
                          _buildGenderOption('female', () {
                            selectedGender = 'female';
                          }),
                          _buildGenderOption('other', () {
                            selectedGender = 'other';
                          }),
                          _buildGenderOption('do_not_wish_to_specify', () {
                            selectedGender = 'do_not_wish_to_specify';
                          }),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    text: "Select",
                    onPressed: () {
                      if (selectedGender != null) {
                        setState(() {
                          _selectedGender = selectedGender; // Update selected gender in the main widget
                        });
                        widget.onChanged(selectedGender!); // Notify parent widget about the change
                      }
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGenderOption(String gender, VoidCallback onTapCallback) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0), // Add vertical margin
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(
          gender,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        onTap: () {
          onTapCallback(); // Call the callback to update selectedGender
        },
      ),
    );
  }
}
