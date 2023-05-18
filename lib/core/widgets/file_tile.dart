import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  const FileTile(
      {required this.onTap,
      required this.isFolder,
      required this.title,
      super.key});
  final void Function()? onTap;
  final bool isFolder;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(isFolder ? 0xFF8DA1AF : 0xFFDCEAF6),
          borderRadius: BorderRadius.circular(9),
        ),
        child: ListTile(
          tileColor: const Color(0xffecf0f3),
          leading: Icon(isFolder ? Icons.folder : Icons.insert_drive_file),
          title: Text(
            title ?? "file name is empty",
            style: const TextStyle(color: Color(0xff333333)),
          ),
        ),
      ),
    );
  }
}
