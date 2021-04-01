import 'package:firestoreCRUDApp/models/product.dart';
import 'package:firestoreCRUDApp/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  // สร้าง Object FireService
  final firestoreService = FirestoreService();

  String _name;
  double _price;
  String _productId;
  FieldValue _createdOn = FieldValue.serverTimestamp();
  var uuid = Uuid();

  // Getters
  String get name => _name;
  double get price => _price;

  // Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  // ดึงรายการสินค้า
  loadValues(Product product) {
    _name = product.name;
    _price = product.price;
    _productId = product.productId;
  }

  // บันทึกและแก้ไขรายการสินค้า
  saveProduct() {
    // print(_productId);
    // Add Product
    if (_productId == null) {
      var newProduct = Product(
          name: name,
          price: price,
          productId: uuid.v4(),
          createdOn: _createdOn);
      firestoreService.saveProduct(newProduct);
    } else {
      //Update
      var updatedProduct = Product(
          name: name,
          price: _price,
          productId: _productId,
          createdOn: _createdOn);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  // การลบข้อมูลออกจาก firestore
  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
