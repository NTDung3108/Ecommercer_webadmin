import 'package:http/http.dart' as http;

class HttpClient {
  // String server = 'http://192.168.2.101:3000/api';
  String server = 'http://192.168.2.101:3000/api';

  // String server = 'http://192.168.2.151:3000/api';
  var client = http.Client();

  Future<http.Response> get(String address, {String? token}) async {
    Uri uri = Uri.parse(server + address);
    return await client.get(uri,
        headers: {'Accept': 'application/json', 'xx-token': '$token'});
  }

  Future<http.Response> post(
      String address, String token, Map<String, dynamic> body) async {
    Uri uri = Uri.parse(server + address);
    return await client.post(uri,
        headers: {'Accept': 'application/json', 'xx-token': '$token'},
        body: body);
  }

  Future<http.Response> put(String address, String token, String body) async {
    Uri uri = Uri.parse(server + address);
    return await client.put(uri,
        headers: {
          'Accept': 'application/json',
          'xx-token': '$token'
        },
        body: body);
  }
}
