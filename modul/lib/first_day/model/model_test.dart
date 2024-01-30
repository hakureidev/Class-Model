import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_test.freezed.dart';
part 'model_test.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {required int index,
      required String name,
      required String lastName ,
      required String hobby}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
