import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/order/orderRepository.dart';
import 'package:product_catalogue/data/repository/product/productRepository.dart';
import 'package:product_catalogue/features/shop/model/orderedProductModel.dart';
import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/strings.dart';
import '../../model/orderModel.dart';
import '../../model/productModel.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final isLoading = false.obs;
  final note = TextEditingController();
  RxList<OrderModel> orders = <OrderModel>[].obs;
  RxList<OrderModel> ongoingOrder = <OrderModel>[].obs;
  RxList<OrderModel> completedOrder = <OrderModel>[].obs;
  Rx<OrderModel> orderById = OrderModel.empty().obs;
  RxList<OrderedProductModel> productsByOrder = <OrderedProductModel>[].obs;
  RxList<ProductModel> productsByProductId = <ProductModel>[].obs;

  final orderRepository = Get.put(OrderRepository());
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final fetchedOrders = await orderRepository.fetchOrders();

      if (fetchedOrders.isNotEmpty) {
        orders.assignAll(fetchedOrders);
      } else {
        orders.assignAll([]);
      }

      fetchOngoingOrders();
      fetchCompleteOrders();
    } catch (e) {
      orders.assignAll([]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOngoingOrders() async {
    try {
      isLoading.value = true;
      final ordersNotDelivered = orders
          .where((element) => element.status != OrderStatus.delivered && element.id.isNotEmpty)
          .toList();
      ongoingOrder.assignAll(ordersNotDelivered);
    } catch (e) {
      ongoingOrder.assignAll([]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCompleteOrders() async {
    try {
      isLoading.value = true;
      final ordersDelivered = orders
          .where((element) => element.status == OrderStatus.delivered && element.id.isNotEmpty)
          .toList();
      completedOrder.assignAll(ordersDelivered);
    } catch (e) {
      completedOrder.assignAll([]);
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchOrderById(String orderId) async {
    try {
      isLoading.value = true;
      final fetchedOrder = await orderRepository.fetchOrderById(orderId);
      orderById.value = fetchedOrder;
    } catch (e) {
      orderById.value = OrderModel.empty();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductsByOrderId(String orderId) async {
    try {
      isLoading.value = true;
      final fetchedProducts = await orderRepository.fetchProductsByOrderId(orderId);
      productsByOrder.assignAll(fetchedProducts);

      final ids = productsByOrder.map((element) => element.productId).toList();
      List<ProductModel> fetchedProductsById = [];

      for (String id in ids) {
        final product = await productRepository.fetchProductById(id);
        fetchedProductsById.add(product);
      }

      productsByProductId.assignAll(fetchedProductsById);
    } catch (e) {
      productsByOrder.assignAll([]);
      productsByProductId.assignAll([ProductModel.empty()]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder(OrderModel order) async {
    try {
      await orderRepository.createOrder(order);

      final fetchedOrder = await orderRepository.fetchOrderById(order.id);
      orderById.value = fetchedOrder;

      fetchOrderById(order.id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      await orderRepository.updateOrder(order);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateNote(String orderId, String note) async {
    try {
      final data = {Strings.fieldNote: note};
      await orderRepository.updateSingleField(orderId, data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteOrderById(String orderId) async {
    try {
      await orderRepository.removeOrder(orderId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createProductByOrder(String orderId, List<OrderedProductModel> product) async {
    try {
      isLoading.value = true;
      for (var orderedProduct in product) {
        await orderRepository.addProductToOrder(orderId, orderedProduct);
      }

      final fetchedProducts = await orderRepository.fetchProductsByOrderId(orderId);
      productsByOrder.assignAll(fetchedProducts);

      final ids = productsByOrder.map((element) => element.productId).toList();
      final fetchedProductsById = await Future.wait(
        ids.map((id) => productRepository.fetchProductById(id))
      );

      productsByProductId.assignAll(fetchedProductsById);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearOrderById() {
    orderById.value = OrderModel.empty();
  }

  void clearProductsByOrder() {
    productsByOrder.value = [];
  }

  void clearProductsByProductId() {
    productsByProductId.value = [];
  }
}