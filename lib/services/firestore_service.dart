import 'package:firestoreCRUDApp/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // สร้างฟังก์ชันไว้บันทึกข้อมูล Product เข้า Firestore
  Future<void> saveProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.productId)
        .set(product.toMap());
  }

  // สร้างฟังก์ชันในการอ่านข้อมูล Product
  Stream<List<Product>> getProducts() {
    return _db
        .collection('products')
        .orderBy('createdOn', descending: false)
        // .orderBy(field) เรียงหลายลำดับซ้อนได้
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Product.fromFirestore(document.data()))
            .toList());
  }

  // สร้างฟังก์ชันในการลบข้อมูล Product
  Future<void> removeProduct(String productId) {
    return _db.collection('products').doc(productId).delete();
  }
}
