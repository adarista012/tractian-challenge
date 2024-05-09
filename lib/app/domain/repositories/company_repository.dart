import 'package:tractian_challenge/app/domain/models/company.dart';

abstract class CompanyRepository {
  Future<List<Company>> getCompanies();
}
