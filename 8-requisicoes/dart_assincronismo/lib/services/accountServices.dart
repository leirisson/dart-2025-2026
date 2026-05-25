import 'dart:async';
import 'package:dart_assincronismo/models/account.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '/apiKey.dart';

class AccountService {
  final StreamController<String> _streamController = StreamController<String>();
  final String _url = "https://api.github.com/gists/75075b2ad8f85675a38ffe316c8ead03";

  // deixando o get dipononivel
  Stream<String> get streamInfo => _streamController.stream;

  Future<List<Account>> getAll() async {
    Response response = await get(Uri.parse(_url));
    // ✅ Chamada direta, sem lambda wrapper
    _streamController.add("${DateTime.now()} | Requisição de leitura");

    Map<String, dynamic> mapResponse = json.decode(response.body);
    List<dynamic> listDynamic = json.decode(
      mapResponse["files"]["account.json"]["content"],
    );

    List<Account> listAccount = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
      Account account = Account.from(mapAccount);
      listAccount.add(account);
    }

    return listAccount;
  }

  Future<void> addAccount(Account account) async {
    List<Account> listAccounts = await getAll();
    listAccounts.add(account);

    List<Map<String, dynamic>> listContent = [];

    for (Account account in listAccounts) {
      listContent.add(account.toMap());
    }

    String content = json.encode(listContent);

    Response response = await post(
      Uri.parse(_url),
      headers: {"Authorization": "Bearer $githubApiKey"},
      body: json.encode({
        "description": "account.json",
        "public": true,
        "files": {
          "account.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      // ✅ Chamada direta
      _streamController.add(
        "${DateTime.now()} | Requisição de adição bem sucedida (${account.name})",
      );
    } else {
      _streamController.add(
        "${DateTime.now()} | Requisição de adição falhou (${account.name})",
      );
    }
  }
}
