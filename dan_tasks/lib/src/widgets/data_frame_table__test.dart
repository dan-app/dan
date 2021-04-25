import 'package:flutter/material.dart';

import '../data/df_iris.dart';
import 'data_frame_table.dart';

class DataFrameTableTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DataFrameTable(
        df: dfIris,
        pinFirstColumn: true,
      ),
    );
  }
}
