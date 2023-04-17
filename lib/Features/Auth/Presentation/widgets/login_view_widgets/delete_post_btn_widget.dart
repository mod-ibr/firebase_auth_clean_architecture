
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return BlocConsumer<PostesBloc, PostesState>(
    //         listener: (context, state) {
    //           if (state is SucceededAddDeleteUpdatePostState) {
    //             SnackBarMessage().showSuccessSnackBar(
    //                 message: state.message, context: context);

    //             Navigator.of(context).pushAndRemoveUntil(
    //                 MaterialPageRoute(
    //                   builder: (_) => const PostesHomePage(),
    //                 ),
    //                 (route) => false);
    //           } else if (state is ErrorPostState) {
    //             Navigator.of(context).pop();
    //             SnackBarMessage().showErrorSnackBar(
    //                 message: state.message, context: context);
    //           }
    //         },
    //         builder: (context, state) {
    //           if (state is LoadingPostState) {
    //             return const AlertDialog(
    //               title: LoadingWidget(),
    //             );
    //           }
    //           return DeleteDialogWidget(postId: postId);
    //         },
    //       );
    //     });
  }
}
