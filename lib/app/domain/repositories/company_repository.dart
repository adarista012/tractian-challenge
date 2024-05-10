import 'package:tractian_challenge/app/domain/models/assets.dart';
import 'package:tractian_challenge/app/domain/models/company.dart';
import 'package:tractian_challenge/app/domain/models/locations.dart';

abstract class CompanyRepository {
  Future<List<Company>> getCompanies();
  Future<List<Assets>> getAssets(String id);
  Future<List<Location>> getLocations(String id);
}
