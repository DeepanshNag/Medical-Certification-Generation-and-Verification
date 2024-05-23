import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class IssuedDocumentScreen extends StatefulWidget {
  const IssuedDocumentScreen({Key? key}) : super(key: key);

  @override
  State<IssuedDocumentScreen> createState() => _IssuedDocumentScreenState();
}

class _IssuedDocumentScreenState extends State<IssuedDocumentScreen> {
  List<dynamic> doctorList = [];
  bool _isLoading = true; // Track whether data is loading or not
  String mobile = '';

  @override
  void initState() {
    super.initState();
    fetchDoctorList();
  }

  Future<void> fetchDoctorList() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    String mobileNumber = prefs2.getString('mobileNumber') ?? '';

    Map<String, String> data = {
      "mobile": mobileNumber.toString(),
    };

    print(data);

    try {
      // Make the POST request to register the doctor
      GetPostMethodService _getPostMethodService = GetPostMethodService();
      var response = await _getPostMethodService.postData(
        "https://shridevisatta.com/flutter/Apis/user_certificate",
        data,
      );

      // Convert response to JSON
      String jsonString = await response.stream.bytesToString();
      Map jsonResponse = json.decode(jsonString);
      print(jsonResponse);

      // Handle the response
      if (jsonResponse["res"] == 'success') {
        // Registration successful
        Fluttertoast.showToast(
          msg: jsonResponse['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Assign fetched doctor list to the doctorList variable
        setState(() {
          doctorList =
              jsonResponse['data']; // Assuming 'data' holds the list of doctors
        });
      } else {
        // Registration failed
        Fluttertoast.showToast(
          msg: jsonResponse['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      // Error occurred during registration
      Fluttertoast.showToast(
        msg: "Error occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    // Reset loading state
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/app_logo.png',
              height: 50,
              width: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text('MCVG'),
          ],
        ),
      ),
      body: Stack(
        children: [
          bgWidget(),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : doctorList.isNotEmpty
                  ? Container(
                      width: 20036,
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: doctorList.length,
                        itemBuilder: (context, index) {
                          final doctor = doctorList[index];
                          return ListTile(
                            title: Text(
                              'Certificate NO.: ${doctor['certificate_no'] ?? 'Unknown Name'}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${doctor['name'] ?? 'Unknown Name'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        4), // Add some space between the texts
                                Text(
                                  'Age: ${doctor['age'] ?? 'Unknown Specialization'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(
                                    height:
                                        4), // Add some space between the texts
                                Text(
                                  'Gender: ${doctor['gender'] ?? 'Unknown gender'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(
                                    height:
                                        4), // Add some space between the texts
                                Text(
                                  'Mobile: ${doctor['mobile'] ?? 'Unknown mobile'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(
                                    height:
                                        4), // Add some space between the texts
                                Text(
                                  'Disease: ${doctor['disease'] ?? 'Unknown disease'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(
                                    height:
                                        4), // Add some space between the texts
                                Text(
                                  'Dr Advise: ${doctor['dr_advise'] ?? 'Unknown dr_advise'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(
                                    height:
                                        4), // Add some space between the texts
                                Text(
                                  'Create At: ${doctor['craete_at'] ?? 'Unknown craete_at'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Add onTap functionality here
                            },
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        'No doctors found.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
