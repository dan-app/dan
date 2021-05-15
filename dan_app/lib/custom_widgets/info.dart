import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/theme/color_theme.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String name;
  final String uid;
  final void Function() onTap;

  const Info({
    required this.name,
    required this.uid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
          ),
          child: Center(
            child: Stack(
              children: [
                FutureBuilder<String>(
                    future: FirestoreController.getAvatarLink(uid),
                    builder: (context, snapshot) {
                      return CircleAvatar(
                        radius: 59,
                        child:
                            snapshot.connectionState == ConnectionState.none ||
                                    snapshot.data == null
                                ? null
                                : Image.network(snapshot.data!),
                      );
                    }),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorPalette.violet_500,
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                        border: Border.all(
                          width: 1.5,
                          color: ColorPalette.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          name,
          style: TextThemes.subTitle_1,
        ),
      ],
    );
  }
}
