import 'package:flutter/material.dart';
import 'package:saige/services/payment_service.dart';

import 'existing_cards.dart';

class CardsHome extends StatefulWidget {
  final String amount;

  CardsHome({this.amount});
  
  @override
  _CardsHomeState createState() => _CardsHomeState();
}

class _CardsHomeState extends State<CardsHome> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(title: Text("Payement")),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            Icon icon;
            Text text;

            switch (index) {
              case 0:
                icon = Icon(
                  Icons.add_circle,
                  color: Colors.green,
                );
                text = Text("Payez via une nouvelle carte");
                break;
              case 1:
                icon = Icon(
                  Icons.credit_card,
                  color: Colors.amberAccent,
                );
                text = Text("Payez via une des cartes existantes");
                break;
            }

            return InkWell(
              onTap: () {
                _onItemPress(context, index);
              },
              child: ListTile(
                title: text,
                leading: icon,
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: theme.primaryColor,
          ),
          itemCount: 2,
        ),
      ),
    );
  }

  void _onItemPress(BuildContext context, int index) async {
    switch (index) {
      case 0:
        var response = await StripeService.payWithNewcard(
          amount: '150',
          currency: 'USD',
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.message),
          duration:
              Duration(milliseconds: response.success == true ? 1200 : 3000),
        ));
        break;

      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ExistingCards(),
          ),
        );
        break;
    }
  }
}
