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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isFolder
              ? Theme.of(context).colorScheme.onSecondary
              : Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(9),
        ),
        child: ListTile(
          leading: Icon(isFolder ? Icons.folder : Icons.insert_drive_file),
          title: Text(title ?? "file name is empty",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium),
        ),
      ),
    );
  }
}
