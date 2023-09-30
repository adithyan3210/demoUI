import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uidemo/screens/enquiry.dart/data_model.dart';
import 'package:uidemo/screens/new_enquiry/new_enquiry_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
                          SizedBox(
                            height: 130,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NewEnquiryScreen(
                                                clientName: newList?[index]
                                                            ['client_name']
                                                        .toString() ??
                                                    '',
                                                clientNumber1: newList?[index][
                                                            'client_mobile_number']
                                                        .toString() ??
                                                    '',
                                                clientNumber2: newList?[index][
                                                            'client_phone_number']
                                                        .toString() ??
                                                    '',
                                                clientWhatsappNumber: newList?[
                                                                index]
                                                            ['whatsapp_number']
                                                        .toString() ??
                                                    '',
                                                clientEmail: newList?[index]
                                                            ['email']
                                                        .toString() ??
                                                    '',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          height: 50,
                                          width: 70,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.edit_calendar_outlined,
                                                color: Colors.blue,
                                              ),
                                              Text(
                                                'Edit',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.blue),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Center(
                                                      child: Text('Contact')),
                                                  content: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          final Uri url = Uri(
                                                            scheme: 'tel',
                                                            path: newList?[index]
                                                                        [
                                                                        'client_mobile_number']
                                                                    .toString() ??
                                                                '',
                                                          );
                                                          if (await canLaunchUrl(
                                                              url)) {
                                                            await launchUrl(
                                                                url);
                                                          } else {}
                                                        },
                                                        child: Text(
                                                            'Number 1: ${newList?[index]['client_mobile_number'].toString() ?? ''},'),
                                                      ),
                                                      TextButton(
                                                          onPressed: () async {
                                                            final Uri url = Uri(
                                                                scheme: 'tel',
                                                                path: newList?[index]
                                                                            [
                                                                            'client_phone_number']
                                                                        .toString() ??
                                                                    '');
                                                            if (await canLaunchUrl(
                                                                url)) {
                                                              await launchUrl(
                                                                  url);
                                                            } else {}
                                                          },
                                                          child: Text(
                                                              'Number 2:${newList?[index]['client_phone_number'].toString() ?? ''}'))
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            height: 50,
                                            width: 70,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.blue,
                                                ),
                                                Text(
                                                  'Call',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.blue),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
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
