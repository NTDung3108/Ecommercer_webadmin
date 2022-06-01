import 'package:http/http.dart' as http;

class HttpClient{
  // String server = 'http://192.168.2.101:3000/api';
  String server = 'http://10.50.10.135:3000/api';
  var client = http.Client();

  Future<http.Response> get(String address)async{
    Uri uri = Uri.parse(server+address);
    return await client.get(uri);
  }

  Future<http.Response> post(String address, Map<String, dynamic> body)async{
    Uri uri = Uri.parse(server+address);
    return await client.post(uri, body: body);
  }

  Future<http.Response> put(String address, Map<String, dynamic> body)async{
    Uri uri = Uri.parse(server+address);
    return await client.put(uri, body: body);
  }
}