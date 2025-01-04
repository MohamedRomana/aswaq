import 'package:flutter/material.dart';
import 'widgets/custom_acount_details.dart';
import 'widgets/custom_changes_app_container.dart';
import 'widgets/custom_more_profile_row.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomMoreProfileRow(),
          CustomAccountDetails(),
          CustomChangesAppContainer(),
        ],
      ),
    );
  }
}
