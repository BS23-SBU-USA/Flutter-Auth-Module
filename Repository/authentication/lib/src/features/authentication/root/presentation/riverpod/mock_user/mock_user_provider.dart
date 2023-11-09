import 'package:auth_module/src/features/authentication/root/data/model/mock_user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mockUserProvider = StateProvider((ref) => MockUserModel());
