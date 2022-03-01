

import 'package:apex2/models/CartModel.dart';
import 'package:apex2/models/CategoryModel.dart';
import 'package:apex2/models/ProductModel.dart';

String token = '';
String uId = '';
String activeCodePhone = '';
String activeCodeEmail = '';

CategoryModel categoriesModel;
ProductModel productModel;
CartModel cartModel;

String printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
  return text;
}
