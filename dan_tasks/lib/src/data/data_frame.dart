import 'package:quiver/iterables.dart';

import 'series.dart';

class DataFrame {
  final Map<String, Series<Object?>> columnsData;

  List<String> get columns => columnsData.keys.toList();

  int get columnsCount => columnsData.length;

  int get rowsCount => columnsData.values.first.data.length;

  Map<String, Type> get dTypes {
    return columnsData.map(
      (name, series) => MapEntry(name, series.dType),
    );
  }

  Map<String, List<Object?>> get dict {
    return columnsData.map(
      (name, series) => MapEntry(name, series.data),
    );
  }

  Iterable<List<Object?>> get data => columnsData.values.map((s) => s.data);

  Iterable<List<Object?>> get rows => zip<dynamic>(data);

  DataFrame(this.columnsData)
      : assert(
          columnsData.values.every(
            (s) => s.data.length == columnsData.values.first.data.length,
          ),
        );

  factory DataFrame.fromLists(Map<String, List<Object?>> data) {
    return DataFrame(
      data.map(
        (name, list) => MapEntry(name, Series.from(list)),
      ),
    );
  }

  DataFrame head(int n) {
    return DataFrame(
      columnsData.map(
        (key, value) => MapEntry(
          key,
          value.head(n),
        ),
      ),
    );
  }

  DataFrame selectColumns(List<String> names) {
    return DataFrame(
      Map.fromEntries(
        columnsData.entries.where(
          (it) => names.contains(it.key),
        ),
      ),
    );
  }

  DataFrame selectRow(int index) {
    return DataFrame(
      columnsData.map(
        (key, value) => MapEntry(
          key,
          Series([value.data[index]]),
        ),
      ),
    );
  }
}
