import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:yatricabs/provider.dart';
import 'package:yatricabs/search_locations.dart';

class ExploreCabsPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ExploreCabsPage> createState() => _ExploreCabsPageState();
}

class _ExploreCabsPageState extends ConsumerState<ExploreCabsPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final List<List<dynamic>> Outstation_Trip = [
    ["asset/Rectangle 1422 (1).png", "Pick Up City", "Type City Name"],
    ["asset/Group (1).png", 'Drop City', 'Type City Name'],
    ["asset/Frame.png", 'Pick-up Date', 'DD-MM-YYYY'],
    ["asset/Group (2).png", 'Time', 'HH:MM']
  ];

  final List<List<dynamic>> Local_Trip = [
    ["asset/Rectangle 1422 (1).png", "Pick Up City", "Type City Name"],
    ["asset/Group (1).png", 'Destination', 'Type City Name'],
    ["asset/Group (3).png", 'Pick-up Date', 'DD-MM-YYYY'],
  ];

  final List<List<dynamic>> Airport_Transfer = [
    ["asset/Rectangle 1422 (1).png", "Pick Up City", "Type City Name"],
    ["asset/Group 7423.png", 'Pick Up Date', 'DD-MM-YYYY'],
    ["asset/Group (3).png", 'Time', 'HH-MM'],
  ];


  Future<void> _selectDate(BuildContext context,StateProvider<String?> provider,WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null ) {
      ref.read(provider.notifier).state=picked.toIso8601String().split('T').first;

    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tripNotifyProvider = ref.watch(tripNotifierProvider);
    final wayNotifyProvider = ref.watch(wayNotifierProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Image.asset("asset/offer.png"),
                const Spacer(),
                const Icon(Octicons.bell, color: Colors.white)
              ],
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "India's Leading ",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  TextSpan(
                    text: "Inter-City\n",
                    style: TextStyle(color: Colors.green, fontSize: 24),
                  ),
                  TextSpan(
                    text: "One Way ",
                    style: TextStyle(color: Colors.green, fontSize: 24),
                  ),
                  TextSpan(
                    text: "Cab Service Provider",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Image.asset("asset/Group_1686551544.png"),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTripButton(
                  ref,
                  "Outstation_Trip",
                  "One-way",
                  tripNotifyProvider,
                  Icons.map,
                  "Outstation Trip",
                ),
                const SizedBox(width: 8),
                buildTripButton(
                  ref,
                  "Local_Trip",
                  "",
                  tripNotifyProvider,
                  Icons.directions_bus,
                  "Local Trip",
                ),
                const SizedBox(width: 4),
                buildTripButton(
                  ref,
                  "Airport_Transfer",
                  "To_The_Airport",
                  tripNotifyProvider,
                  Icons.local_airport,
                  "Airport Transfer",
                ),
              ],
            ),
            const SizedBox(height: 4),
            tripNotifyProvider == "Outstation_Trip"
                ? buildWayButtons(ref, wayNotifyProvider)
                : const SizedBox(height: 6),
            buildDetailsSection(tripNotifyProvider, wayNotifyProvider, ref),
            const SizedBox(height: 10),
            Center(child: Image.asset("asset/car_location.png")),
          ],
        ),
      ),
    );
  }

  Widget buildTripButton(WidgetRef ref, String tripType, String wayType,
      String currentTrip, IconData icon, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(tripNotifierProvider.notifier).setTripType(tripType);
          if (wayType.isNotEmpty) {
            ref.read(wayNotifierProvider.notifier).setWayType(wayType);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: currentTrip == tripType ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Icon(icon,
                  color: currentTrip == tripType ? Colors.white : Colors.black,
                  size: 30
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentTrip == tripType ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWayButtons(WidgetRef ref, String currentWay) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        children: [
          Spacer(),
          buildWayButton(ref, "One-way", currentWay),
          const SizedBox(width: 6),
          buildWayButton(ref, "Round-trip", currentWay),
          Spacer(),
        ],
      ),
    );
  }

  Widget buildWayButton(WidgetRef ref, String way, String currentWay) {
    return ElevatedButton(
      onPressed: () {
        ref.read(wayNotifierProvider.notifier).state=way;
      },
      child: Text(
        way,
        style: TextStyle(
          color: currentWay == way ? Colors.white : Colors.green,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: currentWay == way ? Colors.green : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      ),
    );
  }

  Widget buildDetailsSection(String tripType, String wayType, WidgetRef ref) {

    List<List<dynamic>> tripDetails = [];
    final fromDate_=ref.watch(fromDate);
    final toDate_=ref.watch(toDate);

    if (tripType == "Outstation_Trip") {
      tripDetails = Outstation_Trip;
    } else if (tripType == "Local_Trip") {
      tripDetails = Local_Trip;
    } else if (tripType == "Airport_Transfer") {
      tripDetails = Airport_Transfer;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Column(
          children: [
            if (tripType == "Airport_Transfer")
              buildWayButtons(ref, wayType), // Airport Transfer Way Buttons

            ListView.builder(
              itemCount: tripDetails.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return buildTextField(
                  tripDetails[index][1],
                  tripDetails[index][2],
                  tripDetails[index][0],
                  index,
                );
              },
            ),
            if (tripType == "Local_Trip")
              Align(

                child: Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: (){
                        _selectDate(context,fromDate,ref);
                      },
                      child: Column(
                        children: [
                          Text("From Date",style: TextStyle(color: Colors.green),),
                          Text(
                              fromDate_??'select '
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 6,),
                    Image.asset('asset/Group (3).png'),
                    SizedBox(width: 6,),
                    InkWell(
                      onTap: (){
                        _selectDate(context,toDate,ref);
                      },
                      child: Column(
                        children: [
                          Text("To Date",style: TextStyle(color: Colors.green),),
                          Text(toDate_??"select")
                        ],
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ), // Airport Transfer Way Buttons
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Explore Cabs action
              },
              child: const Text(
                "Explore Cabs",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            Divider(thickness: 2,color: Colors.white,)
          ],
        ),
      ),
    );
  }

  // Common TextField widget with Date and Time Picker
  Widget buildTextField(String label, String hintText, String? image, int index) {
    final pickupCityProvider = ref.watch(selectPickUpCity);
    final dropCityProvider = ref.watch(selectDropCity);
    final pickUpDateProvider = ref.watch(pickUpDate);

    return GestureDetector(
      onTap: () {
        if (label == 'Pick-up Date' || label == 'Pick Up Date') {
          _selectDate(context,pickUpDate,ref);
        } else if (label == 'Time') {
          _selectTime(context);
        } else if (label == 'Pick Up City') {
          showSearch(
              context: context, delegate: LocationSearchDelegate(ref,"Pick Up City"));
        } else if (label == 'Drop City'||label=='Destination') {
          showSearch(
              context: context, delegate: LocationSearchDelegate(ref,"Drop City"));
        }

      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 4
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(image ?? ''),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Colors.green),
                  ),
                  const SizedBox(height: 8),
                if (label == 'Pick-up Date' || label == 'Pick Up Date'||label == 'Time') ...{
                  Text(
                    label == 'Pick-up Date' || label == 'Pick Up Date'
                        ? pickUpDateProvider == null
                        ? hintText
                        : pickUpDateProvider??""
                        : label == 'Time'
                        ? selectedTime == null
                        ? hintText
                        : selectedTime!.format(context)
                        : hintText,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  } else if (label == 'Pick Up City') ...{
                  Text(pickupCityProvider??"Select City"),

                } else if (label == "Drop City"|| label=='Destination') ...{
                  Text(dropCityProvider??"Select City"),

                }

                ],
              ),

            ),
            Icon(Icons.close, color: Colors.white),


          ],
        ),
      ),
    );
  }
}
