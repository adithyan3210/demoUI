import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContainerRowWidget extends StatelessWidget {
  final String phoneNumber;
  final String secondaryNumber;
  const ContainerRowWidget(
      {super.key, required this.phoneNumber, required this.secondaryNumber});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 50,
                  width: 70,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_calendar_outlined,
                        color: Colors.blue,
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(fontSize: 11, color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(child: Text('Contact')),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final Uri url = Uri(
                                      scheme: 'tel',
                                      path: phoneNumber,
                                    );
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      print('Cannot call');
                                    }
                                  },
                                  child: Text('Number 1: $phoneNumber'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final Uri url = Uri(
                                        scheme: 'tel', path: secondaryNumber);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      print('cannot call number 2');
                                    }
                                  },
                                  child: Text('Number 1: $secondaryNumber'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 50,
                      width: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                          Text(
                            'Call',
                            style: TextStyle(fontSize: 11, color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  width: 70,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.blue,
                      ),
                      Text(
                        'Enq.History',
                        style: TextStyle(fontSize: 11, color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    height: 50,
                    width: 70,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.request_page_rounded,
                          color: Colors.blue,
                        ),
                        Text(
                          'Quotations',
                          style: TextStyle(fontSize: 11, color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  height: 50,
                  width: 70,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sticky_note_2,
                        color: Colors.blue,
                      ),
                      Text(
                        'Client Histiry',
                        style: TextStyle(fontSize: 11, color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    height: 50,
                    width: 70,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.electric_bolt,
                          color: Colors.blue,
                        ),
                        Text(
                          'Quick Edit',
                          style: TextStyle(fontSize: 11, color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
