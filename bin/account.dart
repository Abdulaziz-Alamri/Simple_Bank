import 'dart:math';

class Account {
  double balance = 0;
  String accountNumber;
  List listOfTransactions = [];

  Account(this.balance, this.accountNumber, this.listOfTransactions);

  static String generateAcountNumber() {
    Random random = Random();

    int firstDigit = random.nextInt(9) + 1;
    String remainingDigits =
        List.generate(15, (generate) => random.nextInt(10)).join();

    return '$firstDigit$remainingDigits';
  }

  withdraw(double amount) {
    if (isOverLimit(amount)) {
      print('Amount is over the limit!!');
      return;
    }
    if (balance < amount) {
      print('\nNot enough balance!!');
      return;
    }
    if (isUnderBalance(amount)) {
      print(
          'Cannot make withdrawal because balance ($balance) will go under limit!!');
      return;
    }
    balance -= amount;
    storeTransaction('Withdraw', -amount, DateTime.now());
    print('$amount withdrawn from $accountNumber');
  }

  deposit(double amount) {
    if (isOverLimit(amount)) {
      print('Amount is over the limit!!');
      return;
    }
    balance += amount;
    storeTransaction('Deposit', amount, DateTime.now());
    print('$amount deposited to $accountNumber');
  }

  storeTransaction(String type, double amount, DateTime time) {
    listOfTransactions.add([type, amount, time]);
  }

  getTransactions() {
    print('\n---Transactions---');
    for (var element in listOfTransactions) {
      print('$accountNumber $element');
    }
    print('---End---\n');
  }

  double getBalance() {
    return balance;
  }

  bool isOverLimit(double amount) {
    return amount > 5000;
  }

  bool isUnderBalance(double amount) {
    return (balance - amount) < 1000;
  }
}
