import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/city/city_bloc.dart';
import '../bloc/city/city_event.dart';
import '../bloc/city/city_state.dart';
import '../ui_components/customTextfield.dart';

class CityScreen extends StatelessWidget {
  final List<String>? excludeLocations;

  CityScreen({Key? key, this.excludeLocations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cityBloc = BlocProvider.of<CityBloc>(context);
    final List<String> excludeList = excludeLocations ?? [];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 80.0),
              Expanded(
                child: Text(
                  'Search City',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          if (state is CityInitial) {
            cityBloc.add(FetchCities());
            return Center(child: CircularProgressIndicator());
          } else if (state is CityLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CityLoadSuccess) {
            final cities = state.cities.where((city) => !excludeList.contains(city.name)).toList();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'Auto Detect My Location',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  const CustomTextFormField(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        final city = cities[index];
                        return ListTile(
                          title: Text(
                            city.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.of(context).pop({'id': city.id, 'name': city.name});
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CityLoadFailure) {
            return Center(child: Text('Failed to load cities: ${state.error}'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}


