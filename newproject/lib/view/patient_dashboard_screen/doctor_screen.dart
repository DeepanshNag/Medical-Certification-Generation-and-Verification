import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'dart:convert';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewedDoctorScreen extends StatefulWidget {
  const ViewedDoctorScreen();

  @override
  State<ViewedDoctorScreen> createState() => _ViewedDoctorScreenState();
}

class _ViewedDoctorScreenState extends State<ViewedDoctorScreen> {
  List<dynamic> doctorList = [];
  bool _isLoading = false; // Track whether data is loading or not

  TextEditingController _regNo = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fetchDoctorList();
  }

  Future<void> fetchDoctorList() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String  mobileNumber = prefs.getString('mobileNumber') ?? '';

    Map<String, String> data = {"registration_no": _regNo.text};

    print(data);

    try {
      // Make the POST request to register the doctor
      GetPostMethodService _getPostMethodService = GetPostMethodService();
      var response = await _getPostMethodService.postData(
        "https://shridevisatta.com/flutter/Apis/dr_details",
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
              'Doctor List',
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
              controller: _regNo,
              decoration: InputDecoration(
                labelText: 'Registration No.',
                hintText: 'Enter your Registration No.',
              ),
              onChanged: (value) {
                setState(() {
                  _isLoading = true;
                });
                fetchDoctorList();
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
                                  'Mobile: ${doctor['mobile'] ?? 'Unknown mobile'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                Text(
                                  'Email: ${doctor['email'] ?? 'Unknown Email'}',
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

                                SizedBox(height: 4),

                                Text(
                                  'Registration Number: ${doctor['register_no'] ?? 'Unknown Registration Number'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(height: 10),
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
