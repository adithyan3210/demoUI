import 'package:flutter/material.dart';
import 'package:uidemo/screens/Add_product/product_model.dart';
import 'package:uidemo/screens/Add_product/product_service.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ApiService apiService = ApiService();

  List<String> PercentageList = [
    "",
    "5%",
    "8%",
    "12%",
  ];
  String selectedPercentage = '';

  TextEditingController qtyController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void _calculateTotal() {
    double qty = double.tryParse(qtyController.text) ?? 0.0;
    double price = double.tryParse(priceController.text) ?? 0.0;

    double total = qty * price;

    setState(() {
      totalController.text = total.toString();
    });
  }

  void _showDiologueData(Products products) {
    TextEditingController productController =
        TextEditingController(text: products.title.toString());
    TextEditingController priceController =
        TextEditingController(text: '₹ ${products.price.toString()}');

    qtyController.text = '';
    totalController.text = '';
    qtyController.addListener(_calculateTotal);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Center(
                          child: TextField(
                            controller: productController,
                            decoration: const InputDecoration(
                                labelText: 'Product',
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: qtyController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _calculateTotal();
                          },
                          decoration: InputDecoration(
                            labelText: 'QTY',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: priceController,
                          decoration: InputDecoration(
                            labelText: 'Price',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: totalController,
                          readOnly: true, // Make it read-only
                          decoration: InputDecoration(
                            labelText: 'Total',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(labelText: 'Tax %'),
                          items: PercentageList.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          value: selectedPercentage,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPercentage = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Tax Amount',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Sales Value',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<Products>>(
        future: ApiService.fetchUsers(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  Products products = snapshot.data![index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).pop(products);
                        _showDiologueData(products);
                      },
                      child: Container(
                        width: 200,
                        height: 280,
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 180,
                              width: 150,
                              child: Center(
                                child: Image.network(products.thumbnail),
                              ),
                            ),
                            Text(products.title.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(products.brand.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Price:₹ ${products.price.toString()}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text('Rating: ${products.rating.toString()}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.white,
                  );
                },
                itemCount: snapshot.data!.length);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
