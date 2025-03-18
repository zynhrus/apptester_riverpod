import 'package:flutter/material.dart';

class SubmissionAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SubmissionAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Submission"),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight
      );
}