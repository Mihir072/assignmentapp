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
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      returnPolicy: json['returnPolicy'] ?? 'No return policy available',
      dimensions: json['dimensions'] != null
          ? ProductDimensions.fromJson(json['dimensions'])
          : ProductDimensions(width: 0, height: 0, depth: 0),
      brand: json['brand'] ?? 'Unknown',
      stock: json['stock'] ?? 0,
      sku: json['sku'] ?? 'N/A',
      weight: json['weight'] ?? 0,
      warrantyInformation: json['warrantyInformation'] ?? 'No warranty info',
      shippingInformation:
          json['shippingInformation'] ?? 'Shipping details not available',
      availabilityStatus: json['availabilityStatus'] ?? 'Unknown',
      reviews: json['reviews'] != null
          ? (json['reviews'] as List<dynamic>)
              .map((review) => ProductReview.fromJson(review))
              .toList()
          : [],
      meta: json['meta'] != null
          ? ProductMeta.fromJson(json['meta'])
          : ProductMeta(createdAt: '', updatedAt: '', barcode: '', qrCode: ''),
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
