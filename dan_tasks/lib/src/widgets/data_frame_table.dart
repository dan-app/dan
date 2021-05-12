import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/data_frame.dart';
import '../utils/ui_utils.dart';
import '../utils/utils.dart';

class JustDataFrameTable extends StatelessWidget {
  final DataFrame df;

  const JustDataFrameTable({required this.df});

  @override
  Widget build(BuildContext context) {
    final theme = DataTableTheme.of(context);
    return DataTable(
      headingRowHeight: theme.headingRowHeight,
      dataRowHeight: theme.dataRowHeight,
      columnSpacing: 16,
      columns: [
        for (final col in df.columnsData.entries)
          DataColumn(
            label: Text(col.key),
            numeric: col.value.isNumeric,
          ),
      ],
      rows: [
        for (final row in df.rows)
          DataRow(
            cells: [
              for (final val in row)
                DataCell(
                  Text('$val'),
                ),
            ],
          ),
      ],
    );
  }
}

class DataFrameTable extends HookWidget {
  final DataFrame df;
  final bool pinFirstColumn;

  const DataFrameTable({
    required this.df,
    this.pinFirstColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    final scrollControllers = useLinkedScrollControllers(count: 2);
    final pinedColumns = pinFirstColumn ? 1 : 0;
    return Row(
      children: [
        if (pinedColumns > 0) ...[
          _DataFrameTable(
            scrollController: scrollControllers[0],
            df: DataFrame(
              Map.fromEntries(df.columnsData.entries.take(pinedColumns)),
            ),
            horizontalMargin: 16,
          ),
          VerticalDivider(
            width: 0,
          ),
        ],
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _DataFrameTable(
              scrollController: scrollControllers[1],
              df: DataFrame(
                Map.fromEntries(df.columnsData.entries.skip(pinedColumns)),
              ),
              horizontalMargin: 8,
            ),
          ),
        ),
      ],
    );
  }
}

class _DataFrameTable extends StatelessWidget {
  final DataFrame df;
  final ScrollController? scrollController;
  final double? horizontalMargin;

  const _DataFrameTable({
    required this.df,
    this.scrollController,
    this.horizontalMargin,
  });

  List<DataColumn> getColumns({bool visible = true}) {
    return [
      for (final col in df.columnsData.entries)
        DataColumn(
          label: Opacity(
            opacity: visible ? 1 : 0,
            child: Text(
              col.key,
            ),
          ),
          numeric: col.value.isNumeric,
        ),
    ];
  }

  DataCell getCell(String value) {
    return DataCell(
      Text(
        value,
      ),
    );
  }

  DataRow getRowMaxWidth() {
    return DataRow(
      cells: [
        for (final col in df.data)
          getCell(
            col.map((it) => '$it').maxBy((it) => it.length),
            // here we assume that the widest string has always max length
            // which generally may be wrong in edge cases like 'iii' vs 'ww'
            // and cause headers to be slightly shifted from other cells
          ),
      ],
    );
  }

  List<DataRow> getRows() {
    return [
      for (final row in df.rows)
        DataRow(
          cells: [
            for (final val in row)
              DataCell(
                Text('$val'),
              ),
          ],
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (df.columnsCount == 0) {
      return SizedBox.shrink();
    }
    const double columnSpacing = 16;
    return Column(
      children: [
        // always visible columns header
        DataTable(
          columns: getColumns(),
          // add fake hidden row to correctly position headers
          dataRowHeight: 0,
          rows: [
            getRowMaxWidth(),
          ],
          columnSpacing: columnSpacing,
          horizontalMargin: horizontalMargin,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: scrollController,
            child: DataTable(
              // hide columns header here as it was displayed above
              headingRowHeight: 0,
              columns: getColumns(visible: false),
              rows: getRows(),
              columnSpacing: columnSpacing,
              horizontalMargin: horizontalMargin,
            ),
          ),
        ),
      ],
    );
  }
}
