import 'package:flutter/material.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  const UpdatePostBtnWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (_) => PostAddUpdatePage(
        //         isUpdatePost: true,
        //         post: postEntity,
        //       ),
        //     ));
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}
