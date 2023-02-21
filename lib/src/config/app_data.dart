import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/models/user_model.dart';

ItemModel apple = ItemModel(
  itemName: 'Maçã',
  imgUrl: 'assets/fruits/apple.png',
  unit: 'Kg',
  price: 5.5,
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/fruits/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
  'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/fruits/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
  'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
  'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/fruits/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
  'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
  'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

List<String> categorias = [
  'Frutas',
  'Grãos',
  'Verduras',
  'Temperos',
  'Cereais',
];

List<CartItemModel> cartItems = [
  // CartItemModel(item: apple, quantity: 1,),
  // CartItemModel(item: mango, quantity: 1,),
  // CartItemModel(item: guava, quantity: 3,),
];

UserModel user = UserModel(
    name: 'Luciano',
    email: 'lucianoal0511@gmail.com',
    phone: '71 9 9918-3378',
    cpf: '897.735.865-53',
    password: '',
);

List<OrderModel> orders = [
  //Pedido 1
  OrderModel(
    id: 'hfjdhdjdkjfhj',
    createDateTime: DateTime.parse('2022-12-04 10:00:10.458'),
    overdueDateTime: DateTime.parse('2022-12-05 11:00:10.458'),
    items: [
      // CartItemModel(
      //     item: apple,
      //     quantity: 2
      // ),
      // CartItemModel(
      //     item: mango,
      //     quantity: 3
      // ),
    ],
    status: 'pending_payment',
    copyAndPaste: 'heujeufhjfdhj',
    total: 11.0,
  ),
  //Pedido 2
  OrderModel(
    id: 'hfjdhdjdkjfhj',
    createDateTime: DateTime.parse('2022-12-04 14:00:10.458'),
    overdueDateTime: DateTime.parse('2022-12-05 15:00:10.458'),
    items: [
      // CartItemModel(
      //     item: grape,
      //     quantity: 2
      // ),
      // CartItemModel(
      //     item: guava,
      //     quantity: 3
      // ),
    ],
    status: 'delivered',
    copyAndPaste: 'heujeufhjfdhj',
    total: 15.0,
  ),
];