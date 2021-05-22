import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/theme/color_theme.dart';
import 'package:dan_app/theme/text_theme.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String uid;
  final void Function() onTap;

  const Info({
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
                        foregroundImage:
                            snapshot.connectionState == ConnectionState.none ||
                                    snapshot.data == null
                                ? null
                                : NetworkImage(snapshot.data!),
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
                        color: Colors.blue,
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
        FutureBuilder<String>(
            future: FirestoreController.getUsernameById(uid),
            builder: (context, snapshot) {
              return Text(
                snapshot.data!,
                style: TextThemes.headline_5,
              );
            }),
      ],
    );
  }
}
