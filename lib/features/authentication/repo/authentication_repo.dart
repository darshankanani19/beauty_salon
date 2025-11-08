import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:beauty_salon/core/network/api_result.dart';
import 'package:beauty_salon/core/network/api_result_service.dart';
import 'package:beauty_salon/features/authentication/models/forgot_password_request_model.dart';
import 'package:beauty_salon/features/authentication/models/forgot_password_response_model.dart';
import 'package:beauty_salon/features/authentication/models/get_user_model.dart';
import 'package:beauty_salon/features/authentication/models/login_data_model.dart';
import 'package:beauty_salon/features/authentication/service/authentication_service.dart';

class AuthenticationRepo {
  final authenticationService = AuthenticationService();
  Future<RepoResult> signup({required Map<String, dynamic> payload}) async {
    try {
      final result = await authenticationService.signup(payload);

      if (result is ApiSuccess) {
        print("✅ Signup Repo Success Data: ${result.data}");
        return RepoResult.success(data: result.data);
      } else {
        return RepoResult.failure(error: (result as ApiFailure).error);
      }
    } catch (e) {
      return RepoResult.failure(error: e.toString());
    }
  }

  Future<RepoResult<LoginResponse>> login({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await commonApiCall(
        authenticationService.login(payload),
      );

      if (response is ApiSuccess) {
        // Parse the whole response as LoginResponse (which includes LoginData inside)
        final loginResponse = LoginResponse.fromMap(response.data);

        return RepoResult.success(
          data: loginResponse,
          successCode: response.status,
        );
      } else {
        return RepoResult.failure(
          error: (response as ApiFailure).error,
          errorCode: response.status,
        );
      }
    } catch (e) {
      return RepoResult.failure(error: e.toString());
    }
  }

  Future<RepoResult<ForgotPasswordResponseModel>> forgotPassword({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await authenticationService.forgotPassword(payload);

      if (response is ApiSuccess) {
        final parsed = ForgotPasswordResponseModel.fromJson(response.data);
        return RepoResult.success(data: parsed);
      } else {
        return RepoResult.failure(error: (response as ApiFailure).error);
      }
    } catch (e) {
      return RepoResult.failure(error: e.toString());
    }
  }

  Future<RepoResult> resetPassword({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await authenticationService.resetPassword(
        payload: payload,
      );

      if (response is ApiSuccess) {
        return RepoResult.success(data: response.data);
      } else {
        return RepoResult.failure(error: (response as ApiFailure).error);
      }
    } catch (e) {
      return RepoResult.failure(error: e.toString());
    }
  }

  Future<RepoResult<Getusermodel>> getUser() async {
    try {
      final result = await authenticationService.getUser();

      if (result is ApiSuccess) {
        final model = Getusermodel.fromJson(result.data);
        return RepoResult.success(data: model);
      } else {
        return RepoResult.failure(error: (result as ApiFailure).error);
      }
    } catch (e) {
      return RepoResult.failure(error: e.toString());
    }
  }

  Future<RepoResult> logout() async {
    try {
      final result = await authenticationService.logout();
      if (result is ApiSuccess) {
        return RepoResult.success(data: result.data);
      } else {
        return RepoResult.failure(error: (result as ApiFailure).error);
      }
    } catch (e) {
      return RepoResult.failure(error: e.toString());
    }
  }
}
