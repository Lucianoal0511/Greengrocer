import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/orders/components/order_tile.dart';
import 'package:greengrocer/src/pages/orders/controller/all_orders_controller.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(builder: (controller) {
        return RefreshIndicator(
          onRefresh: () => controller.getAllOrders(),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            //Para sempre ter o comportamento de rolagem
            itemBuilder: (_, index) {
              return OrderTile(order: controller.allOrders[index]);
            },
            separatorBuilder: (_, index) => const SizedBox(
              height: 10,
            ),
            //Foi colocado uma altura no separador
            itemCount: controller.allOrders.length,
          ),
        );
      }),
    );
  }
}
