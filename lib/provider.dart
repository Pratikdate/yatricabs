


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class TripNotifier extends StateNotifier<String> {
  TripNotifier(this.ref) : super("Outstation_Trip");

  final Ref ref;

  void setTripType(String tripType) {
    state = tripType;

    ref.read(selectPickUpCity.notifier).state = null;
    ref.read(selectDropCity.notifier).state = null;
    ref.read(pickUpDate.notifier).state = null;
    ref.read(fromDate.notifier).state = null;
    ref.read(toDate.notifier).state = null;
  }
}

final tripNotifierProvider = StateNotifierProvider<TripNotifier, String>(
      (ref) => TripNotifier(ref),
);



class WayNotifier extends StateNotifier<String> {
  WayNotifier(this.ref) : super("One-way");

  final Ref ref;

  void setWayType(String wayType) {
    state = wayType;

    ref.read(selectPickUpCity.notifier).state = null;
    ref.read(selectDropCity.notifier).state = null;
    ref.read(pickUpDate.notifier).state = null;
    ref.read(fromDate.notifier).state = null;
    ref.read(toDate.notifier).state = null;
  }
}

final wayNotifierProvider = StateNotifierProvider<WayNotifier, String>(
      (ref) => WayNotifier(ref),
);

final selectPickUpCity = StateProvider<String?>((ref) => null);
final selectDropCity = StateProvider<String?>((ref) => null);
final pickUpDate = StateProvider<String?>((ref) => null);
final fromDate = StateProvider<String?>((ref) => null);
final toDate = StateProvider<String?>((ref) => null);


final citiesProvider = StateProvider<List<Map<String, String>>>((ref) {
  return [
    // Maharashtra
    {"city": "Mumbai", "state": "Maharashtra"},
    {"city": "Pune", "state": "Maharashtra"},
    {"city": "Nagpur", "state": "Maharashtra"},
    {"city": "Nashik", "state": "Maharashtra"},
    {"city": "Aurangabad", "state": "Maharashtra"},

    // Delhi
    {"city": "Delhi", "state": "Delhi"},

    // Karnataka
    {"city": "Bengaluru", "state": "Karnataka"},
    {"city": "Mysuru", "state": "Karnataka"},
    {"city": "Hubballi", "state": "Karnataka"},
    {"city": "Mangaluru", "state": "Karnataka"},
    {"city": "Belagavi", "state": "Karnataka"},

    // Telangana
    {"city": "Hyderabad", "state": "Telangana"},
    {"city": "Warangal", "state": "Telangana"},
    {"city": "Nizamabad", "state": "Telangana"},
    {"city": "Karimnagar", "state": "Telangana"},
    {"city": "Khammam", "state": "Telangana"},

    // Gujarat
    {"city": "Ahmedabad", "state": "Gujarat"},
    {"city": "Surat", "state": "Gujarat"},
    {"city": "Vadodara", "state": "Gujarat"},
    {"city": "Rajkot", "state": "Gujarat"},
    {"city": "Bhavnagar", "state": "Gujarat"},

    // Tamil Nadu
    {"city": "Chennai", "state": "Tamil Nadu"},
    {"city": "Coimbatore", "state": "Tamil Nadu"},
    {"city": "Madurai", "state": "Tamil Nadu"},
    {"city": "Tiruchirappalli", "state": "Tamil Nadu"},
    {"city": "Salem", "state": "Tamil Nadu"},

    // West Bengal
    {"city": "Kolkata", "state": "West Bengal"},
    {"city": "Asansol", "state": "West Bengal"},
    {"city": "Siliguri", "state": "West Bengal"},
    {"city": "Durgapur", "state": "West Bengal"},
    {"city": "Howrah", "state": "West Bengal"},

    // Rajasthan
    {"city": "Jaipur", "state": "Rajasthan"},
    {"city": "Jodhpur", "state": "Rajasthan"},
    {"city": "Udaipur", "state": "Rajasthan"},
    {"city": "Kota", "state": "Rajasthan"},
    {"city": "Bikaner", "state": "Rajasthan"},

    // Uttar Pradesh
    {"city": "Lucknow", "state": "Uttar Pradesh"},
    {"city": "Kanpur", "state": "Uttar Pradesh"},
    {"city": "Varanasi", "state": "Uttar Pradesh"},
    {"city": "Agra", "state": "Uttar Pradesh"},
    {"city": "Meerut", "state": "Uttar Pradesh"},
  ];
});
