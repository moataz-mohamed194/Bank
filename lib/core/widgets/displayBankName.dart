
import 'package:flutter/material.dart';

import '../../screens/BankPages/DataOfBank.dart';

class DisplayBankName extends StatelessWidget{
  final String name;
  final int counter;
  const DisplayBankName({super.key, required this.name, required this.counter});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(child: Text('$counter.')),
            Expanded(child: Text(name.toString())),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return DataOfBank(
                  bank:name.toString()
              );
            }));
      },
    );
  }

}