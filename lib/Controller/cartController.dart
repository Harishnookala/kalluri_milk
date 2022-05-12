import 'package:get/get.dart';
import 'package:kalluri_milk/UserScreens/add_products.dart';

class cartController extends GetxController{
  var products = {}.obs;

  add_products(product_items){
    products.containsKey(product_items);
    product_items +=1;
  }
  decrement_products(product_items){
    products.containsKey(product_items);
    product_items-=1;
  }
}