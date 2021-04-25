import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/data_frame.dart';
import 'data_frame_table.dart';

class DataFrameTablePreview extends StatelessWidget {
  final DataFrame df;

  const DataFrameTablePreview({
    required this.df,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 200,
        ),
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => _DataFrameTablePage(df: df),
            ),
          ),
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: const [.25, .95],
                ).createShader(
                  Rect.fromLTRB(0, 0, rect.width, rect.height),
                ),
                blendMode: BlendMode.dstIn,
                child: ClipRect(
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: AlignmentDirectional.topStart,
                    child: OverflowBox(
                      maxWidth: double.infinity,
                      maxHeight: double.infinity,
                      alignment: AlignmentDirectional.topStart,
                      child: IgnorePointer(
                        child: DataTableTheme(
                          data: DataTableThemeData(
                            headingRowHeight: 36,
                            dataRowHeight: 32,
                          ),
                          child: JustDataFrameTable(df: df),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.fullscreen,
                    color: Theme.of(context).iconTheme.color!.withOpacity(.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DataFrameTablePage extends HookWidget {
  final DataFrame df;

  const _DataFrameTablePage({
    required this.df,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DataFrameTable(
          df: df,
          pinFirstColumn: true,
        ),
      ),
      floatingActionButton: CupertinoButton(
        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.4),
          minSize: 64,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(64),
          onPressed: () => Navigator.of(context).pop(),
          child: Icon(Icons.fullscreen_exit),
      ),
    );
  }
}
