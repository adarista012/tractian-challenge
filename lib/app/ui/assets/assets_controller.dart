import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';
import 'package:tractian_challenge/app/domain/models/locations.dart';
import 'package:tractian_challenge/app/domain/repositories/company_repository.dart';

class AssetsController extends GetxController {
  bool _isloading = false;
  bool get isLoading => _isloading;
  List<bool> _isOpen = [];
  List<bool> _isOpenSubLocation = [];
  // List<ExpansionPanel> _listOfLocations = [];
  // List<ExpansionPanel> get listOfLocations => _listOfLocations;

  List<Location> _locations = [];
  List<Location> _subLocations = [];

  final repository = Get.find<CompanyRepository>();
  AssetsController() {
    _init();
  }

  _init() async {
    _locations = [];
    _subLocations = [];
    _isloading = true;
    update();

    final id = Get.arguments;

    // await repository.getAssets(id);
    // final locationsResponse = await repository.getLocations(id);

    final locationsResponse = await repository.getLocations(id);

    for (var l in locationsResponse) {
      l.parentId == null ? _locations.add(l) : _subLocations.add(l);
    }

    getLocations();

    _isloading = false;
    update();
  }

  List<ExpansionPanel> getLocations() {
    int counter = 0;
    List<ExpansionPanel> l = [];
    List<int> keys = [];
    List<String> parentIdsSublocations = [];

    for (var i in _locations) {
      _isOpen.add(false);
      keys.add(counter);
      counter++;
    }
    for (var e in _subLocations) {
      parentIdsSublocations.add(e.parentId!);
    }

    for (var i in keys) {
      l.add(
        ExpansionPanel(
          isExpanded: _isOpen[i],
          headerBuilder: (_, __) {
            return Row(
              children: [
                Image.asset('assets/location_icon.png'),
                Flexible(
                  child: Text(
                    '  ${_locations[i].name}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
          body: parentIdsSublocations.contains(_locations[i].id)
              ? ExpansionPanelList(
                  children: getSublocations(),
                  expansionCallback: expansionSublocations,
                )
              : const Text('empty'),
        ),
      );
    }

    return l;
  }

  void expansion(int i, bool state) {
    _isOpen[i] = !_isOpen[i];
    update();
  }

  void expansionSublocations(int i, bool state) {
    _isOpenSubLocation[i] = !_isOpenSubLocation[i];
    update();
  }

  List<ExpansionPanel> getSublocations() {
    List<ExpansionPanel> l = [];
    int counter = 0;
    List<int> keys = [];

    for (var i in _subLocations) {
      _isOpenSubLocation.add(false);
      keys.add(counter);
      counter++;
    }

    for (var i in keys) {
      l.add(
        ExpansionPanel(
          isExpanded: _isOpenSubLocation[i],
          headerBuilder: (_, __) {
            return Row(
              children: [
                Text('  |', style: TextStyle(color: AppColors.mainColor)),
                const SizedBox(width: 8.0),
                Image.asset('assets/location_icon.png'),
                Flexible(
                  child: Text(
                    '  ${_subLocations[i].name}',
                  ),
                ),
              ],
            );
          },
          body: Text('empty'),
        ),
      );
    }
    return l;
  }
}
