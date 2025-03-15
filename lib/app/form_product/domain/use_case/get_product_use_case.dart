import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/form_product/presentation/model/product_form_model.dart';

class GetProductUseCase {
  final FormProductRepository formProductRepository;

  GetProductUseCase({required this.formProductRepository});

  Future<ProductFormModel> invoke(String id) async {
    try {
      final ProductEntity data = await formProductRepository.getProduct(id);

      return ProductFormModel(
          id: id,
          name: data.name,
          price: data.price.toString(),
          urlImage: data.image);
    } catch (e) {
      throw (Exception(e));
    }
  }
}
