import 'package:foodapp/data/repository/recommended_product_repo.dart';
import 'package:foodapp/models/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();

    // Check status of the Response
    if (response.statusCode == 200) {
      // print("Berhasil mendapatkan recommended product");
      _recommendedProductList = []; // Make sure not repeated data
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      // print(_recommendedProductList);
      _isLoaded = true;
      update(); // Like setState(){}
    } else {
      // ignore: avoid_print
      print("Gagal mendapatkan recommended product");
    }
  }
}
