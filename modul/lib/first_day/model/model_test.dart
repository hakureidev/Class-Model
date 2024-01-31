// Import statement untuk mengakses dekorator Freezed dan annotation yang diperlukan.
import 'package:freezed_annotation/freezed_annotation.dart';

// Part statements untuk menghubungkan dengan file yang dihasilkan oleh Freezed.
part 'model_test.freezed.dart';
part 'model_test.g.dart';

// Prolog menjelaskan konsep dasar model class.
// Model class adalah kelas yang membantu menentukan struktur data, contohnya response dari API.
// Pada dasarnya, kita bisa mendeklarasikan variabel, tipe datanya, dan menulis metode dalam kelas
// untuk menambahkan fungsionalitas tertentu.

@freezed
// Dekorator @freezed digunakan untuk menghasilkan kode Freezed.
class UserModel with _$UserModel {
  // Konstruktor private untuk class ini, disarankan untuk menambahkan method ini
  // agar dapat menulis fungsi tambahan dalam class yang dihasilkan oleh Freezed.
  const UserModel._();

  // Konstruktor factory untuk membuat instance UserModel.
  const factory UserModel({
    required int index,
    required String name,
    required String lastName,
    required String kegiatan,
  }) = _UserModel;

  // Factory method untuk mengkonversi JSON menjadi instance UserModel.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Metode cetakInfo untuk mencetak informasi tentang UserModel.
  String cetakInfo() => 'Hello my name is $name $lastName, my task is $kegiatan';
}
