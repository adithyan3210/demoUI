import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uidemo/screens/enquiry.dart/container_widget.dart';
import 'package:uidemo/screens/enquiry.dart/data_model.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateData();
    });

    super.initState();
  }

  Map<String, dynamic> request = {
    "S_CustromerCompany": "",
    "S_enquirystatus": ["1"],
    "S_comment": "",
    "S_FollowUpDate": "",
    "S_assigned": [],
    "S_SearchHWC": [],
    "S_FollowUpDate_Sort_By": "",
    "S_ORDERBY": "",
    "S_Updated_Sort_By": "",
    "S_ClosureDate_Sort_By": "",
    "S_FromDate": "",
    "S_ToDate": "",
    "S_DateRangeMode": 1,
    "S_today_followup_list": 1,
    "S_Login_User_ID": "463",
    "S_region": [],
    "S_branch": [],
    "S_ActivityType": [],
    "drop_down_1": [],
    "drop_down_2": [],
    "drop_down_3": [],
    "drop_down_4": [],
    "save_search_sort_code": "lastupdate_date",
    "sort_type": "desc",
    "show_losted_enq": 0,
    "listing_user_type": "1"
  };

  List<Map<String, String?>>? newList = [];
  bool isLoading = false;

  updateData() async {
    isLoading = true;
    setState(() {});

    log(json.encode(request));

    String uri = "https://uat.fibrcrm.com/api/enquirylist/6/0";
    final response = await http.put(Uri.parse(uri), body: json.encode(request));

    if (response.statusCode == 200) {
      isLoading = false;
      print('success');
      final getDataPutModel = getDataPutModelFromJson(response.body);

      setState(() {
        newList = getDataPutModel.data;
      });
    } else {
      isLoading = false;
      setState(() {});
      print('fail');
      throw Exception('failed load post');
    }
  }

  Future<String?> fetchPendingAmount() async {
    String uri = "https://uat.fibrcrm.com/api/enquirylist/6/0";
    final response = await http.put(Uri.parse(uri), body: json.encode(request));

    if (response.statusCode == 200) {
      final getDataPutModel = getDataPutModelFromJson(response.body);
      return getDataPutModel.pending;
    } else {
      throw Exception('Failed to load pending amount from the API');
    }
  }

  Future<String?> fetchThisWeek() async {
    String uri = "https://uat.fibrcrm.com/api/enquirylist/6/0";
    final response = await http.put(Uri.parse(uri), body: json.encode(request));

    if (response.statusCode == 200) {
      final getDataPutModel = getDataPutModelFromJson(response.body);
      return getDataPutModel.thisWeek;
    } else {
      throw Exception('Failed to load pending amount from the API');
    }
  }

  Future<String?> fetchUpComing() async {
    String uri = "https://uat.fibrcrm.com/api/enquirylist/6/0";
    final response = await http.put(Uri.parse(uri), body: json.encode(request));
    if (response.statusCode == 200) {
      final GetDataPutModel = getDataPutModelFromJson(response.body);
      return GetDataPutModel.upcoming;
    } else {
      throw Exception('Failed to load pending amount from the API');
    }
  }

  Future<String?> fetchToday() async {
    String uri = "https://uat.fibrcrm.com/api/enquirylist/6/0";
    final response = await http.put(Uri.parse(uri), body: json.encode(request));

    if (response.statusCode == 200) {
      final getDataPutModel = getDataPutModelFromJson(response.body);
      return getDataPutModel.tdyclosure;
    } else {
      throw Exception('Failed to load pending amount from the API');
    }
  }

  String monthNumberToWord(String? month) {
    switch (month) {
      case '01':
        return 'JAN';
      case '02':
        return 'FEB';
      case '03':
        return 'MAR';
      case '04':
        return 'APR';
      case '05':
        return 'MAY';
      case '06':
        return 'JUN';
      case '07':
        return 'JUL';
      case '08':
        return 'AUG';
      case '09':
        return 'SEP';
      case '10':
        return 'OCT';
      case '11':
        return 'NOV';
      case '12':
        return 'DEC';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Enquiries'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: SizedBox(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        color: Colors.yellow,
                        child: FutureBuilder(
                          future: fetchToday(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center();
                            } else {
                              String todayCount = snapshot.data ?? '0';
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    todayCount,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        color: Colors.blue,
                        child: FutureBuilder(
                          future: fetchPendingAmount(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center();
                            } else {
                              String pendingAmount = snapshot.data ?? '0';
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Pending',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    pendingAmount,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        color: Colors.green,
                        child: FutureBuilder(
                          future: fetchThisWeek(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center();
                            } else {
                              String thisWeek = snapshot.data ?? '0';
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'This Week',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    thisWeek,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        color: Colors.red,
                        child: FutureBuilder(
                          future: fetchUpComing(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center();
                            } else {
                              String upcoming = snapshot.data ?? '0';
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Upcoming',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    upcoming,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        color: Colors.white,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'All',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '31',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 50,
                        color: Color.fromARGB(255, 79, 79, 79),
                        thickness: 1,
                      );
                    },
                    itemCount: newList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      String? date =
                          newList?[index]['follow_up_date'].toString();
                      List<String> dateParts = date?.split('-') ?? [];
                      String monthWord = monthNumberToWord(
                          dateParts.length > 1 ? dateParts[1] : '');
                      return ExpansionTile(
                        iconColor: Colors.blue,
                        leading: Column(
                          children: [
                            Text(
                              dateParts.isNotEmpty ? dateParts[0] : '',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 233, 210, 0),
                              ),
                            ),
                            Text(
                              dateParts.length > 2 ? dateParts[2] : '',
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 147, 221),
                              ),
                            ),
                            Text(
                              monthWord,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          newList?[index]['client_name'].toString() ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          ContainerRowWidget(
                            phoneNumber: newList?[index]
                                        ['client_mobile_number']
                                    .toString() ??
                                '',
                          )
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
