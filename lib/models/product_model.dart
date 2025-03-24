class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final String thumbnail;
  final String returnPolicy;
  final ProductDimensions dimensions;
  final String brand;
  final int stock;
  final String sku;
  final int weight;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ProductReview> reviews;
  final ProductMeta meta;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
    required this.returnPolicy,
    required this.dimensions,
    required this.brand,
    required this.stock,
    required this.sku,
    required this.weight,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.meta,
    this.quantity = 1,
  });

  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      discountPercentage: discountPercentage,
      thumbnail: thumbnail,
      returnPolicy: returnPolicy,
      dimensions: dimensions,
      brand: brand,
      stock: stock,
      sku: sku,
      weight: weight,
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      reviews: reviews,
      meta: meta,
      quantity: quantity ?? this.quantity,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      thumbnail: json['thumbnail'],
      returnPolicy: json['returnPolicy'],
      dimensions: ProductDimensions.fromJson(json['dimensions']),
      brand: json['brand'],
      stock: json['stock'],
      sku: json['sku'],
      weight: json['weight'],
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews: (json['reviews'] as List<dynamic>)
          .map((review) => ProductReview.fromJson(review))
          .toList(),
      meta: ProductMeta.fromJson(json['meta']),
      quantity: 1,
    );
  }
}

class ProductDimensions {
  final double width;
  final double height;
  final double depth;

  ProductDimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) {
    return ProductDimensions(
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      depth: json['depth'].toDouble(),
    );
  }
}

class ProductReview {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  ProductReview({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

class ProductMeta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  ProductMeta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory ProductMeta.fromJson(Map<String, dynamic> json) {
    return ProductMeta(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      barcode: json['barcode'],
      qrCode: json['qrCode'],
    );
  }
}
