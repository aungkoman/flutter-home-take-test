import 'package:hometake/features/auth/domain/entities/user_entity.dart';

import '../../domain/entities/params/user_login_params.dart';
import '../../domain/entities/params/user_otp_verify_params.dart';
import '../../domain/entities/params/user_register_params.dart';

abstract class AuthRemoteDatasource{
  Future< UserEntity > loginUser({required UserLoginParams userLoginParams});
  Future< UserEntity> registerUser({required UserRegisterParams userRegisterParams});
  Future< UserEntity> verifyOtp({required UserOtpVerifyParams userOtpVerifyParams});
}

// TODO: implement this data source  using Database ( drift ) , not API