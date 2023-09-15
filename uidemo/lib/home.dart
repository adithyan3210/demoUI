import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uidemo/loaction_service.dart';
import 'package:uidemo/screens/add_client.dart';
import 'package:uidemo/screens/add_complaints.dart';
import 'package:uidemo/screens/call_logs.dart';
import 'package:uidemo/screens/clients.dart';
import 'package:uidemo/screens/complaints.dart';
import 'package:uidemo/screens/enquiries.dart';
import 'package:uidemo/screens/new_enquiry.dart';
import 'package:uidemo/screens/orders.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toggleOn = false;
  double toggleOnSize = 40.0;
  IconData toggleOnIcon = Icons.toggle_on_outlined;
  List<String> nameList = [
    'New Enquiry',
    'Enquiries',
    'Add Client',
    'Clients',
    'Orders',
    'CallLogs',
    'Add Complaints',
    'Complaints',
  ];
  List<IconData> iconList = [
    Icons.person_outlined,
    Icons.settings,
    Icons.person_pin_rounded,
    Icons.account_circle,
    Icons.favorite,
    Icons.call,
    Icons.note_alt,
    Icons.event_note_rounded,
  ];

  List<Color> iconColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.blue,
  ];
  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewEnquiryScreen()),
        );

      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EnquiryScreen()),
        );
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddClientScreen()),
        );
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ClientScreen()),
        );
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderScreen()),
        );
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CallLogScreen()),
        );
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddComplaintsScreen()),
        );
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ComplaintsScreen()),
        );
    }
  }

  String? _currentAddress;

  Future<void> _getCurrentPosition() async {
    final hasPermission =
        await LocationService.handleLocationPermission(context);

    if (!hasPermission) return;
    Position? position = await LocationService.getCurrentPosition();

    if (position != null) {
      String address = await LocationService.getAddressFromLatLng(position);
      setState(() {
        _currentAddress = address;
      });
    } else {
      setState(() {
        _currentAddress = 'Location unavailable';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          title: Text(toggleOn ? 'On Duty' : 'Off Duty'),
          actions: [
            IconButton(
                onPressed: _getCurrentPosition,
                icon: const Icon(
                  Icons.location_on_rounded,
                  size: 30,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.done,
                  size: 30,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  size: 30,
                )),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () async {
                    if (toggleOn) {
                    } else {}
                    setState(() {
                      toggleOnIcon = toggleOn
                          ? Icons.toggle_on_outlined
                          : Icons.toggle_off_outlined;
                      toggleOnSize = toggleOn ? 40 : 40;
                      toggleOn = !toggleOn;
                    });
                  },
                  icon: Icon(
                    toggleOn
                        ? Icons.toggle_off_outlined
                        : Icons.toggle_on_outlined,
                    color: toggleOn ? Colors.red : Colors.white,
                    size: 40,
                  )),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              color: Colors.blue[800],
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'WELCOME',
                      style: TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'LOCATION: ${_currentAddress ?? ""}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: GridView.builder(
                  itemCount: nameList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 10 / 7.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        navigateToPage(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: iconColors[index],
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                iconList[index],
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              nameList[index],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
