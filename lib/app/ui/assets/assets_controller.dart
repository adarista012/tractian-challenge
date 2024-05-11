// ignore_for_file: prefer_final_fields, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';
import 'package:tractian_challenge/app/domain/models/asset.dart';
import 'package:tractian_challenge/app/domain/models/location.dart';
import 'package:tractian_challenge/app/domain/repositories/company_repository.dart';

class AssetsController extends GetxController {
  bool _isloading = false;
  bool get isLoading => _isloading;
  List<bool> _isOpen = [];
  List<bool> get isOpen => _isOpen;
  bool _isPressedPowerSensor = false;
  bool get isPressedPowerSensor => _isPressedPowerSensor;
  bool _isPressedCritical = false;
  bool get isPressedCritical => _isPressedCritical;
  List<bool> _isOpenSubLocation = [];
  List<bool> _isOpenAssetsInSubLocation = [];
  List<bool> _isOpenAsset = [];
  List<bool> _isOpenSubAssets = [];
  List<bool> _isOpenSubAssetsInSublocation = [];

  List<Location> _locations = [];
  List<Location> _subLocations = [];

  List<Asset> _assets = [];
  List<Asset> _subAssets = [];
  List<Asset> _finalComponents = [];

  List<Asset> _components = [];

  List<Asset> get components => _components;

  final repository = Get.find<CompanyRepository>();
  AssetsController() {
    _init();
  }

  _init() async {
    _locations = [];
    _subLocations = [];
    _components = [];
    _assets = [];
    _subAssets = [];
    _finalComponents = [];
    _isloading = true;
    update();

    final id = Get.arguments;

    final locationsResponse = await repository.getLocations(id);
    final assetsResponse = await repository.getAssets(id);

    for (var l in locationsResponse) {
      l.parentId == null ? _locations.add(l) : _subLocations.add(l);
    }
    for (var a in assetsResponse) {
      a.sensorType == null && a.locationId != null && a.sensorId == null
          ? _assets.add(a)
          : a.parentId == null && a.sensorType != null && a.locationId == null
              ? _components.add(a)
              : a.sensorType == null
                  ? _subAssets.add(a)
                  : _finalComponents.add(a);
    }

    getLocations();

    _isloading = false;
    update();
  }

  List<ExpansionPanel> getLocations() {
    int counter = 0;
    List<ExpansionPanel> l = [];
    List<int> keys = [];
    List<String?> parentIdsSublocations = [];
    List<String?> assetslocations = [];

    for (var i in _locations) {
      _isOpen.add(false);
      keys.add(counter);
      counter++;
    }
    for (var e in _subLocations) {
      parentIdsSublocations.add(e.parentId);
    }
    for (var e in _assets) {
      assetslocations.add(e.locationId);
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
            body: Column(
              children: [
                _assets.isNotEmpty && assetslocations.contains(_locations[i].id)
                    ? Column(
                        children: [
                          ExpansionPanelList(
                            materialGapSize: 0.0,
                            children: getAssets(_locations[i].id),
                            expansionCallback: (int i, bool state) {
                              expansion(i, state, _isOpenAsset);
                            },
                          ),
                        ],
                      )
                    : Container(),
                parentIdsSublocations.contains(_locations[i].id)
                    ? ExpansionPanelList(
                        materialGapSize: 0.0,
                        children: getSublocations(),
                        expansionCallback: (int i, bool s) {
                          expansion(i, s, _isOpenSubLocation);
                        },
                      )
                    : Container(),
              ],
            )),
      );
    }

    return l;
  }

  void expansion(int i, bool state, List<bool> list) {
    list[i] = !list[i];
    update();
  }

  void onPressed() {
    _isPressedPowerSensor = !_isPressedPowerSensor;
    _isloading = true;
    update();
    if (_isPressedPowerSensor == false) {
      _init();
    } else {
      _assets = _assets.where((e) => e.sensorType == 'energy').toList();
      _subAssets = _subAssets.where((e) => e.sensorType == 'energy').toList();
      // _locations = _locations.where((e) => e.sensorType != null).toList();
      // _subLocations = _subLocations.where((e) => e.sensorType == 'energy').toList();
      _components = _components.where((e) => e.sensorType == 'energy').toList();
      _finalComponents =
          _finalComponents.where((e) => e.sensorType == 'energy').toList();
      getLocations();
    }
    _isloading = false;
    update();
  }

  void onPressedCritical() {
    _isPressedCritical = !_isPressedCritical;
    _isloading = true;
    update();
    if (_isPressedCritical == false) {
      _init();
    } else {
      // _assets = _assets.where((e) => e.status == "alert").toList();
      _subAssets = _subAssets.where((e) => e.status == "alert").toList();
      // _locations = _locations.where((e) => e.status != null).toList();
      // _subLocations = _subLocations.where((e) => e.status == "alert").toList();
      _components = _components.where((e) => e.status == "alert").toList();
      _finalComponents =
          _finalComponents.where((e) => e.status == "alert").toList();
      getLocations();
    }
    _isloading = false;
    update();
  }

  List<ExpansionPanel> getSublocations() {
    List<ExpansionPanel> l = [];
    int counter = 0;
    List<int> keys = [];
    List<String?> assetsLocations = [];

    List<String?> finalComponentParentIds = [];
    List<String?> finalComponentLocationIds = [];

    for (var i in _subLocations) {
      _isOpenSubLocation.add(false);
      keys.add(counter);
      counter++;
    }
    for (var e in _assets) {
      assetsLocations.add(e.locationId);
    }
    for (Asset i in _finalComponents) {
      finalComponentLocationIds.add(i.locationId);
      finalComponentParentIds.add(i.parentId);
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
          body: Column(children: [
            assetsLocations.contains(_subLocations[i].id)
                ? ExpansionPanelList(
                    materialGapSize: 0.0,
                    children: getAssetsInSubLocation(_subLocations[i].id),
                    expansionCallback: (int i, bool state) {
                      expansion(i, state, _isOpenAssetsInSubLocation);
                    },
                  )
                : Container(),
          ]),
          // : (finalComponentParentIds.contains(_subLocations[i].id) &&
          //             _finalComponents.isNotEmpty) ||
          //         (finalComponentLocationIds
          //                 .contains(_subLocations[i].id) &&
          //             _finalComponents.isNotEmpty)
          //     ? Column(children: getFinalComponents(_subLocations[i].id))
          //     : Container()),
        ),
      );
    }
    return l;
  }

  List<Widget> getComponents() {
    int counter = 0;
    List<Widget> l = [];
    List<int> keys = [];

    for (var i in _components) {
      _isOpen.add(false);
      keys.add(counter);
      counter++;
    }

    for (var i in keys) {
      l.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            Image.asset('assets/component_icon.png'),
            Flexible(
              child: Text(
                '  ${_components[i].name}  ',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _components[i].status == 'operating'
                ? Image.asset('assets/bolt.png')
                : Container(
                    height: 8.0,
                    width: 8.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColors.red),
                  ),
          ],
        ),
      ));
    }
    return l;
  }

  List<Widget> getFinalComponents(String id) {
    int counter = 0;
    List<Widget> l = [];
    List<int> keys = [];

    for (var i in _finalComponents) {
      keys.add(counter);
      counter++;
    }
    for (var i in keys) {
      if (id == _finalComponents[i].parentId ||
          id == _finalComponents[i].locationId) {
        l.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Text('  |      |   ',
                    style: TextStyle(color: AppColors.mainColor)),
                const SizedBox(width: 8.0),
                Image.asset('assets/component_icon.png'),
                Flexible(
                  child: Text(
                    '  ${_finalComponents[i].name}  ',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  height: 8.0,
                  width: 8.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: _finalComponents[i].status == 'alert'
                        ? AppColors.red
                        : AppColors.green,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    return l;
  }

  List<Widget> getFinalComponentsInSubAsset(String id) {
    int counter = 0;
    List<Widget> l = [];
    List<int> keys = [];

    for (var i in _finalComponents) {
      keys.add(counter);
      counter++;
    }
    for (var i in keys) {
      if (id == _finalComponents[i].parentId ||
          id == _finalComponents[i].locationId) {
        l.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Text('  |    |      |      |   ',
                    style: TextStyle(color: AppColors.mainColor)),
                const SizedBox(width: 8.0),
                Image.asset('assets/component_icon.png'),
                Flexible(
                  child: Text(
                    '  ${_finalComponents[i].name}  ',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _finalComponents[i].status != 'alert'
                    ? Image.asset('assets/bolt.png')
                    : Container(
                        height: 8.0,
                        width: 8.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: AppColors.red),
                      ),
                // Container(
                //   height: 8.0,
                //   width: 8.0,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(16.0),
                //     color: _finalComponents[i].status == 'alert'
                //         ? AppColors.red
                //         : AppColors.green,
                //   ),
                // ),
              ],
            ),
          ),
        );
      }
    }
    return l;
  }

  List<ExpansionPanel> getAssets(String id) {
    int counter = 0;
    List<ExpansionPanel> l = [];
    List<int> keys = [];
    List<String?> subAssetParentIds = [];
    List<String?> finalComponentParentIds = [];
    List<String?> finalComponentLocationIds = [];

    for (var i in _assets) {
      if (id == i.locationId) {
        _isOpenAsset.add(false);
      }
      keys.add(counter);
      counter++;
      // }
    }
    for (var e in _subAssets) {
      subAssetParentIds.add(e.parentId);
    }

    for (Asset i in _finalComponents) {
      finalComponentLocationIds.add(i.locationId);
      finalComponentParentIds.add(i.parentId);
    }

    int openCount = 0;
    for (var i in keys) {
      if (id == _assets[i].locationId) {
        l.add(
          ExpansionPanel(
            isExpanded: _isOpenAsset[openCount],
            headerBuilder: (_, __) {
              return Row(
                children: [
                  Text('  |  ', style: TextStyle(color: AppColors.mainColor)),
                  const SizedBox(width: 8.0),
                  Image.asset('assets/asset_icon.png'),
                  Flexible(
                    child: Text(
                      '  ${_assets[i].name}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
            body: Column(
              children: [
                _subAssets.isNotEmpty &&
                        subAssetParentIds.contains(_assets[i].id)
                    ? ExpansionPanelList(
                        children: getSubAssets(_assets[i].id),
                        expansionCallback: (int i, bool state) {
                          expansion(i, state, _isOpenSubAssets);
                        },
                      )
                    : Container(),
                (finalComponentParentIds.contains(_assets[i].id) &&
                            _finalComponents.isNotEmpty) ||
                        (finalComponentLocationIds.contains(_assets[i].id) &&
                            _finalComponents.isNotEmpty)
                    ? Column(children: getFinalComponents(_assets[i].id))
                    : Container()
              ],
            ),
          ),
        );
        openCount++;
      }
    }

    return l;
  }

  List<ExpansionPanel> getSubAssets(String id) {
    int counter = 0;
    List<ExpansionPanel> l = [];
    List<int> keys = [];

    List<String?> finalComponentParentIds = [];
    List<String?> finalComponentLocationIds = [];

    for (Asset i in _subAssets) {
      if (id == i.parentId) {
        _isOpenSubAssets.add(false);
      }
      keys.add(counter);
      counter++;
    }

    for (Asset i in _finalComponents) {
      finalComponentLocationIds.add(i.locationId);
      finalComponentParentIds.add(i.locationId);
    }

    int openCount = 0;
    for (var i in keys) {
      if (id == _subAssets[i].parentId) {
        l.add(
          ExpansionPanel(
            isExpanded: _isOpenSubAssets[openCount],
            headerBuilder: (_, __) {
              return Row(
                children: [
                  Text('  |    |    |   ',
                      style: TextStyle(color: AppColors.mainColor)),
                  const SizedBox(width: 8.0),
                  Image.asset('assets/asset_icon.png'),
                  Flexible(
                    child: Text(
                      '  ${_subAssets[i].name}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
            body: (finalComponentLocationIds.contains(_subAssets[i].id) ||
                    finalComponentParentIds.contains(_subAssets[i].id))
                ? Container()
                : Container(
                    color: Colors.amber,
                    height: 20,
                    width: 800,
                    child: Text(_subAssets[i].id),
                  ),
          ),
        );
        openCount++;
      }
    }

    return l;
  }

  List<ExpansionPanel> getSubAssetsInSubLocation(String id) {
    int counter = 0;
    List<ExpansionPanel> l = [];
    List<int> keys = [];
    List<String?> finalComponentParentIds = [];
    List<String?> finalComponentLocationIds = [];

    for (var i in _subAssets) {
      if (id == i.parentId) {
        _isOpenSubAssetsInSublocation.add(false);
      }
      keys.add(counter);
      counter++;
    }
    for (Asset i in _finalComponents) {
      finalComponentLocationIds.add(i.locationId);
      finalComponentParentIds.add(i.locationId);
    }

    int openCount = 0;
    for (var i in keys) {
      if (id == _subAssets[i].parentId) {
        l.add(
          ExpansionPanel(
              isExpanded: _isOpenSubAssetsInSublocation[openCount],
              headerBuilder: (_, __) {
                return Row(
                  children: [
                    Text('  |    |      |   ',
                        style: TextStyle(color: AppColors.mainColor)),
                    const SizedBox(width: 8.0),
                    Image.asset('assets/asset_icon.png'),
                    Flexible(
                      child: Text(
                        '  ${_subAssets[i].name}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
              body: (finalComponentParentIds.contains(_subAssets[i].id) &&
                          _finalComponents.isNotEmpty) ||
                      (finalComponentLocationIds.contains(_subAssets[i].id) &&
                          _finalComponents.isNotEmpty)
                  ? Text(_subAssets[i].id)
                  : Column(
                      children:
                          getFinalComponentsInSubAsset(_subAssets[i].id))),
        );
        openCount++;
      }
    }

    return l;
  }

  List<ExpansionPanel> getAssetsInSubLocation(String id) {
    int counter = 0;
    List<ExpansionPanel> l = [];
    List<int> keys = [];
    List<String?> subAssetParentIds = [];
    for (var e in _subAssets) {
      subAssetParentIds.add(e.parentId);
    }

    for (var i in _assets) {
      if (id == i.locationId) {
        _isOpenAssetsInSubLocation.add(false);
      }
      keys.add(counter);
      counter++;
    }
    int openCount = 0;
    for (var i in keys) {
      if (id == _assets[i].locationId) {
        l.add(
          ExpansionPanel(
            isExpanded: _isOpenAssetsInSubLocation[openCount],
            headerBuilder: (_, __) {
              return Row(
                children: [
                  Text('  |    |  ',
                      style: TextStyle(color: AppColors.mainColor)),
                  const SizedBox(width: 8.0),
                  Image.asset('assets/asset_icon.png'),
                  Flexible(
                    child: Text(
                      '  ${_assets[i].name}',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
            body: _subAssets.isNotEmpty &&
                    subAssetParentIds.contains(_assets[i].id)
                ? Column(
                    children: [
                      ExpansionPanelList(
                        children: getSubAssetsInSubLocation(_assets[i].id),
                        expansionCallback: (int i, bool state) {
                          expansion(i, state, _isOpenSubAssetsInSublocation);
                        },
                      ),
                    ],
                  )
                : Container(),
            // parentIdsAssets.contains(_locations[i].id)
            //     ? Column(
            //         children: [
            //           ExpansionPanelList(
            //             children: getSublocations(),
            //             expansionCallback: expansionSublocations,
            //           ),
            //           // _subAssets.isNotEmpty
            //           //     ? Column(children: getComponents())
            //           //     : Container()
            //         ],
            //       )
            //     : Container(),
          ),
        );
        openCount++;
      }
    }

    return l;
  }
}
