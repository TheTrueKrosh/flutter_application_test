import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class CardScreenWidget extends StatelessWidget {
  const CardScreenWidget({super.key, required this.notificationMsg});
  final String notificationMsg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
              padding: const EdgeInsets.all(10), child: Text(notificationMsg)),
          const SizedBox(
            height: 30,
          ),
          const BarCodeDiscounts(),
        ]),
      ),
    );
  }
}

class BarCodeDiscounts extends StatelessWidget {
  const BarCodeDiscounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        shadowColor: Colors.black,
        elevation: 7,
        child: Column(
          children: const [
            BarCode(),
            Discounts(),
          ],
        ),
      ),
    );
  }
}

class BarCode extends StatelessWidget {
  const BarCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: BarcodeWidget(
        barcode: Barcode.code128(),
        data: '1234567890',
      ),
    );
  }
}

class Discounts extends StatelessWidget {
  const Discounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Row(
        children: const [
          Text(
            '1000 баллов',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          Spacer(),
          Text(
            '100 ₽',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
