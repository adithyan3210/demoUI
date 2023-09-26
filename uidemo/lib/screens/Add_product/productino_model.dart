class SelectedProduct {
  final String name;
  final double price;
  final double qty;
  final double total;
  final String taxPercentage;
  final double taxAmount;

  SelectedProduct({
    required this.name,
    required this.price,
    required this.qty,
    required this.total,
    required this.taxPercentage,
    required this.taxAmount,
  });
}
