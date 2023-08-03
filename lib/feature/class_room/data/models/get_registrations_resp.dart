import 'package:flutter/material.dart';

import 'registration.dart';

@immutable
class GetRegistrationsRespModel {
  const GetRegistrationsRespModel(this.registrations);
  final List<RegistrationModel> registrations;

  factory GetRegistrationsRespModel.fromJson(Map<String, dynamic> json) =>
      GetRegistrationsRespModel((json['registrations'] as List<dynamic>?)
              ?.map(
                  (e) => RegistrationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []);
}
