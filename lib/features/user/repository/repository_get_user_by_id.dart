import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constant.dart';
import '../../../core/enums/user_enum.dart';
import '../../../models/user_response_auth.dart';

final getUserIDFromUIProvider = StateProvider<int>((ref) {
  return 0;
});
final getUserByIdProvider = FutureProvider<User?>((ref) async {
  final userId = ref.read(getUserIDFromUIProvider);
  final user = await ref.watch(getuserByid(userId));
  return user;
});

//get user model provider
final getUserModelRepository = Provider((ref) {
  return RepositoryUserData();
});

final userModelProvider =
    StateNotifierProvider<RepositoryUserData, User?>((ref) {
  final userId = ref.watch(getUserIDFromUIProvider);
  User? user;
  ref.read(getuserByid(userId)).then((value) => user = value);
  return RepositoryUserData();
});

final getUserModelById =
    FutureProvider.family<User, int>((ref, int userId) async {
  final respone = ref.watch(userModelProvider.notifier);
  return respone.state!;
});

class RepositoryUserData extends StateNotifier<User?> {
  RepositoryUserData() : super(null);
  // DioClient dio = DioClient();
  Dio dio = Dio();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<User?> get getState async => state;
  Future<void> getUserById(int userId) async {
    SharedPreferences prefs = await _prefs;
    try {
      final response = await dio.post(
        '${ApiUrl}user/get-user-by-id',
        options: Options(
          headers: {
            'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
            "Accept": "application/json"
          },
          contentType: 'application/json',
        ),
        queryParameters: {'user_id': userId},
      );
      print(
          'the ssssssssssssssssstatataattatattaatttata json s ${(response.data['user'])}');
      // var json = jsonEncode(response.data['user']);
      var json = response.data['user'];

      print('my jsssssssssssssssonnnnnnnnnnnnnnnnnnnnnnnnv ${json.toString()}');
      // final user = UserModel.fromJson(json);

//  as Map<String, dynamic>
      final user = User.fromMap(json as Map<String, dynamic>);
      // final user = User().copyWith(
      //   colloge: json['colloge'],
      //   collogeId: json['colloge_id'],
      //   id: json['id'],
      //   name: json['name'],
      //   email: json['email'],
      //   createdAt: 'created_at',
      //   type: json['type'],
      //   img: json['img'],
      //   level: json['level'],
      //   section: json['section'],
      //   sectionId: json['section_id'],
      //   idNumber: json['id_number'],
      // );
      state = user;
      print('the ssssssssssssssssstatataattatattaatttata s $state');

      // return state;
    } catch (e) {
      print(' ssssssssssssssssstatataattatattaatttata eerrror $e');
    }
    // return state;
  }
}

final getuserByid = Provider.family((ref, int userId) async {
  // RequestLogin login = RequestLogin();

  User? user;
  await getUserById(userId).then((value) async {
    print(
        'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd$value');

    user = value!;
  });
  return user;
});
Future<User?> getUserById(int userId) async {
  Response? response;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs = await _prefs;

  User? user;
  Dio dio = Dio();
  try {
    response = await dio.post('${ApiUrl}user/get-user-by-id/',
        options: Options(headers: {
          'authorization': 'Bearer ${prefs.getString(UserEnum.token.type)}',
          "Accept": "application/json"
        }),
        queryParameters: {'user_id': userId});
    if (kDebugMode) {
      // print(response.data);
    }
    user = User.fromMap(response.data['user']);
    if (kDebugMode) {
      print('the userrrrrrrrrrrrrrrrrrrrrrrrrrrrr $user');
    }
    return user;
  } catch (e) {
    if (kDebugMode) {
      print('rerrrrrrrrrrrrrrrrrrrruser $e');
    }
  }
  return user;
}
