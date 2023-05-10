import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:u_community/features/user/repository/repository_get_user_by_id.dart';

import '../../../models/user_response_auth.dart';

final getUserModelController =
    StateNotifierProvider<RepositoryUserData, User?>((ref) {
  return ref.read(getUserModelRepository);
});

final getUserModelByIdController = FutureProvider((ref) async {
  final userId = ref.read(getUserIDFromUIProvider);
  final user = ref.read(getUserModelRepository);
  await user.getUserById(userId);
  return user;
});
