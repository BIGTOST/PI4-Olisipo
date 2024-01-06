import 'package:http/http.dart' as http;

void uploadFile() async {
  var uri = Uri.parse('http://your_server_url/upload');

  var request = http.MultipartRequest('POST', uri);
  request.files.add(await http.MultipartFile.fromPath('foo', 'C:\Users\joaop\Downloads\scweam.png'));

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

void main() {
  uploadFile();
}
