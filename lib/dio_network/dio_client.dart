import 'package:dio/dio.dart';

import '../company_model.dart';

class DioClient {

  // DioClient(this.dio);
  // create dio instance
  Dio dio = Dio();
  // String searchText;
  // DioClient({this.searchText = 'goog'});
  final String apiKey = 'de48cbc67c6d8e988145d6d201f49748';

  Future<List<Company>> getData(String search) async {

    List<Company> companies = [];
    // Make the HTTP GET request
    // Response response = await dio.get('https://www.example.com/get');

    Response response = await dio.get('http://api.marketstack.com/v1/tickers',
        queryParameters: {'access_key' : apiKey, 'limit' : 10, 'offset' : 0, 'search' : search});

    // Print the response data to the console
    print(response.data);

    // Parse the response data
     companies = (response.data['data'] as List)
        .map((data) => Company.fromJson(data))
        .toList();
    return companies;
  }

  void postData() async {
    // Set up the POST request data
    Map<String, String> data = {'key': 'value'};

    // Make the HTTP POST request
    Response response =
        await dio.post('https://www.example.com/post', data: data);

    // Print the response data to the console
    print(response.data);
  }
}
