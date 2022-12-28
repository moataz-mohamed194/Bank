

import 'package:bank/screens/Registration/login.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/displayBankName.dart';
import '../../domain/AdsProvider.dart';
import '../../domain/GetDataOfBank.dart';
import '../../domain/RegistrationTextFieldProvider.dart';
import '../BankPages/AddBankPage.dart';

class MainPageOfBanks extends StatefulWidget{
  const MainPageOfBanks({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageOfBanks();
  }

}
class _MainPageOfBanks extends State<MainPageOfBanks> {

  late BannerAd myBanner;
  @override
  void initState() {
    final dataProvider = Provider.of<GetDataOfBank>(context,listen: false);
    dataProvider.getListOfBankNames();
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
    final validationService = Provider.of<RegistrationTextFieldProvider>(context);
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
          onPressed: () async {
            if (await validationService.checkIfLogOut){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);

            }
          },
        ), //IconButton
      ],
      title: const Text('Welcome'),
    );
  }

    FloatingActionButton floatingButton(BuildContext context){
      return FloatingActionButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddBankPage();
          }));
        },
        child: const Icon(Icons.add),
      );
    }

  Widget bodyContainer(BuildContext context){
    final dataProvider = Provider.of<GetDataOfBank>(context);
    final dataAdsProvider = Provider.of<AdsProvider>(context);

    return ListView.builder(
        itemCount: dataProvider.banksList.length,
        itemBuilder: (_, int position) {
        return Column(
          children: [
            position%2==0?Container(
              height: 80,
              child: AdWidget(ad: dataAdsProvider.getAd()),
            ):Container(),
            DisplayBankName(
              counter: position+1,
              name: dataProvider.banksList[position],
            ),
          ],
        );
      }
  );





  }

}