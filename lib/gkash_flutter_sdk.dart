import 'package:flutter/material.dart';
import 'package:gkash_flutter_sdk/gkash_payment_callback.dart';
import 'package:gkash_flutter_sdk/payment_request.dart';

import 'gkash_payment_screen.dart';

class GkashFlutterSdk {
  static GkashFlutterSdk instance;
  GkashPaymentCallback _callback;
  String _hostUrl = "https://api-staging.pay.asia/";

  static GkashFlutterSdk getInstance() {
    if (instance == null) {
      instance = GkashFlutterSdk();
    }
    return instance;
  }

  void setProductionEnvironment(bool isProduction) {
    if (isProduction) {
      _hostUrl = "https://api.gkash.my/";
    }
  }

  String getHostUrl() {
    return _hostUrl;
  }

  GkashPaymentCallback getCallback() {
    return _callback;
  }

  void startPayment(BuildContext context, PaymentRequest request,
      GkashPaymentCallback callback) {
    if (request.getAmount() == null) {
      throw ("Parameter amount is required.");
    } else {
      try {
        double.parse(request.getAmount());
      } catch (e) {
        throw ("Parameter amount is invalid.");
      }
    }
    if (request.getVersion() == null || request.getVersion().isEmpty)
      throw ("Parameter version is required.");
    if (request.getCid() == null || request.getCid().isEmpty)
      throw ("Parameter cid is required.");
    if (request.getCurrency() == null || request.getCurrency().isEmpty)
      throw ("Parameter currency is required.");
    if (request.getCartId() == null || request.getCartId().isEmpty)
      throw ("Parameter cartId is required.");
    if (request.getSignatureKey() == null || request.getSignatureKey().isEmpty)
      throw ("Parameter signatureKey is required.");
    _callback = callback;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return GkashPaymentScreen(request);
        },
      ),
    );
  }
}
