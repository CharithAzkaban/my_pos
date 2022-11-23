import 'package:flutter/cupertino.dart';

class NoData extends StatelessWidget {
  final String? noDataMessage;
  const NoData({super.key, this.noDataMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(noDataMessage ?? 'No data available'),
    );
  }
}