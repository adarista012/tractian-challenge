import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/ui/assets/assets_controller.dart';
import 'package:tractian_challenge/app/ui/assets/widgest/custom_app_bar.dart';
import 'package:tractian_challenge/app/ui/assets/widgest/header.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: AssetsController(),
          builder: (_) {
            return Column(
              children: [
                const Header(),
                _.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(64.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ExpansionPanelList(
                            elevation: 1,
                            children: _.getLocations(),
                            expansionCallback: (int i, bool s) {
                              _.expansion(i, s, _.isOpen);
                            }),
                      ),
                _.components.isNotEmpty
                    ? Column(children: _.getComponents())
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
