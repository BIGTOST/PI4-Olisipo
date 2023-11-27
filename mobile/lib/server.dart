import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchData() async {
  var url = Uri.parse('https://api.example.com/data');

  // Making the GET request
  var response = await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON response
    var data = json.decode(response.body);
    // Handle the data here
    print(data);
  } else {
    // If the server did not return a 200 OK response,
    // handle the error by checking response.statusCode
    print('Failed to fetch data: ${response.statusCode}');
  }
}
