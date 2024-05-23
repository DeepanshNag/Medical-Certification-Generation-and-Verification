import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class GetPostMethodService {
  Future<http.Response> fetchData(url) async {
    final response = await http.get(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load album');
    }  
  }

  Future<http.StreamedResponse> postData(url, Map<String, String> data) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(url));
    request.fields.addAll(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    
    return response;
  }
  Future<http.StreamedResponse> postDatawithImage(url, Map<String, String> data, XFile? file, XFile? file1, XFile? file2,XFile? file3) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(url));
    request.fields.addAll(data);
    request.files.add(await http.MultipartFile.fromPath('profile', file!.path ?? ""));
    request.files.add(await http.MultipartFile.fromPath('aadharfront', file1!.path));
    request.files.add(await http.MultipartFile.fromPath('aadharback', file2!.path));
    request.files.add(await http.MultipartFile.fromPath('pan', file3!.path));
    request.files.add(await http.MultipartFile.fromPath('gst', file3.path));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    
    return response;
  }

  
}
