import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../common/app_constant.dart';
import '../common/app_text.dart';
import '../common/string_helper.dart';
import '../models/todo_model.dart';
import '../models/user_model.dart';
import 'detail_todo_page.dart';
import 'login_page.dart';
import 'widgets/button_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/welcome';

  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDo> listTodo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) {
              return showModalAddTodo();
            },
          );
        },
        backgroundColor: AppConstant.colorsPrimary,
        child: const Icon(
          Icons.add_circle_outline_rounded,
          color: Colors.white,
          size: AppConstant.iconSizeExtraLarge,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constrainst) {
          if (constrainst.maxWidth < 600) {
            return mobileView();
          } else if (MediaQuery.of(context).size.width < 1024) {
            return tabletView();
          } else {
            return webView();
          }
        },
      ),
    );
  }

  Widget mobileView() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: AppConstant.colorsPrimary,
            padding: const EdgeInsets.all(AppConstant.paddingNormal),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(AppConstant.textHallo,
                              style: AppText.fHeading5
                                  .copyWith(color: Colors.white)),
                          AppConstant.spaceWidthSmall,
                          Expanded(
                            child: Text(
                              widget.user.name,
                              style: AppText.fHeading5.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      AppConstant.spaceHeightSmall,
                      Text(AppConstant.textActivity,
                          style:
                              AppText.fBodyLarge.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false);
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: AppConstant.iconSizeLarge,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: AppConstant.colorsPrimary5,
              child: listTodo.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.all(AppConstant.paddingNormal),
                      itemCount: listTodo.length,
                      itemBuilder: (context, index) {
                        var item = listTodo[index];
                        return Dismissible(
                          key: Key(item.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              listTodo.removeAt(index);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            padding:
                                const EdgeInsets.all(AppConstant.paddingNormal),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              Map<String, dynamic> result =
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailTodo(todo: item),
                                      ));

                              setState(() {
                                if (result["isDeleted"]) {
                                  listTodo.removeWhere((element) =>
                                      element.id == result["todo"].id);
                                } else {
                                  int index = listTodo.indexWhere((element) =>
                                      element.id == result["todo"].id);
                                  //check if element found
                                  if (index != -1) {
                                    listTodo[index] = result["todo"];
                                  }
                                }
                              });
                            },
                            child: itemTodoWidget(
                              title: item.title,
                              desc: item.description,
                              tag: item.tag,
                              time: item.time,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          AppConstant.spaceHeightNormal,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(AppConstant.paddingNormal),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/no-data.png",
                              width: 200,
                            ),
                            AppConstant.spaceHeightLarge,
                            Text(
                              "Pintasan Agenda Anda Kosong",
                              style: AppText.fBodyLarge
                                  .copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            AppConstant.spaceHeightSmall,
                            Text(
                              "Tidak ada agenda yang tersedia saat ini. Mulailah dengan menambahkan agenda baru!",
                              style: AppText.fBodySmall,
                              textAlign: TextAlign.center,
                            ),
                            AppConstant.spaceHeightLarge,
                            ButtonWidget(
                              content: Text(
                                "${AppConstant.textAdd} ${AppConstant.textAgenda}",
                                style: AppText.fBodyLarge.copyWith(
                                    color: AppConstant.colorsPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              bgColor: Colors.transparent,
                              width: MediaQuery.of(context).size.width / 2,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  builder: (context) {
                                    return showModalAddTodo();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabletView() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: AppConstant.colorsPrimary,
            padding: const EdgeInsets.all(AppConstant.paddingNormal),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(AppConstant.textHallo,
                              style: AppText.fHeading5
                                  .copyWith(color: Colors.white)),
                          AppConstant.spaceWidthSmall,
                          Expanded(
                            child: Text(
                              widget.user.name,
                              style: AppText.fHeading5.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      AppConstant.spaceHeightSmall,
                      Text(AppConstant.textActivity,
                          style:
                              AppText.fBodyLarge.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false);
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: AppConstant.iconSizeLarge,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: AppConstant.colorsPrimary5,
              child: listTodo.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.all(AppConstant.paddingNormal),
                      itemCount: listTodo.length,
                      itemBuilder: (context, index) {
                        var item = listTodo[index];
                        return Dismissible(
                          key: Key(item.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              listTodo.removeAt(index);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            padding:
                                const EdgeInsets.all(AppConstant.paddingNormal),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              Map<String, dynamic> result =
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailTodo(todo: item),
                                      ));

                              setState(() {
                                if (result["isDeleted"]) {
                                  listTodo.removeWhere((element) =>
                                      element.id == result["todo"].id);
                                } else {
                                  int index = listTodo.indexWhere((element) =>
                                      element.id == result["todo"].id);
                                  //check if element found
                                  if (index != -1) {
                                    listTodo[index] = result["todo"];
                                  }
                                }
                              });
                            },
                            child: itemTodoWidget(
                              title: item.title,
                              desc: item.description,
                              tag: item.tag,
                              time: item.time,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          AppConstant.spaceHeightNormal,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(AppConstant.paddingNormal),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/no-data.png",
                              width: 200,
                            ),
                            AppConstant.spaceHeightLarge,
                            Text(
                              "Pintasan Agenda Anda Kosong",
                              style: AppText.fBodyLarge
                                  .copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            AppConstant.spaceHeightSmall,
                            Text(
                              "Tidak ada agenda yang tersedia saat ini. Mulailah dengan menambahkan agenda baru!",
                              style: AppText.fBodySmall,
                              textAlign: TextAlign.center,
                            ),
                            AppConstant.spaceHeightLarge,
                            ButtonWidget(
                              content: Text(
                                "${AppConstant.textAdd} ${AppConstant.textAgenda}",
                                style: AppText.fBodyLarge.copyWith(
                                    color: AppConstant.colorsPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              bgColor: Colors.transparent,
                              width: MediaQuery.of(context).size.width / 2,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  builder: (context) {
                                    return showModalAddTodo();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget webView() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: AppConstant.colorsPrimary,
            padding: const EdgeInsets.all(AppConstant.paddingNormal),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(AppConstant.textHallo,
                              style: AppText.fHeading5
                                  .copyWith(color: Colors.white)),
                          AppConstant.spaceWidthSmall,
                          Expanded(
                            child: Text(
                              widget.user.name,
                              style: AppText.fHeading5.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      AppConstant.spaceHeightSmall,
                      Text(AppConstant.textActivity,
                          style:
                              AppText.fBodyLarge.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (route) => false);
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: AppConstant.iconSizeLarge,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: AppConstant.colorsPrimary5,
              child: listTodo.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.all(AppConstant.paddingNormal),
                      itemCount: listTodo.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: AppConstant.paddingLarge,
                        mainAxisSpacing: AppConstant.paddingLarge,
                      ),
                      itemBuilder: (context, index) {
                        var item = listTodo[index];
                        return GestureDetector(
                          onTap: () async {
                            Map<String, dynamic> result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailTodo(todo: item),
                                ));

                            setState(() {
                              if (result["isDeleted"]) {
                                listTodo.removeWhere((element) =>
                                    element.id == result["todo"].id);
                              } else {
                                int index = listTodo.indexWhere((element) =>
                                    element.id == result["todo"].id);
                                //check if element found
                                if (index != -1) {
                                  listTodo[index] = result["todo"];
                                }
                              }
                            });
                          },
                          child: itemTodoWidget(
                            title: item.title,
                            desc: item.description,
                            tag: item.tag,
                            time: item.time,
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.all(AppConstant.paddingNormal),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/no-data.png",
                              width: 200,
                            ),
                            AppConstant.spaceHeightLarge,
                            Text(
                              "Pintasan Agenda Anda Kosong",
                              style: AppText.fBodyLarge
                                  .copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            AppConstant.spaceHeightSmall,
                            Text(
                              "Tidak ada agenda yang tersedia saat ini. Mulailah dengan menambahkan agenda baru!",
                              style: AppText.fBodySmall,
                              textAlign: TextAlign.center,
                            ),
                            AppConstant.spaceHeightLarge,
                            ButtonWidget(
                              content: Text(
                                "${AppConstant.textAdd} ${AppConstant.textAgenda}",
                                style: AppText.fBodyLarge.copyWith(
                                    color: AppConstant.colorsPrimary,
                                    fontWeight: FontWeight.bold),
                              ),
                              bgColor: Colors.transparent,
                              width: MediaQuery.of(context).size.width / 2,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  builder: (context) {
                                    return showModalAddTodo();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  showModalAddTodo() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final tagController = TextEditingController();
    final dateTimeController = TextEditingController();

    final titleFocus = FocusNode();
    final descFocus = FocusNode();
    final tagFocus = FocusNode();

    DateTime selectdate = DateTime.now();

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
                "${AppConstant.textAdd} ${AppConstant.textAgenda}",
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
                      initialDateTime: DateTime.now(),
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
                  id: generateRandomString(10),
                  tag: tagController.text,
                  title: titleController.text,
                  description: descController.text,
                  isCompleted: false,
                  time: selectdate,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                setState(() {
                  listTodo.add(newTodo);
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  itemTodoWidget(
      {required String title,
      required String desc,
      required String tag,
      required DateTime time}) {
    return Container(
      padding: const EdgeInsets.all(AppConstant.paddingNormal),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppConstant.radiusNormal)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstant.paddingExtraSmall),
                  decoration: BoxDecoration(
                    color: AppConstant.colorsPrimary5,
                    border: Border.all(color: Colors.black12),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppConstant.radiusSmall)),
                  ),
                  child: Text(
                    tag,
                    style: AppText.fCaptionLarge
                        .copyWith(color: AppConstant.colorsPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppConstant.spaceHeightSmall,
                Text(
                  title,
                  style:
                      AppText.fBodyLarge.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppConstant.spaceHeightSmall,
                Text(
                  DateFormat('dd MMMM yyyy - HH:mm', "id_ID").format(time),
                  style: AppText.fCaptionLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
