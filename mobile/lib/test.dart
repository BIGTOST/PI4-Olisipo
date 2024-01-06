import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? selectedFile;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
      uploadFile(selectedFile!);
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadFile(File file) async {
    var uri = Uri.parse('https://backend-w7pc.onrender.com/upload');

    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('foo', file.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: selectFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 20),
            if (selectedFile != null)
              Text('Selected File: ${selectedFile!.path}'),
          ],
        ),
      ),
    );
  }
}