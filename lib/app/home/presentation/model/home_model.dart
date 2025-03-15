import 'package:storeapp/app/home/presentation/model/product_model.dart';

class HomeModel {
  final List<ProductModel> products;

  HomeModel({required this.products});

  HomeModel copyWith({required List<ProductModel>? products}) {
    return HomeModel(
      products: products ?? this.products,
    );
  }
}
