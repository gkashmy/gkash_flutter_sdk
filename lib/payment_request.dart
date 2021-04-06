import 'package:crypto/crypto.dart';
import 'dart:convert';

class PaymentRequest {
  final String version;
  final String cid;
  final String currency;
  final String amount;
  final String cartid;
  final String signatureKey;
  final String returnUrl; 
  final String email; // Optional
  final String mobileNo; // Optional
  final String firstName; // Optional
  final String lastName; // Optional
  final String productDescription; // Optional
  final String billingStreet; // Optional
  final String billingPostCode; // Optional
  final String billingCity; // Optional
  final String billingState; // Optional
  final String billingCountry; // Optional

  String getVersion() {
    return version;
  }

  String getCid() {
    return cid;
  }

  String getCurrency() {
    return currency;
  }

  String getAmount() {
    return amount;
  }

  String getCartId() {
    return cartid;
  }

  String getEmail() {
    return email;
  }

  String getMobileNo() {
    return mobileNo;
  }

  String getFirstName() {
    return firstName;
  }

  String getLastName() {
    return lastName;
  }

  String getSignatureKey() {
    return signatureKey;
  }

  String getProductDescription() {
    return productDescription;
  }

  String getBillingStreet() {
    return billingStreet;
  }

  String getBillingPostCode() {
    return billingPostCode;
  }

  String getBillingCity() {
    return billingCity;
  }

  String getBillingState() {
    return billingState;
  }

  String getBillingCountry() {
    return billingCountry;
  }

  PaymentRequest(
      {this.version,
      this.cid,
      this.currency,
      this.amount,
      this.cartid,
      this.signatureKey,
      this.returnUrl,
      this.email,
      this.mobileNo,
      this.firstName,
      this.lastName,
      this.productDescription,
      this.billingStreet,
      this.billingPostCode,
      this.billingCity,
      this.billingState,
      this.billingCountry});

  String generateSignature() {
    String sign = (signatureKey +
            ";" +
            cid +
            ";" +
            cartid +
            ";" +
            double.parse(amount).toStringAsFixed(2).replaceAll(".", "") +
            ";" +
            currency)
        .toUpperCase();
    var signaureHash = sha512.convert(utf8.encode(sign));

    return signaureHash.toString().toLowerCase();
  }
}
