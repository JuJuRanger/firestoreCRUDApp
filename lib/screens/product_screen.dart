import 'package:firestoreCRUDApp/models/product.dart';
import 'package:firestoreCRUDApp/screens/add_edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ตัวแปร products คือ model ในที่สร้างขึ้นแบบ Provider
    final products = Provider.of<List<Product>>(context);

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading ปิดตัวลูกศรกลับ .pop
        automaticallyImplyLeading: false,
        title: Text('Product Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditProductScreen(),
                  ));
            },
          )
        ],
      ),
      body: Container(
        child: (products != null)
            ? ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name),
                    trailing: Text(products[index].price.toString()),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddEditProductScreen(products[index])));
                      // print(products[0].productId);
                    },
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
