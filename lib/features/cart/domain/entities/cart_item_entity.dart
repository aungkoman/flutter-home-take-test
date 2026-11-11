import '../../../order/domain/entities/cart_entity.dart';
import '../../../product/domain/entities/product_entity.dart';

class CartItemEntity {
  const CartItemEntity({required this.cart, required this.quantity});

  final CartEntity cart;
  final int quantity;

  ProductEntity get product => cart.product;
  int get id => cart.id;
  int get userId => cart.userId;
  int get shopId => cart.shopId;

  double? get subtotal =>
      product.price == null ? null : product.price! * quantity;

  CartItemEntity copyWith({int? quantity}) => CartItemEntity(
    cart: cart,
    quantity: quantity ?? this.quantity,
  );
}
