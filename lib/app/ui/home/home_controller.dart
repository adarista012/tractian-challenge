import 'package:get/get.dart';
import 'package:tractian_challenge/app/domain/repositories/company_repository.dart';
import 'package:tractian_challenge/app/ui/home/widgets/home_generic_button.dart';

class HomeController extends GetxController {
  bool _isloading = false;
  bool get isLoading => _isloading;

  List<HomeGenericButton> listOfButtons = [];

  HomeController() {
    _init();
  }

  final repository = Get.find<CompanyRepository>();

  void _init() async {
    _isloading = true;
    update();

    final listOfCompanies = await repository.getCompanies();

    if (listOfCompanies.isNotEmpty) {
      listOfButtons = listOfCompanies
          .map(
            (e) => HomeGenericButton(
              title: e.name,
              id: e.id,
              onPressed: () {},
            ),
          )
          .toList();
    }

    _isloading = false;
    update();
  }
}
