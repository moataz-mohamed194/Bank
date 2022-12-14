
import 'package:bank/screens/NoteOfBank/GetNote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/InvestmentDisplay.dart';
import '../../domain/GetDataOfBank.dart';
import 'AddInvestment.dart';

class DataOfBank extends StatefulWidget{
  final String bank;
  const DataOfBank({super.key, required this.bank});

  @override
  State<StatefulWidget> createState() {
    return _DataOfBank();
  }
}


class _DataOfBank extends State<DataOfBank>{
  @override
  void initState() {
    final dataProvider = Provider.of<GetDataOfBank>(context,listen: false);
    dataProvider.getInvestmentOfBank(widget.bank.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarBody(context),
        body: bodyContainer(context),
        floatingActionButton:floatingButton(context)
    );
  }

  AppBar appBarBody (BuildContext context){
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.note),
          tooltip: 'Note',
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return GetNote(bank:widget.bank);
            }));
          },
        ), //IconButton
      ],
      title: Text(widget.bank.toString()),
    );
  }

  FloatingActionButton floatingButton(BuildContext context){
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddInvestment(bank:widget.bank);
        }));
      },
      child: const Icon(Icons.add),
    );
  }


  Widget bodyContainer(BuildContext context){
    final dataProvider = Provider.of<GetDataOfBank>(context);

    return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: ListView.builder(
            itemCount: dataProvider.investment.length,
            itemBuilder: (_, int position) {
              var data = dataProvider.investment;
              return InvestmentDisplay(
                  numberOfInvestment: data.values.elementAt(position)['number'].toString(),
                  amount: data.values.elementAt(position)['amount'].toString(),
                  dateOfEnd: data.values.elementAt(position)['date_of_end'].toString(),
                  benefit: data.values.elementAt(position)['benefit'].toString(),
                  dateOfBenefit: data.values.elementAt(position)['date_of_benefit'].toString(),
                  id:data.keys.elementAt(position).toString(),
                  name:widget.bank
              );
            }
        ));
  }

  _onRefresh(BuildContext context) async {
    try {
      final dataProvider = Provider.of<GetDataOfBank>(context,listen: false);
      dataProvider.getInvestmentOfBank(widget.bank.toString());
    }
    catch(e){
      print(e);
    }
  }
}