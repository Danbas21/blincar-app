class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un email válido';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Debe contener mayúscula, minúscula y número';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es requerido';
    }

    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Ingresa un teléfono válido (10 dígitos)';
    }

    return null;
  }

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }

    if (value.length < 2) {
      return 'Debe tener al menos 2 caracteres';
    }

    if (value.length > 50) {
      return 'No puede tener más de 50 caracteres';
    }

    return null;
  }
}
