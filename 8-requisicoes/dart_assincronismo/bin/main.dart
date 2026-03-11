import 'package:http/http.dart';
import 'dart:convert';

void main() {
  // print("olá mundo.");
  requestDataAsync();
}

requestData() {
  String url =
      "https://gist.githubusercontent.com/leirisson/75075b2ad8f85675a38ffe316c8ead03/raw/ffca5bf0437d955d18c3bf00c1314f36bb4a7201/gistfile1.txt";
  Future<Response> futureResponse = get(Uri.parse(url));

  List<dynamic> listAccount = [];
  Map<String, dynamic> mapCarlar = {};
  futureResponse.then(
    (Response response) => {
      listAccount = json.decode(response.body),
      mapCarlar = listAccount.firstWhere((element) => element["name"] == "Carla",),
      print(mapCarlar["balance"])
      },
  );

  print("ultima coisa a acontecer na função");
}



/**
 * Toda função assincrona deve retorna um dado do tipo Future
 */
Future<List<dynamic>> requestDataAsync() async {
    String url =
      "https://gist.githubusercontent.com/leirisson/75075b2ad8f85675a38ffe316c8ead03/raw/ffca5bf0437d955d18c3bf00c1314f36bb4a7201/gistfile1.txt";
    Response response = await get(Uri.parse(url));
    return json.decode(response.body);
}

