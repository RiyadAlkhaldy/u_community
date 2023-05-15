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
final getUserByIdProvider = FutureProvider.autoDispose<User?>((ref) async {
  final userId = ref.read(getUserIDFromUIProvider);
  final user = await ref.watch(getuserByid(userId));
  return user;
});

//get user model provider
final getUserModelRepository = Provider<RepositoryUserData>((ref) {
  return RepositoryUserData();
});

final userModelProvider = FutureProvider<User?>((ref) async {
  final userId = ref.watch(getUserIDFromUIProvider);
  return await ref.read(getUserModelRepository).getUserById(userId);
  User? user;

  // final use = ref.read(getUserModelRepository).getUserById(userId).then((value) => value);
  // use.getUserById(userId);
  // return use;
});
final userModelPostsModelFuture = FutureProvider<User?>((ref) {
  // final userId = ref.watch(getUserIDFromUIProvider);
  // User? user;
  // ref
  //     .read(getUserModelRepository)
  //     .getUserById(userId)
  //     .then((value) => user = value);
  // return ref.read(userModelProvider);
});

final getUserModelById =
    FutureProvider.family<User, int>((ref, int userId) async {
  final respone = ref.read(getUserModelRepository);
  return respone.state!;
});

class RepositoryUserData extends StateNotifier<User?> {
  RepositoryUserData() : super(null);
  // DioClient dio = DioClient();
  Dio dio = Dio();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<User?> get getState async => state;
  Future<User?> getUserById(int userId) async {
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
      final user = User.fromMap(json as Map<String, dynamic>);
      state = user;
      print('the ssssssssssssssssstatataattatattaatttata s $state');

      // return state;
    } catch (e) {
      print(' ssssssssssssssssstatataattatattaatttata eerrror $e');
    }
    return state;
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
    user = User.fromMap(response.data['user'] as Map<String, dynamic>);
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
