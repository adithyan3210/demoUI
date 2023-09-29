import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text('Enquiries'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: newList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  String? date = newList?[index]['follow_up_date'].toString();
                  List<String> dateParts = date?.split('-') ?? [];
                  String monthWord = monthNumberToWord(
                      dateParts.length > 1 ? dateParts[1] : '');
                  return Container(
                    height: 105,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateParts.isNotEmpty ? dateParts[0] : '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 233, 210, 0),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                dateParts.length > 2 ? dateParts[2] : '',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 10, 147, 221),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                newList?[index]['client_name'].toString() ?? '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 35,
                                    color: Colors.blue,
                                  ))
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            monthWord,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
