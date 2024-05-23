import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:newproject/widgets_common/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetailsScreen> {
  List<dynamic> doctorList = [];
  bool _isLoading = false; // Track whether data is loading or not

  TextEditingController _mobile = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fetchDoctorList();
  }

  Future<void> fetchDoctorList() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String  mobileNumber = prefs.getString('mobileNumber') ?? '';

    Map<String, String> data = {"mobile": _mobile.text};

    print(data);

    try {
      // Make the POST request to register the doctor
      GetPostMethodService _getPostMethodService = GetPostMethodService();
      var response = await _getPostMethodService.postData(
        "https://shridevisatta.com/flutter/Apis/get_all_certificate",
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
            const Text(
              'All Pateint Details',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          bgWidget(),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              controller: _mobile,
              decoration: InputDecoration(
                labelText: 'Pateint Mobile Number',
                hintText: 'Enter Pateint Mobile Number',
              ),
              onChanged: (value) {
                if (value.length == 10) {
                  setState(() {
                    _isLoading = true;
                  });
                  fetchDoctorList();
                }
              },
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : doctorList.isNotEmpty
                  ? Container(
                      width: 400,
                      margin: EdgeInsets.only(
                          top: 120, left: 20, right: 20, bottom: 20),
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
                              'Name: ${doctor['name'] ?? 'Unknown Name'}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Add some space between the texts
                                SizedBox(
                                    height:
                                        4), // Add some space between the texts

                                Text(
                                  'Certificate No.: ${doctor['certificate_no'] ?? 'Unknown certificate_no'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),

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
                                  'Age: ${doctor['age'] ?? 'Unknown Age'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  'Gender: ${doctor['gender'] ?? 'Unknown Gender'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  'Disease: ${doctor['disease'] ?? 'Unknown Disease'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  'Mobile: ${doctor['mobile'] ?? 'Unknown mobile'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),

                                Text(
                                  'Dr Advise: ${doctor['dr_advise'] ?? 'Unknown Dr Advise'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  'Create At: ${doctor['craete_at'] ?? 'Unknown Create At'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(height: 40),
                              ],
                            ),
                            onTap: () {},
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
