import 'dart:io';
import 'account.dart';

class Bank {
  List<Account> accounts = [];
  Account? account;
  String accountHolder = '';

  Map<int, List<dynamic>> userInfo = {};

  Bank() {
    stdout.write('Enter your name: ');
    String? name = stdin.readLineSync();

    if (name == null || name.isEmpty) {
      print('Invalid Name');
      return;
    }
    accountHolder = name;
    addAccount();
  }

  withdraw(double amount) {
    account = accounts[0];
    int accountChosen = 0;
    if (userInfo.length > 1) {
      for (var i = 0; i < accounts.length; i++) {
        print('${i + 1}: ${accounts[i].accountNumber}');
      }
      print('Choose an account:');
      accountChosen = int.parse(stdin.readLineSync()!);
      account = accounts[accountChosen - 1];
    }
    account!.withdraw(amount);
    userInfo[accounts.indexOf(account!) + 1] = [
      account!.accountNumber,
      accountHolder,
      account!.getBalance()
    ];
  }

  deposit(double amount) {
    int accountChosen = 0;
    if (userInfo.length > 1) {
      for (var i = 0; i < userInfo.length; i++) {
        print('${i + 1}: ${accounts[i].accountNumber}');
      }
      print('Choose an account:');
      accountChosen = int.parse(stdin.readLineSync()!);
      account = accounts[accountChosen - 1];
    }
    account!.deposit(amount);
    userInfo[accounts.indexOf(account!) + 1] = [
      account!.accountNumber,
      accountHolder,
      account!.getBalance()
    ];
  }

  addAccount() {
    String accountNumber = Account.generateAcountNumber();
    account = Account(0, accountNumber, []);
    accounts.add(account!);
    userInfo.addAll({
      accounts.indexOf(account!) + 1: [
        account!.accountNumber,
        accountHolder,
        account!.getBalance()
      ]
    });
  }

  removeAccount(String accountNumber) {
    if (accounts.length == 1) {
      print('This is your only account, it cannot be removed!!');
      return;
    }

    Account? accountToRemove;
    for (var i = 0; i < accounts.length; i++) {
      if (accounts[i].accountNumber == accountNumber) {
        accountToRemove = accounts[i];
        break;
      }
    }

    if (accountToRemove!.balance != 0) {
      deposit(accountToRemove.balance);
    }

    accounts.remove(account);
    for (var i = 1; i <= userInfo.length; i++) {
      if (userInfo[i]![0] == accountNumber) {
        userInfo.remove(i);
      }
    }
    fixIndexOfUserInfo();
  }

  fixIndexOfUserInfo() {
    Map<int, List<dynamic>> newUserInfo = {};
    int index = 1;

    for (var i in userInfo.entries) {
      newUserInfo[index++] = i.value;
    }

    userInfo = newUserInfo;
  }
}
