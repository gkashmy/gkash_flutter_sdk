import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gkash_flutter_sdk/gkash_flutter_sdk.dart';
import 'package:gkash_flutter_sdk/payment_request.dart';


class GkashPaymentScreen extends StatefulWidget {
  final PaymentRequest paymentRequest;

  const GkashPaymentScreen(this.paymentRequest);

  @override
  _GkashPaymentScreenState createState() => _GkashPaymentScreenState();
}

class _GkashPaymentScreenState extends State<GkashPaymentScreen> {
  GkashFlutterSdk _gkashFlutterSdk;

  @override
  void initState() {
    _gkashFlutterSdk = GkashFlutterSdk.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: InAppWebView(
          onWebViewCreated: (InAppWebViewController controller) {
            var data = ("version=" +
                Uri.encodeComponent(widget.paymentRequest.version ?? "") +
                "&CID=" +
                Uri.encodeComponent(widget.paymentRequest.cid ?? "") +
                "&v_currency=" +
                Uri.encodeComponent(widget.paymentRequest.currency ?? "") +
                "&v_amount=" +
                Uri.encodeComponent(widget.paymentRequest.amount ?? "") +
                "&v_cartid=" +
                Uri.encodeComponent(widget.paymentRequest.cartid ?? "") +
                "&v_firstname=" +
                Uri.encodeComponent(widget.paymentRequest.firstName ?? "") +
                "&v_lastname=" +
                Uri.encodeComponent(widget.paymentRequest.lastName ?? "") +
                "&v_billemail=" +
                Uri.encodeComponent(widget.paymentRequest.email ?? "") +
                "&v_billstreet=" +
                Uri.encodeComponent(widget.paymentRequest.billingStreet ?? "") +
                "&v_billpost=" +
                Uri.encodeComponent(
                    widget.paymentRequest.billingPostCode ?? "") +
                "&v_billcity=" +
                Uri.encodeComponent(widget.paymentRequest.billingCity ?? "") +
                "&v_billstate=" +
                Uri.encodeComponent(widget.paymentRequest.billingState ?? "") +
                "&v_billcountry=" +
                Uri.encodeComponent(
                    widget.paymentRequest.billingCountry ?? "") +
                "&v_billphone=" +
                Uri.encodeComponent(widget.paymentRequest.mobileNo ?? "") +
                "&returnurl=" +
                Uri.encodeComponent(widget.paymentRequest.returnUrl ?? "") +
                "&v_productdesc=" +
                Uri.encodeComponent(
                    widget.paymentRequest.productDescription ?? "") +
                "&signature=" +
                Uri.encodeComponent(
                    widget.paymentRequest.generateSignature() ?? ""));

            controller.postUrl(
                url: Uri.parse(
                    _gkashFlutterSdk.getHostUrl() + "api/PaymentForm.aspx"),
                postData: utf8.encode(data));
          },

          onLoadStart: (InAppWebViewController controller, Uri uri) {
            print('gkashpaymentwebview onLoadStart:' + uri.toString());
            if (uri
                .toString()
                .startsWith(_gkashFlutterSdk.getHostUrl() + 'api/return.aspx?')) {
              // ignore: non_constant_identifier_names
              String CID,
                  // ignore: non_constant_identifier_names
                  POID,
                  cartid,
                  status,
                  description,
                  amount,
                  currency,
                  // ignore: non_constant_identifier_names
                  PaymentType;
              uri.queryParameters.forEach((k, v) {
                print(k + " - " + v);
                if (k == 'CID') {
                  CID = v;
                }

                if (k == 'POID') {
                  POID = v;
                }

                if (k == 'cartid') {
                  cartid = v;
                }

                if (k == 'status') {
                  status = v;
                }

                if (k == 'description') {
                  description = v;
                }

                if (k == 'amount') {
                  amount = v;
                }

                if (k == 'currency') {
                  currency = v;
                }
                if (k == 'PaymentType') {
                  PaymentType = v;
                }
              });

              _gkashFlutterSdk.getCallback().onPaymentResult(status, description,
                  CID, POID, cartid, amount, currency, PaymentType);

              Navigator.of(context).pop();
            }
          },

          onLoadStop: (controller, url) {
            print('gkashpaymentwebview onLoadStop:' + url.toString());
          },

          onLoadError: (controller, url, code, message) {
            print(
                'gkashpaymentwebview onLoadError: ${url.toString()} $code $message');
          },
        ),
      ),
    );
  }
}
