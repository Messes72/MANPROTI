class DonationModel {
  final int? id;
  final String type;
  final String quantity;
  final String shippingMethod;
  final String notes;
  final String? status;
  final String? createdAt;

  DonationModel({
    this.id,
    required this.type,
    required this.quantity,
    required this.shippingMethod,
    required this.notes,
    this.status,
    this.createdAt,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      type: json['type'],
      quantity: json['quantity'].toString(),
      shippingMethod: json['shippingMethod'] ?? json['shipping_method'],
      notes: json['notes'] ?? '-',
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'quantity': quantity,
      'shipping_method': shippingMethod,
      'notes': notes,
    };
  }
}
