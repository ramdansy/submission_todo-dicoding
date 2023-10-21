import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../common/app_constant.dart';
import '../common/app_text.dart';
import '../models/todo_model.dart';
import 'widgets/button_widget.dart';

class DetailTodo extends StatefulWidget {
  final ToDo todo;
  const DetailTodo({super.key, required this.todo});

  @override
  State<DetailTodo> createState() => _DetailTodoState();
}

class _DetailTodoState extends State<DetailTodo> {
  late ToDo selectedTodo;

  @override
  void initState() {
    selectedTodo = widget.todo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.colorsPrimary,
      appBar: AppBar(
        backgroundColor: AppConstant.colorsPrimary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(
              context, {"todo": selectedTodo, "isDeleted": false}),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(AppConstant.paddingNormal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedTodo.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.fHeading5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                AppConstant.spaceHeightSmall,
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstant.paddingNormal,
                      vertical: AppConstant.paddingSmall),
                  decoration: BoxDecoration(
                    // color: AppConstant.colorsPrimary5,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppConstant.radiusSmall)),
                  ),
                  child: Text(
                    "Waktu: ${DateFormat('dd MMMM yyyy - HH:mm', "id_ID").format(selectedTodo.time)}",
                    style: AppText.fBodySmall.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                  left: AppConstant.paddingNormal,
                  top: AppConstant.paddingLarge,
                  right: AppConstant.paddingNormal,
                  bottom: AppConstant.paddingNormal),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppConstant.paddingExtraLarge),
                ),
              ),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppConstant.paddingNormal,
                            vertical: AppConstant.paddingSmall),
                        decoration: BoxDecoration(
                          color: AppConstant.colorsPrimary5,
                          border: Border.all(color: Colors.black12),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppConstant.radiusSmall)),
                        ),
                        child: Text(
                          selectedTodo.tag,
                          style: AppText.fBodySmall
                              .copyWith(color: AppConstant.colorsPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  AppConstant.spaceHeightLarge,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstant.textDesc,
                        style: AppText.fBodySmall.copyWith(color: Colors.grey),
                      ),
                      AppConstant.spaceHeightSmall,
                      Text(
                        selectedTodo.description,
                        style: AppText.fBodyLarge,
                      ),
                    ],
                  ),
                  AppConstant.spaceHeightNormal,
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(AppConstant.paddingNormal),
            child: Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    bgColor: Colors.red,
                    content: Text(
                      AppConstant.textDelete,
                      style: AppText.fBodyLarge.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    width: MediaQuery.of(context).size.width,
                    enableBorder: false,
                    onTap: () {
                      showDeleteConfirmationDialog(context);
                    },
                  ),
                ),
                AppConstant.spaceWidthNormal,
                Expanded(
                  child: ButtonWidget(
                    content: Text(
                      AppConstant.textEdit,
                      style: AppText.fBodyLarge.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (context) {
                          return showModalEditTodo(selectedTodo);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
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
                Navigator.pop(
                    context, {"todo": selectedTodo, "isDeleted": true});
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

  showModalEditTodo(ToDo todo) {
    final titleController = TextEditingController(text: todo.title);
    final descController = TextEditingController(text: todo.description);
    final tagController = TextEditingController(text: todo.tag);
    final dateTimeController = TextEditingController(
        text: DateFormat('dd MMMM yyyy - HH:mm', "id_ID").format(todo.time));

    final titleFocus = FocusNode();
    final descFocus = FocusNode();
    final tagFocus = FocusNode();

    DateTime selectdate = todo.time;

    return Padding(
      padding: const EdgeInsets.all(AppConstant.paddingNormal),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back)),
              Text(
                "${AppConstant.textEdit} ${AppConstant.textAgenda}",
                style: AppText.fBodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          AppConstant.spaceHeightLarge,
          Expanded(
            child: ListView(
              children: [
                TextFormField(
                  controller: titleController,
                  focusNode: titleFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  cursorColor: AppConstant.colorsPrimary,
                  style: AppText.fBodyLarge.copyWith(color: Colors.black),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text(AppConstant.textTitle),
                    labelStyle: AppText.fBodyLarge,
                  ),
                ),
                AppConstant.spaceHeightLarge,
                TextFormField(
                  controller: descController,
                  focusNode: descFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  cursorColor: AppConstant.colorsPrimary,
                  style: AppText.fBodyLarge.copyWith(color: Colors.black),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text(AppConstant.textDesc),
                    labelStyle: AppText.fBodyLarge,
                  ),
                  maxLines: 5,
                ),
                AppConstant.spaceHeightLarge,
                TextFormField(
                  controller: tagController,
                  focusNode: tagFocus,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  cursorColor: AppConstant.colorsPrimary,
                  style: AppText.fBodyLarge.copyWith(color: Colors.black),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text(AppConstant.textTag),
                    labelStyle: AppText.fBodyLarge,
                  ),
                ),
                AppConstant.spaceHeightLarge,
                InkWell(
                  onTap: () {
                    return DatePicker.showDatePicker(
                      context,
                      dateFormat: 'd MMMM yyyy HH:mm',
                      initialDateTime: todo.time,
                      minDateTime: DateTime(2000),
                      maxDateTime: DateTime(2100),
                      onMonthChangeStartWithFirstDate: true,
                      onConfirm: (dateTime, List<int> index) {
                        selectdate = dateTime;
                        dateTimeController.text =
                            DateFormat('dd MMMM yyyy - HH:mm', "id_ID")
                                .format(selectdate);
                      },
                      locale: DateTimePickerLocale.id,
                      pickerMode: DateTimePickerMode.datetime,
                    );
                  },
                  child: TextFormField(
                    controller: dateTimeController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    cursorColor: AppConstant.colorsPrimary,
                    style: AppText.fBodyLarge.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text(AppConstant.textTime),
                      labelStyle: AppText.fBodyLarge,
                    ),
                    enabled: false,
                  ),
                ),
              ],
            ),
          ),
          AppConstant.spaceHeightLarge,
          ButtonWidget(
            content: Text(
              AppConstant.textSave,
              style: AppText.fBodyLarge
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            width: MediaQuery.of(context).size.width,
            onTap: () {
              if (titleController.text == "" ||
                  descController.text == "" ||
                  tagController.text == "" ||
                  dateTimeController.text == "") {
              } else if (titleController.text != "" &&
                  descController.text != "" &&
                  tagController.text != "" &&
                  dateTimeController.text != "") {
                ToDo newTodo = ToDo(
                  id: selectedTodo.id,
                  tag: tagController.text,
                  title: titleController.text,
                  description: descController.text,
                  isCompleted: false,
                  time: selectdate,
                  createdAt: todo.createdAt,
                  updatedAt: DateTime.now(),
                );
                setState(() {
                  selectedTodo = newTodo;
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
