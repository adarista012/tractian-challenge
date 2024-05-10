import 'dart:convert';
import 'package:tractian_challenge/app/core/app_constants.dart';
import 'package:tractian_challenge/app/domain/models/asset.dart';
import 'package:tractian_challenge/app/domain/models/company.dart';
import 'package:tractian_challenge/app/domain/models/location.dart';
import 'package:tractian_challenge/app/domain/repositories/company_repository.dart';
import 'package:http/http.dart' as http;

class CompanyRepositoryImpl extends CompanyRepository {
  @override
  Future<List<Company>> getCompanies() async {
    List<Company> list = [];
    final url = Uri.https(AppConstants.API, AppConstants.COMPANIES);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var i in res) {
        list.add(Company.fromJson(i));
      }
    }
    return list;
  }

  @override
  Future<List<Asset>> getAssets(String id) async {
    List<Asset> list = [];
    final url =
        Uri.https(AppConstants.API, '${AppConstants.COMPANIES}/$id/assets');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      for (var i in res) {
        list.add(Asset.fromJson(i));
      }
    }
    return list;
  }

  @override
  Future<List<Location>> getLocations(String id) async {
    List<Location> list = [];
    final url =
        Uri.https(AppConstants.API, '${AppConstants.COMPANIES}/$id/locations');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);

      for (var i in res) {
        list.add(Location.fromJson(i));
      }
    }
    return list;
  }
}
