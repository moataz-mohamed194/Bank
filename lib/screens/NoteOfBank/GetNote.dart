
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/NoteDisplay.dart';
import '../../domain/AdsProvider.dart';
import '../../domain/NoteDateProvider.dart';
import 'AddNote.dart';

class GetNote extends StatefulWidget{
  final String bank;
  const GetNote({super.key, required this.bank});

  @override
  State<StatefulWidget> createState() {
    return _GetNote();
  }

}

class _GetNote extends State<GetNote>{

  @override
  void initState() {
    final dataProvider = Provider.of<NoteDateProvider>(context,listen: false);
    dataProvider.getNotesOfBank(widget.bank.toString());
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
      title: Text('Notes of ${widget.bank.toString()}'),
    );
  }

  FloatingActionButton floatingButton(BuildContext context){
    return FloatingActionButton(
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddNote(bank:widget.bank);
        }));
      },
      child: const Icon(Icons.add),
    );
  }

  Widget bodyContainer(BuildContext context){
    final dataProvider = Provider.of<NoteDateProvider>(context);
    final dataAdsProvider = Provider.of<AdsProvider>(context);

    return RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: ListView.builder(
            itemCount: dataProvider.note.length,
            itemBuilder: (_, int position) {
              var data = dataProvider.note;
              return Column(
                children: [
                  position%2==0?Container(
                    height: 80,
                    child: AdWidget(ad: dataAdsProvider.getAd()),
                  ):Container(),
                  NoteDisplay(
                      note: data.values.elementAt(position)['note'].toString(),
                      id:data.keys.elementAt(position).toString(),
                      number: (position + 1).toString(),
                      name:widget.bank
                  ),
                ],
              );
            }
        ));
  }

  _onRefresh(BuildContext context) async {
    try {
      final dataProvider = Provider.of<NoteDateProvider>(context,listen: false);
      dataProvider.getNotesOfBank(widget.bank.toString());
    }
    catch(e){
      print(e);
    }
  }

}