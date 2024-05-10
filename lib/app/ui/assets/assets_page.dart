import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/core/colors/app_colors.dart';
import 'package:tractian_challenge/app/ui/assets/assets_controller.dart';
import 'package:tractian_challenge/app/ui/assets/widgest/custom_app_bar.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Assets',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: AssetsController(),
          builder: (_) {
            return Column(
              children: [
                Container(
                  height: 136.0,
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    children: [
                      const TextField(),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('power Sensor'),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Critical'),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
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
                          expansionCallback: _.expansion,
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
