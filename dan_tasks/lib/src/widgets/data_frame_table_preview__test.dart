import 'package:flutter/material.dart';

import '../data/df_iris.dart';
import 'data_frame_table_preview.dart';

class DataFrameTablePreviewTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          DataFrameTablePreview(
            df: dfIris,
          ),
        ],
      ),
    );
  }
}
