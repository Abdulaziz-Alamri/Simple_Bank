import 'dart:io';
import 'bank.dart';
import 'exit_method.dart';

void main() {
  Bank myBank = Bank();
  bool isExit = false;

  while (!isExit) {
    print('\n---Welcome to The Bank ${myBank.accountHolder}---');
    print('1: Withdraw');
    print('2: Deposit');
    print('3: Check balance');
    print('4: View transactions');
    print('5: Open a new account');
    print('6: Remove account');
    print('7: View UserInfo');
    print('0: Exit');

    stdout.write('Enter your choice: ');
    String? choice = stdin.readLineSync();

    if (choice == null || choice.isEmpty) {
      print('Invalid input!!');
      continue;
    }

    switch (choice) {
      case '1':
        stdout.write('Enter amount to withdraw: ');
        double? amount = double.parse(stdin.readLineSync()!);
        myBank.withdraw(amount);

      case '2':
        stdout.write('Enter amount to deposit: ');
        double? amount = double.parse(stdin.readLineSync()!);
        myBank.deposit(amount);

      case '3':
        print('Your balance is: ${myBank.account!.getBalance()}');

      case '4':
        myBank.account!.getTransactions();

      case '5':
        myBank.addAccount();
        print('New account added (${myBank.account!.accountNumber})');

      case '6':
        stdout.write('Enter the account number to remove: ');
        String? accountNumber = stdin.readLineSync();
        if (accountNumber != null && accountNumber.isNotEmpty) {
          myBank.removeAccount(accountNumber);
        } else {
          print('Account number given does not exist!!');
        }

      case '7':
        print('\n${myBank.userInfo}');

      case '0':
        print('---End---');
        isExit = exitMethod();
        continue;

      default:
        print('Invalid choice!!');
    }
  }
}
