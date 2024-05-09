import 'dart:convert';

import 'package:tractian_challenge/app/core/app_constants.dart';
import 'package:tractian_challenge/app/domain/models/company.dart';
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
        list.add(Company(id: i['id'], name: i['name']));
      }
    }
    return list;
  }
}
