
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/BankDataTextFieldProvider.dart';
import '../MainScreen/MainPageOfBanks.dart';

class AddBankPage extends StatelessWidget{
  const AddBankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarBody(context),
        body:bodyWidget(context)
    );
  }

  AppBar appBarBody(BuildContext context){
    return AppBar(
      title: const Text('Add Bank'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<BankDataTextFieldProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
            hintText: "Name of bank",
            errorText: validationService.nameOfBank.error,
            textIcon: const Icon(Icons.comment_bank),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeNameOfBank(vals);
            },
            inputType: TextInputType.text,
          ),
          TextFieldWidget(
            hintText: "Saving",
            errorText: validationService.savingOfBank.error,
            textIcon: const Icon(Icons.attach_money),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeSavingOfBank(vals);
            },
            inputType: TextInputType.number,
          ),

          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text: "Add",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {
              if (await validationService.nameOfBankIsValid){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainPageOfBanks()), (route) => false);
              }
            },
          )
        ],
      ),
    );
  }

}