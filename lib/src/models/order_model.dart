import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  String id;

  @JsonKey(name: 'createdAt')
  DateTime? createDateTime; //pode ser nulo

  @JsonKey(name: 'due')
  DateTime overdueDateTime;

  @JsonKey(defaultValue: [])
  List<CartItemModel> items; //aqui indica que a lista é vazia por default
  String status;
  String qrCodeImage;

  @JsonKey(name: 'copiaecola')
  String copyAndPaste;
  double total;

  OrderModel({
    required this.id,
    this.createDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.qrCodeImage,
    required this.copyAndPaste,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  String toString() {
    return 'OrderModel{id: $id, createDateTime: $createDateTime, overdueDateTime: $overdueDateTime, items: $items, status: $status, qrCodeImage: $qrCodeImage, copyAndPaste: $copyAndPaste, total: $total}';
  }
}
