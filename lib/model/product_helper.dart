class ProductInfo {
  final String id;
  final String name;
  final String moq;
  final String price;
  final String discounted_price;

  ProductInfo(
      {required this.id,
      required this.name,
      required this.moq,
      required this.price,
      required this.discounted_price});

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      moq: json['moq'] as String,
      price: json['price'] as String,
      discounted_price: json['discounted_price'] as String,
    );
  }
}
