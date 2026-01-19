import 'package:dartz/dartz.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';

class RegisterUseCase implements UseCase<User, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
      // lastName: params.lastName,
      phoneNumber: params.phoneNumber,
      emergencyContactName: params.emergencyContactName,
      emergencyContactPhone: params.emergencyContactPhone,
      // role: params.role,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String emergencyContactName;
  final String emergencyContactPhone;

  RegisterParams({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
  });
}
