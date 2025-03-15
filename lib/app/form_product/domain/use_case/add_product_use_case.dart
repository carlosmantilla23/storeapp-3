import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/form_product/presentation/model/product_form_model.dart';

class AddProductUseCase {
  final FormProductRepository formProductRepository;

  AddProductUseCase({required this.formProductRepository});

  Future<bool> invoke(ProductFormModel productFormModel) {
    final ProductEntity data = productFormModel.toEntity();

    try {
      return formProductRepository.addProduct(data);
    } catch (e) {
      throw (Exception(e));
    }
  }
}
