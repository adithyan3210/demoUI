import 'package:flutter/material.dart';
import 'package:uidemo/screens/Add_product/add_product.dart';
import 'package:uidemo/screens/Add_product/product_service.dart';
import 'package:uidemo/screens/Add_product/productino_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NewEnquiryScreen extends StatefulWidget {
  final String? clientName;
  final String? clientNumber1;
  final String? clientNumber2;
  final String? clientWhatsappNumber;
  final String? clientEmail;

  const NewEnquiryScreen(
      {super.key,
      this.clientName,
      this.clientNumber1,
      this.clientNumber2,
      this.clientWhatsappNumber,
      this.clientEmail});

  @override
  State<NewEnquiryScreen> createState() => _NewEnquiryScreenState();
}

class _NewEnquiryScreenState extends State<NewEnquiryScreen> {
  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientNumber1Controller = TextEditingController();
  TextEditingController clientNumber2Controller = TextEditingController();
  TextEditingController whatsAppNumberController = TextEditingController();
  TextEditingController clientEmailController = TextEditingController();
  @override
  void initState() {
    super.initState();

    clientNameController.text = widget.clientName ?? '';
    clientNumber1Controller.text = widget.clientNumber1 ?? '';
    clientNumber2Controller.text = widget.clientNumber2 ?? '';
    whatsAppNumberController.text = widget.clientWhatsappNumber ?? '';
    clientEmailController.text = widget.clientEmail ?? '';
  }

  List<SelectedProduct> selectedProducts = [];

  String selectedName = "";
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _dateTime2Controller = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  TextEditingController taxAmountController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController saleAmountController = TextEditingController();

  ApiService apiService = ApiService();

  DateTime _dateTime = DateTime.now();
  DateTime _dateTime2 = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
        });

        _dateTimeController.text = _dateTime.toLocal().toString().split(' ')[0];
      }
    });
  }

  void _showDatePicker2() {
    showDatePicker(
      context: context,
      initialDate: _dateTime2,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime2 = value;
        });
        _dateTime2Controller.text =
            _dateTime2.toLocal().toString().split(' ')[0];
      }
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _timeOfDay = value;
        });
        _timeController.text = _timeOfDay.format(context).toString();
      }
    });
  }

  void calculateTaxAmount() {
    double price = double.tryParse(totalController.text) ?? 0.0;

    double taxAmount = (price / 100 * selectedTaxPercentage);

    setState(() {
      taxAmountController.text = taxAmount.toStringAsFixed(2);
    });
  }

  void _calculateTotal() {
    double qty =
        double.parse(qtyController.text == "" ? "0" : qtyController.text);
    double price =
        double.parse(priceController.text == "" ? "0" : priceController.text);
    double total = qty * price;

    setState(() {
      totalController.text = total.toString();
    });
  }

  void _calculateSaleAmount() {
    double total =
        double.parse(totalController.text == "" ? "0" : totalController.text);
    double taxAmount = double.parse(
        taxAmountController.text == "" ? "0" : taxAmountController.text);
    double saleAmount = total + taxAmount;
    setState(() {
      saleAmountController.text = saleAmount.toString();
    });
  }

  double selectedTaxPercentage = 0.0;
  List<String> percentageList = [
    "",
    "5%",
    "8%",
    "12%",
  ];
  String selectedPercentage = '';

  void _showDataDiologue() {
    showDialog(
      context: context,
      builder: (context) {
        qtyController.clear();
        totalController.clear();
        selectedPercentage = '';

        taxAmountController.clear();
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Center(child: Text(selectedName)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: qtyController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _calculateTotal();
                      },
                      decoration: const InputDecoration(
                        labelText: 'QTY',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: totalController,
                      decoration: const InputDecoration(
                        labelText: 'Total',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(labelText: 'Tax %'),
                        items: percentageList.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        value: selectedPercentage,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPercentage = newValue!;

                            selectedTaxPercentage = double.tryParse(
                                    selectedPercentage.replaceAll('%', '')) ??
                                0.0;

                            calculateTaxAmount();
                            _calculateSaleAmount();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: taxAmountController,
                      decoration: const InputDecoration(
                        labelText: 'Tax Amount',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: saleAmountController,
                      decoration: const InputDecoration(
                        labelText: 'Sales Value',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                //save the selected product details  to the selectedProducts list

                Navigator.of(context).pop();
                final selectedProduct = SelectedProduct(
                  //   values Assign to  SelectedProduct class

                  name: selectedName,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  qty: double.tryParse(qtyController.text) ?? 0.0,
                  total: double.tryParse(totalController.text) ?? 0.0,
                  saleAmount: double.tryParse(saleAmountController.text) ?? 0.0,
                  taxPercentage: selectedPercentage,
                  taxAmount: double.tryParse(taxAmountController.text) ?? 0.0,
                );

                setState(() {
                  selectedProducts.add(selectedProduct);
                });
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }

//for set initia value to dialoge
  void _initialValueSet(SelectedProduct product) {
    selectedName = product.name;
    priceController.text = product.price.toString();
    qtyController.text = product.qty.toString();
    totalController.text = product.total.toString();
    selectedPercentage = product.taxPercentage;
    taxAmountController.text = product.taxAmount.toString();
  }

  //update new dialogue
  void _productUpdate(int index) {
    final productUpdate = SelectedProduct(
      name: selectedName,
      price: double.tryParse(priceController.text) ?? 0.0,
      qty: double.tryParse(qtyController.text) ?? 0.0,
      total: double.tryParse(totalController.text) ?? 0.0,
      saleAmount: double.tryParse(saleAmountController.text) ?? 0.0,
      taxPercentage: selectedPercentage,
      taxAmount: double.tryParse(taxAmountController.text) ?? 0.0,
    );
    setState(() {
      selectedProducts[index] = productUpdate;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Lead'),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.keyboard_voice_sharp)),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: clientNumber1Controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Primary Number',
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: clientNumber2Controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Secondary Number',
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'OutSide Country Mob',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: _dateTimeController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: _showDatePicker,
                                  icon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                  ),
                                ),
                                labelText: 'Follow Date',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: _dateTime2Controller,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: _showDatePicker2,
                                  icon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                  ),
                                ),
                                labelText: 'Exp.Closure',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Assigned User',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.location_on),
                              labelText: 'Location',
                              labelStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: clientNameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: whatsAppNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'WhatsApp Number',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: clientEmailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: _timeController,
                              decoration: InputDecoration(
                                  labelText: 'Follow Up Time',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  suffixIcon: IconButton(
                                      onPressed: _showTimePicker,
                                      icon: const Icon(
                                        Icons.timer_outlined,
                                        color: Colors.blue,
                                      ))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Source ',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Tag User',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: 'Referred By',
                              labelStyle: TextStyle(color: Colors.black),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 135,
                  child: ElevatedButton(
                    onPressed: () async {
                      final selected = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const AddProductScreen();
                          },
                        ),
                      );

                      if (selected != null) {
                        setState(() {
                          selectedName = selected["name"].toString();
                          priceController.text = selected["price"].toString();
                        });

                        _showDataDiologue();
                      }
                    },
                    child: const Row(
                      children: [Text('Add Product'), Icon(Icons.add)],
                    ),
                  ),
                ),
              ),
              if (selectedProducts.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedProducts.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final SelectedProduct product = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Slidable(
                        startActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                              label: 'Delete',
                              onPressed: (context) => _deleteData(index),
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                              label: 'Delete',
                              onPressed: (context) => _deleteData(index),
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price:   ₹${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'QTY  :     ${product.qty}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Total :    ₹${product.total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Tax Amount: ₹${product.taxAmount.toStringAsFixed(2)}  (${product.taxPercentage})',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Sale Amount: ₹${product.saleAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                _initialValueSet(product);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      title: Center(child: Text(selectedName)),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: qtyController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    _calculateTotal();
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'QTY',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextField(
                                                  controller: priceController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Price',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: totalController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Total',
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      DropdownButtonFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: 'Tax %'),
                                                    items: percentageList
                                                        .map((String item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: item,
                                                        child: Text(item),
                                                      );
                                                    }).toList(),
                                                    value: selectedPercentage,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedPercentage =
                                                            newValue!;

                                                        selectedTaxPercentage =
                                                            double.tryParse(
                                                                    selectedPercentage
                                                                        .replaceAll(
                                                                            '%',
                                                                            '')) ??
                                                                0.0;

                                                        calculateTaxAmount();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller:
                                                      taxAmountController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Tax Amount',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextField(
                                                  controller:
                                                      saleAmountController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Sales Value',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                _productUpdate(index);
                                              },
                                              child: const Text('Update'),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteData(int index) {
    setState(() {
      selectedProducts.removeAt(index);
    });
  }
}
