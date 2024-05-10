import 'package:tractian_challenge/app/domain/models/asset.dart';
import 'package:tractian_challenge/app/domain/models/company.dart';
import 'package:tractian_challenge/app/domain/models/location.dart';

abstract class CompanyRepository {
  Future<List<Company>> getCompanies();
  Future<List<Asset>> getAssets(String id);
  Future<List<Location>> getLocations(String id);
}
