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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Products'),
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
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 270,
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
