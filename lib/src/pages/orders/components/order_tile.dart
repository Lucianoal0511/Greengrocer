import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:greengrocer/src/pages/orders/components/order_status_widget.dart';
import 'package:greengrocer/src/pages/orders/controller/order_controller.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  OrderTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
            dividerColor:
                Colors.transparent), //Para sumir com a borda do ExpansionTile
        child: GetBuilder<OrderController>(
          init: OrderController(order),
          global: false,
          builder: (controller) {
            return ExpansionTile(
              onExpansionChanged: (value) {
                if (value && order.items.isEmpty) {
                  controller.getOrderItems();
                }
              },
              // initiallyExpanded: order.status == 'pending_payment',
              //colapsar várias informacoes em uma coluna
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pedido: ${order.id}'),
                  Text(
                    utilsServices.formatDateTime(order.createDateTime!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              //Coloca o conteúdo iniciando da esquerda
              children: controller.isLoading
                  ? [
                      Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                    ]
                  : [
                      IntrinsicHeight(
                        //Altura intrinseca, independente
                        child: Row(
                          children: [
                            //Lista de Produtos
                            Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children: order.items.map((orderItem) {
                                      return _OrderItemWidget(
                                        utilsServices: utilsServices,
                                        orderItem: orderItem,
                                      );
                                    }).toList(),
                                  ),
                                )),
                            //Divisão
                            VerticalDivider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                              width: 8,
                            ),
                            //Status do pedido
                            Expanded(
                              flex: 2,
                              child: OrderStatusWidget(
                                status: order.status,
                                isOverdue: order.overdueDateTime.isBefore(DateTime
                                    .now()), //Aqui vai fazer a verificação de validade do tempo
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Total
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          children: [
                            const TextSpan(
                                text: 'Total ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    utilsServices.priceToCurrency(order.total))
                          ],
                        ),
                      ),
                      //Botão Pagamento
                      Visibility(
                        visible: order.status == 'pending_payment' &&
                            !order.isOverDue,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return PaymentDialog(
                                  order: order,
                                );
                              },
                            );
                          },
                          icon: Image.asset(
                            'assets/app_images/pix.png',
                            height: 18,
                          ),
                          label: const Text('Ver QR Code Pix'),
                        ),
                        // replacement: outro widget,//Caso queira incrementar colocando um outro widget no lugar do botão
                      ),
                    ],
            );
          },
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(utilsServices.priceToCurrency(orderItem.totalPrice()))
        ],
      ),
    );
  }
}
