import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class DeleteProductsUseCase {
  final HomeRepository homeRepository;

  DeleteProductsUseCase({required this.homeRepository});

  Future<bool> invoke(String id) {
    try {
      return homeRepository.deleteProduct(id);
    } catch (e) {
      throw (Exception(e));
    }
  }
}
