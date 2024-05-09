import 'package:get/get.dart';
import 'package:tractian_challenge/app/data/implementation%20repositories/company_repository_impl.dart';
import 'package:tractian_challenge/app/domain/repositories/company_repository.dart';

class InjectDependencies {
  static init() {
    Get.lazyPut<CompanyRepository>(() => CompanyRepositoryImpl());
  }
}
