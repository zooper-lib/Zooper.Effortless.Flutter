import 'package:zef_di_inglue/src/helpers/message_helper.dart';

String noRegistrationFoundForType(Type type) => interpolate('No registration found for type {#}.', [type]);

String registrationAlreadyExistsForType(Type type) =>
    interpolate('Registration already exists for type {#}. Skipping registration.', [type]);

String registrationAlreadyExistsForTypeAndName(Type type, String name) =>
    interpolate('Registration already exists for type {#} with name {#}. Skipping registration.', [type, name]);
