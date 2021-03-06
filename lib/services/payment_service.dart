import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = "https://api.stripe.com//v1";
  static String paymentApiUrl = "${StripeService.apiBase}/payment_intents";
  static String secret =
      'sk_test_51HtWOeCU7mLHHV7kjocWiEdnpDzNqU1sGbRpwz3vuYW7HVxAj37APhUsvRZ8rB2lOLQZu85ozqBC0jIRcAY5AQMr00ipHggMqc';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
      publishableKey:
      "pk_test_51HtWOeCU7mLHHV7kuQN3I543ZGUUjtUrYwjllSNUMix1QwFBYx22pArXczY0s816bFV0M1OZA38nTDllWu5wZgrv00OtvAWdOs",
      merchantId: "Test",
      androidPayMode: "Test",
    ));
  }

  static Future<StripeTransactionResponse> payViaExistingCard({
    String amount,
    String currency,
    CreditCard card,
  }) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));

      var paymentIntent = await StripeService.createPaymentIntent(
        amount: amount,
        currency: currency,
      );

      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id,
        ),
      );

      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
          message: 'Transaction réussite',
          success: true,
        );
      } else {
        return StripeTransactionResponse(
          message: 'Transaction échouée',
          success: false,
        );
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return StripeTransactionResponse(
        message: 'Transaction échouée: ${err.toString()}',
        success: false,
      );
    }
  }

  static Future<StripeTransactionResponse> payWithNewcard({
    String amount,
    String currency,
  }) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );

      var paymentIntent = await StripeService.createPaymentIntent(
        amount: amount,
        currency: currency,
      );

      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id,
        ),
      );

      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
          message: 'Transaction réussite',
          success: true,
        );
      } else {
        return StripeTransactionResponse(
          message: 'Transaction échouée',
          success: false,
        );
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return StripeTransactionResponse(
        message: 'Transaction échouée: ${err.toString()}',
        success: false,
      );
    }
  }

  static StripeTransactionResponse getPlatformExceptionErrorResult(err) {
    String message = "Ooups! Quelque chose c'est mal passé.";

    if (err.code == 'cancelled') {
      message = 'Transaction annulée';
    }

    return StripeTransactionResponse(
      message: message,
      success: false,
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent({
    String amount,
    String currency,
  }) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        "payment_method_types[]": 'card',
      };
      var response = await http.post(
        StripeService.paymentApiUrl,
        body: body,
        headers: StripeService.headers,
      );

      return jsonDecode(response.body);
    } catch (err) {
      print("err charing user: ${err.toString()}");
    }

    return null;
  }
}
