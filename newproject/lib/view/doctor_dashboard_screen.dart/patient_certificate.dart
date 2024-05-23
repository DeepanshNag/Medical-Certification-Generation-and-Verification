import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newproject/consts/consts.dart';
import 'package:newproject/mainasssets/GetPostMethod.dart';
import 'package:newproject/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class PatientsForm extends StatefulWidget {
  final String registrationNumber;

  const PatientsForm({Key? key, required this.registrationNumber})
      : super(key: key);

  @override
  State<PatientsForm> createState() => _PatientsFormState();
}

class _PatientsFormState extends State<PatientsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _gender;
  bool _isLoading = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _gender1 = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _disease = TextEditingController();
  TextEditingController _doctoradvise = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCVG'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          bgWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            'Medical Certificate',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _name,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Name cannot be empty',
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _age,
                            decoration: const InputDecoration(
                              labelText: 'Age',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  "Please enter the patient's age",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'Gender:',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 10),
                              Radio<String>(
                                value: 'Male',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              const Text('Male'),
                              const SizedBox(width: 10),
                              Radio<String>(
                                value: 'Female',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                              const Text('Female'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _phonenumber,
                            decoration: const InputDecoration(
                              labelText: "Phone Number",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  "Please enter the Phone Number",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _disease,
                            decoration: const InputDecoration(
                              labelText: "Disease",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  "Please enter the Disease",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _doctoradvise,
                            decoration: const InputDecoration(
                              labelText: "Doctor's Advise",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  "Doctor's Advise cannot be empty",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              _generateCertificate(); // Call the method when tapped
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Generate Certificate',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                if (_isLoading)
                                  Container(
                                    height: 50,
                                    width: 200,
                                    child: const Center(
                                      child:
                                          CircularProgressIndicator(), // Show loader
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateCertificate() async {
    setState(() {
      _isLoading = true;
    });

    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    // // Check if the registration number exists, if not, provide a default value
    // String? registrationNo = prefs.getString("registrtion_no") ?? "default_value";

//    SharedPreferences prefs = await SharedPreferences.getInstance();
//  String reg=  prefs.getString('registrationNumber');

    Map<String, String> data = {
      "doctor_id": widget.registrationNumber,
      "name": _name.text,
      "age": _age.text,
      "gender": _gender ?? '0',
      "mobile": _phonenumber.text,
      "disease": _disease.text,
      "dr_advise": _doctoradvise.text,
    };
    print(data);
    try {
      GetPostMethodService _getPostMethodService = GetPostMethodService();
      var response = await _getPostMethodService.postData(
        "https://shridevisatta.com/flutter/Apis/medical_certificate",
        data,
      );
      String jsonString = await response.stream.bytesToString();
      Map jsonResponse = json.decode(jsonString);
      print(jsonResponse);

      if (jsonResponse["res"] == true) {
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
          _isLoading = false;
        });
        //    final pdf = pw.Document();
        // pdf.addPage(pw.Page(
        //   pageFormat: PdfPageFormat.a4,
        //   build: (pw.Context context) {
        //     return pw.Center(
        //       child: pw.Text("Medical Certificate\n\n"
        //           "Name: ${_name.text}\n"
        //           "Age: ${_age.text}\n"
        //           "Gender: ${_gender ?? 'Unknown'}\n"
        //           "Phone Number: ${_phonenumber.text}\n"
        //           "Disease: ${_disease.text}\n"
        //           "Doctor's Advise: ${_doctoradvise.text}"),
        //     );
        //   },
        // ));
      } else {
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

    // Set loading state to false after operation completion
    setState(() {
      _isLoading = false;
    });
  }
}
