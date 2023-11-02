import 'dart:async';

import 'package:flutter/material.dart';

import '../common/app_constant.dart';
import '../common/app_text.dart';
import '../common/string_helper.dart';
import '../models/user_model.dart';
import 'home_page.dart';
import 'widgets/button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();

  final registerNameController = TextEditingController();
  final registerUsernameController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerNameFocus = FocusNode();
  final registerUsernameFocus = FocusNode();
  final registerPasswordFocus = FocusNode();

  bool passwordVisible = true,
      registerVisible = false,
      isWrongAccount = false,
      isErrorVisible = false,
      isRegisterCompleted = false;

  List<User> listUser = [];

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width >= 1024;
    final isTab = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: AppConstant.colorsPrimary,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () =>
                          showBottomSheetInfo(context, isWeb, isTab),
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        size: AppConstant.iconSizeNormal,
                        color: Colors.white,
                      ))
                ],
              ),
              isWeb
                  ? AppConstant.spaceHeightLarge
                  : AppConstant.spaceWidthNormal,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppConstant.radiusLarge)),
                    ),
                    child: Image.asset(
                      "assets/images/logo-todo-white.png",
                      width: 40,
                    ),
                  ),
                ],
              ),
              isWeb
                  ? AppConstant.spaceHeightLarge
                  : AppConstant.spaceWidthNormal,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppConstant.textWelcome,
                      style: AppText.fHeading5.copyWith(color: Colors.white)),
                  AppConstant.spaceHeightSmall,
                  Text(
                    AppConstant.textWelcome2,
                    style: AppText.fHeading2.copyWith(
                        fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ],
              ),
              AppConstant.spaceHeightNormal,
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.all(isWeb ? 0 : AppConstant.paddingNormal),
                    padding: EdgeInsets.all(isWeb
                        ? AppConstant.paddingLarge
                        : AppConstant.paddingNormal),
                    width: isWeb
                        ? MediaQuery.of(context).size.width / 3
                        : isTab
                            ? MediaQuery.of(context).size.width / 2
                            : MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppConstant.radiusLarge)),
                        boxShadow: [AppConstant.shadow]),
                    child: registerVisible ? registerState() : loginState(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginState() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstant.textdescWelcome,
            style: AppText.fHeading6,
            textAlign: TextAlign.center,
          ),
          AppConstant.spaceHeightNormal,
          TextFormField(
            controller: usernameController,
            focusNode: usernameFocus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            cursorColor: AppConstant.colorsPrimary,
            style: AppText.fBodyLarge.copyWith(color: Colors.black),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text(AppConstant.textUsername),
              labelStyle: AppText.fBodyLarge,
            ),
          ),
          AppConstant.spaceHeightNormal,
          TextFormField(
            obscureText: passwordVisible ? true : false,
            controller: passwordController,
            focusNode: passwordFocus,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            cursorColor: AppConstant.colorsPrimary,
            style: AppText.fBodyLarge.copyWith(color: Colors.black),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text(AppConstant.textPassword),
              labelStyle: AppText.fBodyLarge,
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
            ),
          ),
          AppConstant.spaceHeightNormal,
          if (isWrongAccount && isErrorVisible)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstant.paddingSmall,
                    horizontal: AppConstant.paddingNormal,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppConstant.radiusSmall)),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.red),
                      AppConstant.spaceWidthNormal,
                      Expanded(
                        child: Text(
                          AppConstant.textErrorWrongUsername,
                          style: AppText.fBodySmall.copyWith(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                AppConstant.spaceHeightNormal,
              ],
            ),
          ButtonWidget(
            content: Text(
              AppConstant.textLogin,
              style: AppText.fBodyLarge
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            width: MediaQuery.of(context).size.width,
            onTap: () {
              if (usernameController.text == "admin" &&
                  passwordController.text == "admin") {
                User newUser = User(
                  id: generateRandomString(10),
                  name: "Admin",
                  username: "admin",
                  password: "admin",
                );
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              user: newUser,
                            )),
                    (route) => false);
              } else if (listUser
                      .where((element) =>
                          element.username == usernameController.text)
                      .isNotEmpty &&
                  listUser
                      .where((element) =>
                          element.username == passwordController.text)
                      .isNotEmpty) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              user: listUser
                                  .where((element) =>
                                      element.username ==
                                      usernameController.text)
                                  .first,
                            )),
                    (route) => false);
              } else if (usernameController.text == "" ||
                  passwordController.text == "") {
              } else {
                setState(() {
                  isWrongAccount = true;
                  isErrorVisible = true;
                });
                countdown();
              }

              usernameFocus.unfocus();
              passwordFocus.unfocus();
            },
          ),
          AppConstant.spaceHeightNormal,
          Row(
            children: [
              const Expanded(
                  child: Divider(color: Colors.black54, thickness: 0.5)),
              AppConstant.spaceWidthNormal,
              Text(
                AppConstant.textOr,
                style: AppText.fBodySmall.copyWith(color: Colors.grey),
              ),
              AppConstant.spaceWidthNormal,
              const Expanded(
                  child: Divider(color: Colors.black54, thickness: 0.5)),
            ],
          ),
          AppConstant.spaceHeightNormal,
          ButtonWidget(
            content: Text(
              AppConstant.textRegister,
              style: AppText.fBodyLarge.copyWith(
                  color: AppConstant.colorsPrimary,
                  fontWeight: FontWeight.bold),
            ),
            bgColor: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            onTap: () {
              setState(() {
                registerVisible = true;
                isRegisterCompleted = false;

                usernameController.text = "";
                passwordController.text = "";
              });
            },
          ),
        ],
      ),
    );
  }

  Widget registerState() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  registerNameController.text = "";
                  registerUsernameController.text = "";
                  registerPasswordController.text = "";
                  registerVisible = false;
                });
              },
              icon: const Icon(Icons.arrow_back)),
          Text(
            AppConstant.textRegisterWelcome,
            style: AppText.fHeading6,
            textAlign: TextAlign.center,
          ),
          AppConstant.spaceHeightNormal,
          TextFormField(
            controller: registerNameController,
            focusNode: registerNameFocus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            cursorColor: AppConstant.colorsPrimary,
            style: AppText.fBodyLarge.copyWith(color: Colors.black),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text(AppConstant.textName),
              labelStyle: AppText.fBodyLarge,
            ),
          ),
          AppConstant.spaceHeightNormal,
          TextFormField(
            controller: registerUsernameController,
            focusNode: registerUsernameFocus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            cursorColor: AppConstant.colorsPrimary,
            style: AppText.fBodyLarge.copyWith(color: Colors.black),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text(AppConstant.textUsername),
              labelStyle: AppText.fBodyLarge,
            ),
          ),
          AppConstant.spaceHeightNormal,
          TextFormField(
            obscureText: passwordVisible ? true : false,
            controller: registerPasswordController,
            focusNode: registerPasswordFocus,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            cursorColor: AppConstant.colorsPrimary,
            style: AppText.fBodyLarge.copyWith(color: Colors.black),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text(AppConstant.textPassword),
              labelStyle: AppText.fBodyLarge,
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
            ),
          ),
          AppConstant.spaceHeightNormal,
          if (isRegisterCompleted)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstant.paddingSmall,
                    horizontal: AppConstant.paddingNormal,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppConstant.radiusSmall)),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.red),
                      AppConstant.spaceWidthNormal,
                      Expanded(
                        child: Text(
                          AppConstant.textErrorNotFilled,
                          style: AppText.fBodySmall.copyWith(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                AppConstant.spaceHeightNormal,
              ],
            ),
          ButtonWidget(
            content: Text(
              AppConstant.textRegister,
              style: AppText.fBodyLarge
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            width: MediaQuery.of(context).size.width,
            onTap: () {
              if (registerNameController.text != "" &&
                  registerUsernameController.text != "" &&
                  registerPasswordController.text != "") {
                var id = generateRandomString(10);
                User newUser = User(
                  id: id,
                  name: registerNameController.text,
                  username: registerUsernameController.text,
                  password: registerPasswordController.text,
                );
                listUser.add(newUser);

                setState(() {
                  registerVisible = false;
                });
              } else {
                setState(() {
                  isRegisterCompleted = true;
                  countdown();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  showBottomSheetInfo(BuildContext context, bool isWeb, bool isTab) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          content: SizedBox(
            width: isWeb
                ? MediaQuery.of(context).size.width / 3
                : isTab
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppConstant.textInfo,
                  style:
                      AppText.fHeading6.copyWith(fontWeight: FontWeight.bold),
                ),
                AppConstant.spaceHeightNormal,
                Text(
                  "Login untuk submission ini bisa menggunakan:\nusername: admin\npassword:admin",
                  style: AppText.fBodyLarge,
                ),
                AppConstant.spaceHeightNormal,
                Text(
                  "Untuk Register, akun hanya bisa digunakan untuk sementara, jika aplikasi ditutup atau akun dilogout maka akun akan hilang dan harus membuat ulang akun",
                  style: AppText.fBodyLarge,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void countdown() {
    Timer(const Duration(seconds: 5), () {
      setState(() {
        isWrongAccount = false;
        isErrorVisible = false;
        isRegisterCompleted = false;
      });
    });
  }
}
