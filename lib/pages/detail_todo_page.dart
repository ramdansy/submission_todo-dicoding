import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:submission_todo/common/app_constant.dart';
import 'package:submission_todo/common/app_text.dart';
import 'package:submission_todo/models/todo_model.dart';

class DetailTodo extends StatelessWidget {
  final ToDo todo;
  const DetailTodo({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDeleteConfirmationDialog(context);
              // Navigator.pop(context, todo.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
        title: Text(
          "Detail ${AppConstant.appName}",
          style: AppText.fHeading6
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(AppConstant.paddingNormal),
          child: ListView(
            children: [
              TextLabelWidget(title: AppConstant.textTag, desc: todo.tag),
              AppConstant.spaceHeightNormal,
              TextLabelWidget(
                title: AppConstant.textTime,
                desc: DateFormat('dd MMMM yyyy - HH:mm', "id_ID")
                    .format(todo.time),
              ),
              AppConstant.spaceHeightNormal,
              TextLabelWidget(title: AppConstant.textTitle, desc: todo.title),
              AppConstant.spaceHeightNormal,
              TextLabelWidget(
                  title: AppConstant.textDesc, desc: todo.description),
              AppConstant.spaceHeightNormal,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi Penghapusan',
            style: AppText.fBodyLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus item ini?',
            style: AppText.fBodyLarge,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ya, Hapus',
                style: AppText.fBodyLarge.copyWith(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, todo.id);
              },
            ),
            TextButton(
              child: Text(
                'Kembali',
                style: AppText.fBodyLarge
                    .copyWith(color: AppConstant.colorsPrimary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class TextLabelWidget extends StatelessWidget {
  final String title;
  final String desc;

  const TextLabelWidget({
    required this.title,
    required this.desc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppText.fBodySmall.copyWith(color: Colors.grey),
        ),
        AppConstant.spaceHeightSmall,
        Text(
          desc,
          style: AppText.fBodyLarge,
        ),
      ],
    );
  }
}
