# GkashFlutterSDK

This plugin allows you to integrate Gkash Payment Gateway into your Flutter App.

## Usage

Sample usage to start a payment:

```
import 'package:gkash_flutter_sdk/gkash_flutter_sdk.dart';
import 'package:gkash_flutter_sdk/gkash_payment_callback.dart';
import 'package:gkash_flutter_sdk/payment_request.dart';


    //Generate your Payment Request
    PaymentRequest request = PaymentRequest(
      version: '1.5.0',
      cid: _merchantId, //Your merchant Id
      currency: 'MYR',
      amount: amount, // 1.00
      cartid: DateTime.now().microsecond.toString(), //Unique cart Id
      signatureKey: _signatureKey, //Your signature key
    );

try {
      // Get instance of GkashPayment
      GkashFlutterSdk _gkashFlutterSdk = GkashFlutterSdk.getInstance();
      // Set environment and start payment
      _gkashFlutterSdk.setProductionEnvironment(false);
      _gkashFlutterSdk.startPayment(context, request, this);
    } catch (e) {
      //catch exception when sdk throw exception
      print(e);
    }
```

## Getting the Payment Result

Upon finishing of the WebView Activity, implement GkashPaymentCallback to your widget

```
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    implements GkashPaymentCallback {

  @override
  void onPaymentResult(
      String status,
      String description,
      String companyRemId,
      String poId,
      String cartId,
      String amount,
      String currency,
      String paymentType) {
    print('Gkash Payment Demo: Payment done.');

    // handle payment response 
  }
}
```

## License
[Apache 2.0](https://choosealicense.com/licenses/apache-2.0/)