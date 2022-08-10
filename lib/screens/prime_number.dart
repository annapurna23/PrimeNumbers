import 'package:flutter/material.dart';

class PrimeNumbers extends StatefulWidget {
  const PrimeNumbers({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PrimeNumberState();
  }
}

class PrimeNumberState extends State<PrimeNumbers> {
  bool isChecked = false;
  int currentNumber = 2;
  int currentPrimeNumber = 2;
  bool stopLoop = false;
  bool isPaused = false;
  bool findPrimeIsDisabled = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () async {
      //   _showConfirmDialog(context);
      //   if (await !stopLoop) {
      //     Navigator.pop(context);
      //     return Future(() => true);
      //   }
      //   return Future(() => false);
      // },
      onWillPop: () => showConfirmDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Display Screen'),
        ),
        body: Container(
          child: Center(
            child: Column(
                children: <Widget>[
            Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentNumber.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(currentPrimeNumber.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  minimumSize:
                  MaterialStateProperty.all(Size.fromHeight(40.0)),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero))),
              onPressed: findPrimeIsDisabled ? null : () {
                debugPrint('Button pressed');
                findPrimeIsDisabled = true;
                startPrimeSearch(context);
              },
              child: const Text('Find Prime Numbers',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  minimumSize:
                  MaterialStateProperty.all(Size.fromHeight(40.0)),
                  shape:
                  MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero))),
              onPressed: () {
                findPrimeIsDisabled = false;
                stopSearch(context);
              },
              child: const Text(
                  'Terminate Search',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto")),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CheckboxListTile(
                title: const Text('Pacifier Switch'),
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: Colors.red,
                activeColor: Colors.yellow,
                value: isChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                });
          },
        ),
        ],
      ),
    ),)
    ,
    )
    ,
    );
  }

  void startPrimeSearch(BuildContext context, {int firstNumber=2}) async {
    bool isPrime = false;
    isPaused = false;


    debugPrint('Search Started');

    // Logic to find prime numbers
    for (int i = firstNumber; i <= 200 && !isPaused; i++) {
      await Future.delayed(const Duration(milliseconds: 200), () {
        debugPrint('$i');
        updateCurrentNumberState(i);

        // check if the number is prime
        isPrime = isPrimeNumber(i);
        if (isPrime) {
          // Update text box 2 with the prime number
          updatePrimeNumberState(i);
        }
      });
    }
  }

  void stopSearch(BuildContext context) {
    isPaused = true;
  }

  void updateCurrentNumberState(int newNumber) async {
    setState(() {
      currentNumber = newNumber;
    });
  }

  void updatePrimeNumberState(int newNumber) async {
    setState(() {
      currentPrimeNumber = newNumber;
    });
  }

  bool isPrimeNumber(int number) {
    for (var i = 2; i <= number / i; ++i) {
      if (number % i == 0) {
        return false;
      }
    }
    return true;
  }

  Future<bool> showConfirmDialog(BuildContext context) async {
    isPaused = true;

    Widget cancelButton = ElevatedButton(
      child: const Text("no"),
      onPressed: () {
        debugPrint('No pressed');
        isPaused = false;
        Navigator.of(context).pop(false);
        startPrimeSearch(context, firstNumber:currentNumber);
      },
    );

    Widget continueButton = ElevatedButton(
      child: const Text("yes"),
      onPressed: () {
        // stopLoop = true;
        debugPrint('Yes pressed');
        Navigator.of(context).pop(true);
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Alert Dialog'),
      content: const Text('Would you like to cancel the search?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return await showDialog(
        context: context, builder: (context) => alertDialog) ??
        false;
  }
}
