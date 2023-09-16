import 'package:flutter/material.dart';
import 'package:uidemo/screens/Add_product/add_product.dart';
import 'package:uidemo/screens/Add_product/product_model.dart';

class NewEnquiryScreen extends StatefulWidget {
  const NewEnquiryScreen({super.key});

  @override
  State<NewEnquiryScreen> createState() => _NewEnquiryScreenState();
}

class _NewEnquiryScreenState extends State<NewEnquiryScreen> {
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _dateTime2Controller = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

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

  void _showSaveDiologue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Center(child: Text('Document Save')),
          content: const Text('Do you want to save?'),
          contentPadding: const EdgeInsets.only(top: 10, left: 70),
          actions: [
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Products? selectedProduct;

  void _selectProduct(Products? product) {
    setState(() {
      selectedProduct = product;
    });
  }

  List<Products> selectedProductList = [];

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
                onPressed: () {
                  _showSaveDiologue();
                },
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
                      padding: const EdgeInsets.only(left: 10, bottom: 20),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Primary Number',
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Secondary Number',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
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
                                labelStyle: const TextStyle(color: Colors.black),
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
                                labelStyle: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Assigned User',
                                labelStyle: const TextStyle(color: Colors.black),
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
                      padding: const EdgeInsets.only(right: 10, bottom: 20),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'WhatsApp Number',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              controller: _timeController,
                              decoration: InputDecoration(
                                  labelText: 'Follow Up Time',
                                  labelStyle: const TextStyle(color: Colors.black),
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
                                labelStyle: const TextStyle(color: Colors.black),
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
                                labelStyle: const TextStyle(color: Colors.black),
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
                        _selectProduct(selected as Products);
                        setState(() {
                          selectedProductList.add(selected);
                        });
                      }
                    },
                    child: const Row(
                      children: [Text('Add Product'), Icon(Icons.add)],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: selectedProductList.length,
                itemBuilder: (context, index) {
                  Products product = selectedProductList[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Container(
                      width: 350,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 180,
                            width: 150,
                            child: Center(
                              child: Image.network(product.thumbnail),
                            ),
                          ),
                          Text(
                            product.title.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.brand.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Price: ₹ ${product.price.toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rating: ${product.rating.toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
