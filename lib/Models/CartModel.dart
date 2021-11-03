import 'dart:convert';

class CartModel {
  bool success;
  String message;
  List<CartProductModel> data;
  CartModel({
    required this.success,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    List<CartProductModel> _products = [];
    if (map["data"].isNotEmpty) {
      map["data"].forEach((v) {
        _products.add(CartProductModel.fromMap(v));
      });
    }
    return CartModel(
      success: map['success'],
      message: map['message'],
      data: List.from(_products),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));
}

class CartProductModel {
  int id;
  int customerId;
  int productId;
  String item;
  int qnt;
  int price;
  int discount;
  int fee;
  int total;
  String createdAt;
  String updatedAt;
  String vars;
  CartProductModel({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.item,
    required this.qnt,
    required this.price,
    required this.discount,
    required this.fee,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.vars,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productId': productId,
      // 'item': item,
      'qnt': qnt,
      'price': price,
      'discount': discount,
      'fee': fee,
      'total': total,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'vars': vars,
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      id: map['id'],
      customerId: map['customer_id'],
      productId: map['product_id'],
      item: map['item'],
      qnt: map['qnt'],
      price: map['price'],
      discount: map['discount'],
      fee: map['fee'],
      total: map['total'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      vars: map['vars'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProductModel.fromJson(String source) =>
      CartProductModel.fromMap(json.decode(source));
}
