import 'package:flutter/material.dart';

class AppConstant {
  //text
  static const String appName = "TODO";
  static const String textWelcome = "Selamat Datang di";
  static const String textWelcome2 = "Aplikasi $appName";
  static const String textdescWelcome =
      "Masuk dengan menggunakan akun yang sudah terdaftar";
  static const String textRegisterWelcome =
      "Daftarkan diri Anda untuk memulai rencana harian Anda!";
  static const String textName = "Nama";
  static const String textUsername = "Username";
  static const String textPassword = "Password";
  static const String textLogin = "Masuk";
  static const String textRegister = "Daftar";
  static const String textOr = "Atau";
  static const String textInfo = "Info";
  static const String textHallo = "Hallo,";
  static const String textAdd = "Tambah";
  static const String textAgenda = "Agenda";
  static const String textSave = "Simpan";
  static const String textTitle = "Judul";
  static const String textDesc = "Deskripsi";
  static const String textTag = "Tag";
  static const String textTime = "Waktu";
  static const String textEdit = "Ubah";
  static const String textDelete = "Hapus";
  static const String textActivity = "Berikut Agenda Untuk Anda";

  //error
  static const String textErrorWrongUsername = "Username atau Password Salah!";
  static const String textErrorNotFilled = "Opsss, Data masih ada yang kosong";

  //Colors
  static const Color colorsPrimary = Color(0xFF0079EB);
  static const Color colorsPrimary5 = Color(0xFFF2F7FA);

  //spacing
  static const SizedBox spaceHeightExtraSmall = SizedBox(height: 4.0);
  static const SizedBox spaceHeightSmall = SizedBox(height: 8.0);
  static const SizedBox spaceHeightMedium = SizedBox(height: 12.0);
  static const SizedBox spaceHeightNormal = SizedBox(height: 16.0);
  static const SizedBox spaceHeightLarge = SizedBox(height: 24.0);
  static const SizedBox spaceHeightExtraLarge = SizedBox(height: 40.0);
  static const SizedBox spaceWidthSmall = SizedBox(width: 8.0);
  static const SizedBox spaceWidthMedium = SizedBox(width: 12.0);
  static const SizedBox spaceWidthNormal = SizedBox(width: 16.0);
  static const SizedBox spaceWidthLarge = SizedBox(width: 24.0);
  static const SizedBox spaceWidthExtraLarge = SizedBox(width: 40.0);

  //padding
  static const double paddingExtraSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingNormal = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 40.0;

  //radius
  static const double radiusExtraSmall = 4.0;
  static const double radiusSmall = 8.0;
  static const double radiusNormal = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 24.0;

  //icon
  static const double iconSizeSmall = 16.0;
  static const double iconSizeNormal = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 40.0;

  static const BoxShadow shadow = BoxShadow(
      blurRadius: 4,
      color: Colors.black12,
      offset: Offset(2, 12),
      spreadRadius: 0);
}
