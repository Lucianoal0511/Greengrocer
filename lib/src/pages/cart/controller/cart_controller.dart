import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/app_data.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

import '../../common_widgets/payment_dialog.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  Future checkoutCart() async {
    CartResult<OrderModel> result = await cartRepository.checkoutCart(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );

    result.when(
      success: (order) {
        showDialog(
          context: Get.context!,
          builder: (_) {
            return PaymentDialog(
              order: order,
            );
          },
        );
      },
      error: (message) {
        utilsServices.showToast(
          message: 'Pedido não confirmado :(',
        );
      },
    );
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      cartItemId: item.id,
      quantity: quantity,
      token: authController.user.token!,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }
      update();
    } else {
      utilsServices.showToast(
        message: 'Ocorreu um erro ao alterar a quantidade do produto',
        isError: true,
      );
    }

    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      //Sabe-se que não são dados nulos
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  //Método para mostrar a quantidade de itens de forma unitária
  int getCartTotalItems() {
    return cartItems.isEmpty
        ? 0
        : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  //Verifica se o item colocado no carrinho é o da lista
  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];
      await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utilsServices.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }

    update();
  }
}
