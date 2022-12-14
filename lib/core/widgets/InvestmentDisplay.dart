
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/GetDataOfBank.dart';
import '../../screens/BankPages/AddInvestment.dart';

class InvestmentDisplay extends StatelessWidget{
  final String numberOfInvestment;
  final String amount;
  final String id;
  final String dateOfEnd;
  final String benefit;
  final String name;
  final String dateOfBenefit;
  const InvestmentDisplay({super.key,
    required this.numberOfInvestment,
    required this.amount,
    required this.benefit,
    required this.id,
    required this.name,
    required this.dateOfBenefit,
    required this.dateOfEnd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Text('ID:  ${numberOfInvestment.toString()}')
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Text('amount:  ${amount.toString()}')
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text('Date of End:'),
                    Text(dateOfEnd.toString())
                  ],),
                ),
                Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                child:Text('interest rate:  ${benefit.toString()}%')
                ),

                Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child:Text('Interest date:  ${dateOfBenefit.toString()}')
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                IconButton(
                    onPressed: ()=> _editInvestmentMethod(context),
                    icon: const Icon(Icons.edit)
                ),
                IconButton(
                  onPressed: ()=>_deleteInvestmentMethod(name, id, context),
                  icon: const Icon(Icons.close),
                  color: Colors.red
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  _deleteInvestmentMethod(String name, String id,BuildContext context ){
    final dataProvider = Provider.of<GetDataOfBank>(context,listen: false);
    dataProvider.deleteInvestment(name,id);
    dataProvider.getInvestmentOfBank(name.toString());
  }

  _editInvestmentMethod(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddInvestment(
          bank:name,
          id: id,
          amount:amount.toString(),
          numberOfInvestment:numberOfInvestment.toString(),
          dateOfEnd:dateOfEnd.toString(),
          benefit:benefit.toString(),
          dateOfBenefit:dateOfBenefit.toString());
    }));
  }
}