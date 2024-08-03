import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geolocator/geolocator.dart';
import '../bloc/city/city_bloc.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/location/location_event.dart';
import '../bloc/location/location_state.dart';
import '../repositories/city_api.dart';
import '../repositories/locationMap_Service.dart';
import '../repositories/location_api.dart';
import '../repositories/profileApi.dart';
import '../repositories/storage.dart';
import '../ui_components/customButton.dart';
import 'cityScreen.dart';

class LocationCategorySelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final secureStorageService = SecureStorageService();

    return BlocProvider(
      create: (_) => LocationSelectionBloc(
        LocationApiService(Dio(), secureStorageService),
        ProfileApiService(Dio(), secureStorageService),
      ),
      child: LocationCategorySelectionView(),
    );
  }
}

class LocationCategorySelectionView extends StatefulWidget {
  @override
  _LocationCategorySelectionViewState createState() => _LocationCategorySelectionViewState();
}

class _LocationCategorySelectionViewState extends State<LocationCategorySelectionView> {
  final LocationService _locationService = LocationService();
  String _locationMessage = "";
  Map<String, String> _cityNames = {}; // Store city names with their IDs

  // Define TextEditingController instances
  final TextEditingController _primaryLocationController = TextEditingController();
  final TextEditingController _homeTownController = TextEditingController();
  final TextEditingController _cityOfChoiceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LocationSelectionBloc>().add(LoadCategories());
    context.read<LocationSelectionBloc>().add(LoadUserDetails());
  }

  @override
  void dispose() {
    _primaryLocationController.dispose();
    _homeTownController.dispose();
    _cityOfChoiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            title: 'Exit',
            desc: 'Do you want to Exit?',
            width: 400,
            btnOk: ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
            btnCancel: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ).show();
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                BlocBuilder<LocationSelectionBloc, LocationSelectionState>(
                  builder: (context, state) {
                    _cityNames = {
                      state.primaryLocation: _cityNames[state.primaryLocation] ?? state.primaryLocation,
                      state.homeTown: _cityNames[state.homeTown] ?? state.homeTown,
                      state.cityOfChoice: _cityNames[state.cityOfChoice] ?? state.cityOfChoice,
                    };

                    // Update controllers with the current values
                    _primaryLocationController.text = _cityNames[state.primaryLocation] ?? 'Select';
                    _homeTownController.text = _cityNames[state.homeTown] ?? 'Select';
                    _cityOfChoiceController.text = _cityNames[state.cityOfChoice] ?? 'Select';

                    return Text(
                      'Hi ${state.userName},',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    );
                  },
                ),
                SizedBox(height: 14),
                Text(
                  "Choose cities of your prefernce. We'll curate the news just for you!",
                  style: TextStyle(fontSize: 18, color: Colors.black),

                ),
                SizedBox(height: 24),
                BlocBuilder<LocationSelectionBloc, LocationSelectionState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Primary Location',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        buildDropdownButtonFormField(
                          context,
                          'Primary Location',
                          _primaryLocationController,
                              (newCityId) {
                            if (newCityId != null) {
                              context.read<LocationSelectionBloc>().add(
                                PrimaryLocationChanged(newCityId),
                              );
                            }
                          },
                          [_homeTownController.text , _cityOfChoiceController.text],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Secondary Location/Home Town',
                          style: TextStyle(fontSize: 16, color: Colors.black), ),
                        buildDropdownButtonFormField(
                          context,
                          'Home Town',
                          _homeTownController,
                              (newCityId) {
                            if (newCityId != null) {
                              context.read<LocationSelectionBloc>().add(
                                HomeTownChanged(newCityId),
                              );
                            }
                          },
                          [_primaryLocationController.text , _cityOfChoiceController.text],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'City of Choice',
                          style: TextStyle(fontSize: 16, color: Colors.black),  ),
                        buildDropdownButtonFormField(
                          context,
                          'City Of Choice',
                          _cityOfChoiceController,
                              (newCityId) {
                            if (newCityId != null) {
                              context.read<LocationSelectionBloc>().add(
                                CityOfChoiceChanged(newCityId),
                              );
                            }
                          },
                          [_primaryLocationController.text , _homeTownController.text],
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Category',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(height: 12),
                        state.categories.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: state.categories.map((category) {
                            bool isSelected = state.selectedCategories.contains(category.id);
                            return ChoiceChip(
                              label: Text(
                                category.name ?? '',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                List<String> updatedCategories = List.from(state.selectedCategories);
                                if (selected) {
                                  updatedCategories.add(category.id ?? '');
                                } else {
                                  updatedCategories.remove(category.id);
                                }
                                context.read<LocationSelectionBloc>().add(CategoriesChanged(updatedCategories));
                              },
                              selectedColor: Colors.red,
                              backgroundColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 24),
                        Center(
                          child: TextButton(
                            onPressed: () async {
                              try {
                                Position position = await _locationService.getCurrentLocation();
                                setState(() {
                                  _locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
                                });
                              } catch (e) {
                                setState(() {
                                  _locationMessage = "Error: ${e.toString()}";
                                });
                              }
                            },
                            child: Text(
                              'Use my current location',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
                            ),
                          ),
                        ),
                        if (_locationMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              _locationMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                          ),
                        SizedBox(height: 5,),
                        CustomButton(
                          text: 'Continue',
                          onPressed: state.primaryLocation != '' &&
                              state.homeTown != '' &&
                              state.cityOfChoice != ''
                              ? () {
                            context.read<LocationSelectionBloc>().add(
                              SubmitLocationSelection(),
                            );
                          }
                              : null,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownButtonFormField(
      BuildContext context,
      String hintText,
      TextEditingController controller,
      ValueChanged<String?>? onChanged,
      List<String> excludeList,
      ) {
    // Variable to store the selected city ID
    String? selectedCityId;

    return InkWell(
      onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CityBloc(CityApiService()),
              child: CityScreen(excludeLocations: excludeList),
            ),
          ),
        );

        if (result != null) {
          final cityData = result as Map<String, String>;
          final cityId = cityData['id'];
          final cityName = cityData['name'];
          if (cityId != null && cityName != null) {
            setState(() {
              _cityNames[cityId] = cityName;
              controller.text = cityName; // Update controller with the selected city's name
              selectedCityId = cityId; // Store the selected city ID
            });

            // Call onChanged with both city ID and city name
            if (onChanged != null && selectedCityId != null) {
              onChanged(selectedCityId);
            }
          }
        }
      },
      child: IgnorePointer(
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          value: _cityNames.keys.firstWhere(
                (id) => _cityNames[id] == controller.text,
            orElse: () => '', // Default value if no match is found
          ),
          onChanged: (selectedCityId) {
            if (selectedCityId != null) {
              final cityName = _cityNames[selectedCityId];
              setState(() {
                controller.text = cityName ?? '';
              });
              // Call onChanged with the selected city ID
              if (onChanged != null) onChanged(selectedCityId);
            }
          },
          items: _cityNames.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),
        ),
      ),
    );
  }



}
