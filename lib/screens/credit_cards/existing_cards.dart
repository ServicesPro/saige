import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:saige/services/payment_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class ExistingCards extends StatefulWidget {
  @override
  _ExistingCardsState createState() => _ExistingCardsState();
}

class _ExistingCardsState extends State<ExistingCards> {
  List _cards = [
    {
      'cardNumber': '4242424242424242',
      'expiryDate': '04/24',
      'cardHolderName': 'Muhammad Ashan Ayaz',
      'cvvCode': '424',
      'showBackView': false
    },
    {
      'cardNumber': '3566002020360505',
      'expiryDate': '04/23',
      'cardHolderName': 'Tracer',
      'cvvCode': '123',
      'showBackView': false
    }
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(title: Text("Choisir une carte existante")),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: _cards.length,
          itemBuilder: (context, index) {
            var card = _cards[index];
            return InkWell(
              onTap: () {
                payViaExistingCard(context, card);
              },
              child: CreditCardWidget(
                cardNumber: card['cardNumber'],
                expiryDate: card['expiryDate'],
                cardHolderName: card['cardHolderName'],
                cvvCode: card['cvvCode'],
                showBackView: card['showBackView'],
              ),
            );
          },
        ),
      ),
    );
  }

  payViaExistingCard(BuildContext context, card) async {
    var expiryArr = card['expiryDate'].split('/');
    CreditCard stripeCard = CreditCard(
      number: card['cardNumber'],
      expMonth: int.parse(expiryArr[0]),
      expYear: int.parse(expiryArr[1]),
    );
    var response = await StripeService.payViaExistingCard(
      amount: '150',
      currency: 'USD',
      card: stripeCard,
    );
    if (response.success == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text(response.message),
              duration: Duration(milliseconds: 1200),
            ),
          )
          .closed
          .then((_) {
        Navigator.of(context).pop();
      });
    }
  }
}
