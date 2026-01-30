// lib/core/utils/validators.dart

/// Clase de validación y sanitización de inputs
///
/// Proporciona validadores para formularios y métodos de sanitización
/// para prevenir inyecciones y ataques comunes.
///
/// USO:
/// ```dart
/// TextFormField(
///   validator: Validators.email,
/// )
/// ```
class Validators {
  // ========================================
  // VALIDADORES DE FORMULARIO
  // ========================================

  /// Valida formato de email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }

    // Sanitizar antes de validar
    final sanitized = sanitizeEmail(value);

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(sanitized)) {
      return 'Ingresa un email válido';
    }

    // Verificar longitud máxima (prevenir buffer overflow)
    if (sanitized.length > 254) {
      return 'El email es demasiado largo';
    }

    return null;
  }

  /// Valida contraseña con requisitos de seguridad
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }

    if (value.length > 128) {
      return 'La contraseña es demasiado larga';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Debe contener mayúscula, minúscula y número';
    }

    // Verificar patrones peligrosos
    if (containsSqlInjection(value) || containsXss(value)) {
      return 'La contraseña contiene caracteres no permitidos';
    }

    return null;
  }

  /// Valida contraseña simple (solo para login, no registro)
  static String? passwordLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    if (value.length > 128) {
      return 'La contraseña es demasiado larga';
    }

    return null;
  }

  /// Valida número de teléfono mexicano
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es requerido';
    }

    // Extraer solo dígitos
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length != 10) {
      return 'Ingresa un teléfono válido (10 dígitos)';
    }

    // Verificar que no sea un número obviamente falso
    if (RegExp(r'^(\d)\1{9}$').hasMatch(digitsOnly)) {
      return 'Ingresa un número de teléfono real';
    }

    return null;
  }

  /// Valida campo requerido
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }
    return null;
  }

  /// Valida nombre (persona)
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }

    final sanitized = sanitizeName(value);

    if (sanitized.length < 2) {
      return 'Debe tener al menos 2 caracteres';
    }

    if (sanitized.length > 50) {
      return 'No puede tener más de 50 caracteres';
    }

    // Solo letras, espacios y caracteres latinos
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s\-\.]+$').hasMatch(sanitized)) {
      return 'Solo se permiten letras y espacios';
    }

    return null;
  }

  /// Valida número de tarjeta con algoritmo Luhn
  static String? cardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de tarjeta es requerido';
    }

    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 13 || digitsOnly.length > 19) {
      return 'Número de tarjeta inválido';
    }

    if (!_luhnValidate(digitsOnly)) {
      return 'Número de tarjeta inválido';
    }

    return null;
  }

  /// Valida CVV
  static String? cvv(String? value, {bool isAmex = false}) {
    if (value == null || value.isEmpty) {
      return 'El CVV es requerido';
    }

    final expectedLength = isAmex ? 4 : 3;
    if (value.length != expectedLength) {
      return 'CVV debe tener $expectedLength dígitos';
    }

    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Solo se permiten números';
    }

    return null;
  }

  /// Valida fecha de expiración MM/YY
  static String? expiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'La fecha de expiración es requerida';
    }

    final regex = RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$');
    if (!regex.hasMatch(value)) {
      return 'Formato inválido (MM/YY)';
    }

    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');
    final now = DateTime.now();
    final expiry = DateTime(year, month + 1, 0);

    if (expiry.isBefore(now)) {
      return 'La tarjeta ha expirado';
    }

    return null;
  }

  // ========================================
  // SANITIZACIÓN DE INPUTS
  // ========================================

  /// Sanitiza email removiendo caracteres peligrosos
  static String sanitizeEmail(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[<>"\'\;]'), ''); // Remover caracteres peligrosos
  }

  /// Sanitiza nombre removiendo caracteres peligrosos
  static String sanitizeName(String value) {
    return value
        .trim()
        .replaceAll(RegExp(r'[<>"\'\;\{\}\[\]\\\/\|]'), '') // XSS/Injection chars
        .replaceAll(RegExp(r'\s+'), ' '); // Múltiples espacios → uno
  }

  /// Sanitiza texto general
  static String sanitizeText(String value) {
    return value
        .trim()
        .replaceAll(RegExp(r'<[^>]*>'), '') // Remover tags HTML
        .replaceAll(RegExp(r'[<>"\'\;]'), '') // Caracteres peligrosos
        .replaceAll(RegExp(r'\s+'), ' '); // Normalizar espacios
  }

  /// Sanitiza número de teléfono (solo dígitos)
  static String sanitizePhone(String value) {
    return value.replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Sanitiza número de tarjeta (solo dígitos)
  static String sanitizeCardNumber(String value) {
    return value.replaceAll(RegExp(r'[^\d]'), '');
  }

  // ========================================
  // DETECCIÓN DE PATRONES MALICIOSOS
  // ========================================

  /// Detecta posibles intentos de SQL Injection
  static bool containsSqlInjection(String value) {
    final sqlPatterns = [
      RegExp(r"('|\")\s*(or|and)\s*('|\")", caseSensitive: false),
      RegExp(r";\s*(drop|delete|insert|update|select)\s+", caseSensitive: false),
      RegExp(r"union\s+select", caseSensitive: false),
      RegExp(r"--\s*$"),
      RegExp(r"/\*.*\*/"),
      RegExp(r"xp_\w+", caseSensitive: false),
      RegExp(r"exec\s*\(", caseSensitive: false),
    ];

    for (final pattern in sqlPatterns) {
      if (pattern.hasMatch(value)) {
        return true;
      }
    }
    return false;
  }

  /// Detecta posibles intentos de XSS
  static bool containsXss(String value) {
    final xssPatterns = [
      RegExp(r"<script", caseSensitive: false),
      RegExp(r"javascript:", caseSensitive: false),
      RegExp(r"on\w+\s*=", caseSensitive: false), // onclick=, onerror=, etc.
      RegExp(r"<iframe", caseSensitive: false),
      RegExp(r"<object", caseSensitive: false),
      RegExp(r"<embed", caseSensitive: false),
      RegExp(r"<svg.*onload", caseSensitive: false),
      RegExp(r"data:text/html", caseSensitive: false),
      RegExp(r"expression\s*\(", caseSensitive: false),
    ];

    for (final pattern in xssPatterns) {
      if (pattern.hasMatch(value)) {
        return true;
      }
    }
    return false;
  }

  /// Detecta caracteres de control peligrosos
  static bool containsControlChars(String value) {
    // Caracteres de control ASCII (excepto newline, tab, carriage return)
    return RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]').hasMatch(value);
  }

  /// Valida que no contenga patrones maliciosos
  static String? noMaliciousContent(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null; // Campo vacío es válido aquí
    }

    if (containsSqlInjection(value)) {
      return 'Contenido no permitido detectado';
    }

    if (containsXss(value)) {
      return 'Contenido no permitido detectado';
    }

    if (containsControlChars(value)) {
      return 'Caracteres no permitidos detectados';
    }

    return null;
  }

  // ========================================
  // UTILIDADES PRIVADAS
  // ========================================

  /// Algoritmo de Luhn para validar números de tarjeta
  static bool _luhnValidate(String cardNumber) {
    int sum = 0;
    bool alternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  // ========================================
  // VALIDADORES COMBINADOS
  // ========================================

  /// Crea un validador que combina múltiples validadores
  static String? Function(String?) combine(
      List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }

  /// Validador de email con verificación de contenido malicioso
  static String? secureEmail(String? value) {
    return combine([email, noMaliciousContent])(value);
  }

  /// Validador de nombre con verificación de contenido malicioso
  static String? secureName(String? value) {
    return combine([name, noMaliciousContent])(value);
  }

  /// Validador de texto seguro
  static String? secureText(String? value) {
    return combine([
      (v) => required(v, 'Este campo'),
      noMaliciousContent,
    ])(value);
  }
}
