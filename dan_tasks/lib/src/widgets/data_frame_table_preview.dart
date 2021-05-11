import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/data_frame.dart';
import 'data_frame_table.dart';

class DataFrameTablePreview extends StatelessWidget {
  final DataFrame df;
  final DataFrame dfHead;

  factory DataFrameTablePreview({
    required DataFrame df,
  }) {
    return DataFrameTablePreview._(
      df: df,
      dfHead: df.head(10),
    );
  }

  const DataFrameTablePreview._({
    required this.df,
    required this.dfHead,
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
              _Fade(
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
                          child: JustDataFrameTable(df: dfHead),
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

class _Fade extends StatelessWidget {
  final Widget child;

  const _Fade({required this.child});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // shader fading not supported
      return child;
    }
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Colors.black, Colors.transparent],
        stops: const [.25, .95],
      ).createShader(
        Rect.fromLTRB(0, 0, rect.width, rect.height),
      ),
      blendMode: BlendMode.dstIn,
      child: child,
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
