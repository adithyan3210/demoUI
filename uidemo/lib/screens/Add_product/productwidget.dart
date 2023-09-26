import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  final String productName;
  final double price;
  final double total;
  final String taxPercentage;
  final double taxAmount;

  ProductDetailsWidget({
    required this.productName,
    required this.price,
    required this.total,
    required this.taxPercentage,
    required this.taxAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Name: $productName'),
          Text('Price: $price'),
          Text('Total: $total'),
          Text('Tax Percentage: $taxPercentage'),
          Text('Tax Amount: $taxAmount'),
        ],
      ),
    );
  }
}
