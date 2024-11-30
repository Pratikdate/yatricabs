import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:yatricabs/provider.dart';



class LocationSearchDelegate extends SearchDelegate  {
  WidgetRef ref;
  final cityPosition;

  LocationSearchDelegate(this.ref,this.cityPosition);



  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    
    final cities = ref.watch(citiesProvider);

    final matchQuery = cities.where((city) {
      final cityName = city['city']?.toLowerCase() ?? '';
      final stateName = city['state']?.toLowerCase() ?? '';
      return cityName.contains(query.toLowerCase()) ||
          stateName.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final result = matchQuery[index];
        return ListTile(
          title: Text(result['city'] ?? 'Unknown City'),
          subtitle: Text(result['state'] ?? 'Unknown State'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final cities = ref.watch(citiesProvider);


    final matchQuery = cities.where((city) {
      final cityName = city['city']?.toLowerCase() ?? '';
      final stateName = city['state']?.toLowerCase() ?? '';
      return cityName.contains(query.toLowerCase()) ||
          stateName.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(

      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        final result = matchQuery[index];
        return InkWell(
          onTap: () {

            if(cityPosition=="Pick Up City")
              ref.read(selectPickUpCity.notifier).state=result['city'];
            if(cityPosition=="Drop City")
              ref.read(selectDropCity.notifier).state=result['city'];

            
            // Action when tapping on a suggestion
            close(context, result['city']);
          },
          child: Column(
            children: [
              Container(


                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //color: Colors.black,

                ),
                child: Row(
                  children: [
                    Icon(MaterialIcons.location_on,),
                    SizedBox(width: 10,),
                    Text(result['city'] ?? 'Unknown City',style: TextStyle(height: 3),),
                    Text(", "),
                    Text(result['state'] ?? 'Unknown State',style: TextStyle(height:3)),
                  ],


                ),
              ),
              Divider(color: Colors.black,height: 1,)
            ],
          ),
        );
      },
    );
  }
}
