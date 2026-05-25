import 'dart:io';
import 'package:dart_assincronismo/models/account.dart';
import 'package:dart_assincronismo/services/accountServices.dart';

class AccountScreen {
  final AccountService _accountService = AccountService();

  void initializeStream() {
    _accountService.streamInfo.listen((event) {
      print(event);
    });
  }

  void runChatBot() async {
    print("Bem vindo - ao banco !!!");
    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso lhe ajudar ?");
      print("1 - 😶‍🌫️  Ver todas as contas.");
      print("2 - ➕  Adicionar nova conta.");
      print("3 - Sair");
      String? intput = stdin.readLineSync();
      if (intput != null) {
        switch (intput) {
          case "1":
            {
              await _getAllAccount();
              break;
            }
          case "2":
            {
              await _addExampleAccount();
              break;
            }
          case "3":
            {
              isRunning = false;
              print("Saindo do sistema 🥲 ...");
              break;
            }
          default:
            {
              print("Não entendi. Tente novamente.");
            }
        }
      }
    }
  }

  Future<void> _getAllAccount() async {
    List<Account> listAccount = await AccountService().getAll();
    for(Account account in listAccount){
      print("nome: ${account.name} ${account.lastName} | balance: ${account.balance}");
    }
  }

  Future<void> _addExampleAccount() async {
    Account example = Account(
      id: "ID12345",
      name: "Leirisson",
      lastName: "Souza",
      balance: 120848.34,
    );

    await _accountService.addAccount(example);
  }


}
