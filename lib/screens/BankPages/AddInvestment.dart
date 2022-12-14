
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/textfield.dart';
import '../../domain/BankDataTextFieldProvider.dart';
import '../../domain/GetDataOfBank.dart';

class AddInvestment extends StatelessWidget{
  final String bank;
  final String? numberOfInvestment;
  final String? amount;
  final String? id;
  final String? dateOfEnd;
  final String? benefit;
  final String? name;
  final String? dateOfBenefit;

  const AddInvestment({super.key, required this.bank, this.numberOfInvestment,
    this.amount, this.id, this.dateOfEnd, this.benefit, this.name,
    this.dateOfBenefit});

  // const AddInvestment({super.key, required this.bank});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarBody(context),
        body:bodyWidget(context)
    );
  }

  AppBar appBarBody(BuildContext context){
    return AppBar(
      title:id != null? const Text('Add Investment'): const Text('Edit Investment'),
    );
  }

  Widget bodyWidget(BuildContext context){
    final validationService = Provider.of<BankDataTextFieldProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldWidget(
            hintText: "number of investment",
            errorText: validationService.numberOfInvestment.error,
            textIcon: const Icon(Icons.numbers),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeNumberOfInvestment(vals);
            },
            inputType: TextInputType.number,
            oldData: numberOfInvestment,
          ),

          TextFieldWidget(
            hintText: "amount of investment",
            errorText: validationService.amountOfInvestment.error,
            textIcon: const Icon(Icons.attach_money),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeAmountOfInvestment(vals);
            },
            inputType: TextInputType.number,
            oldData: amount,
          ),

          TextFieldWidget(
            hintText: "date of end the investment",
            errorText: validationService.dateOfEndTheInvestment.error,
            textIcon: const Icon(Icons.date_range),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeDateOfEndTheInvestment(vals);
            },
            inputType: TextInputType.number,
            oldData: dateOfEnd,
          ),

          TextFieldWidget(
            hintText: "interest rate of investment",
            errorText: validationService.benefitOfInvestment.error,
            textIcon: const Icon(Icons.numbers),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeBenefitOfInvestment(vals);
            },
            oldData: benefit,
            inputType: TextInputType.number,
          ),

          TextFieldWidget(
            hintText: "The date of interest of investment",
            errorText: validationService.timeOfBenefit.error,
            textIcon: const Icon(Icons.date_range),
            cursorColor: Colors.black,
            borderSideColor: Theme.of(context).primaryColor,
            textStyleColor: Colors.black,
            textChange: (vals) {
              validationService.changeTimeOfBenefit(vals);
            },
            oldData: dateOfBenefit,
            inputType: TextInputType.number,
          ),

          ButtonWidget(
            height: 50,
            color: Theme.of(context).primaryColor,
            text:id != null? "Add investment": "Edit investment",
            borderColor: Theme.of(context).primaryColor,
            textColor:Theme.of(context).cardColor,
            onPressed: ()  async {
              if(id == null && numberOfInvestment == null && amount == null && dateOfEnd == null && benefit == null && dateOfBenefit  == null) {
                if (await validationService.investmentIsValid(bank)) {
                  Navigator.of(context).pop();
                }
              }else{
                if (await validationService.editInvestment(bank, id)) {
                  Navigator.of(context).pop();
                }
              }
              final dataProvider =
              Provider.of<GetDataOfBank>(context, listen: false);

              dataProvider.getInvestmentOfBank(bank.toString());

            },
          )
        ],
      ),
    );
  }
}