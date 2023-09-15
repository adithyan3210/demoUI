import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uidemo/loaction_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

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
            icon: Icon(Icons.menu),
          ),
          title: Text(toggleOn ? 'On Duty' : 'Off Duty'),
          actions: [
            IconButton(
                onPressed: _getCurrentPosition,
                icon: Icon(
                  Icons.location_on_rounded,
                  size: 30,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.done,
                  size: 30,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
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
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WELCOME',
                      style: TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'LOCATION: ${_currentAddress ?? ""}',
                        style: TextStyle(color: Colors.white),
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
                    return Container(
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
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              iconList[index],
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            nameList[index],
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
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
