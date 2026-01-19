// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Blincar';

  @override
  String get welcome => 'Welcome to Blincar';

  @override
  String get login => 'Login';

  @override
  String get register => 'Sign Up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get phone => 'Phone';

  @override
  String get emergencyContact => 'Emergency Contact';

  @override
  String get emergencyContactPhone => 'Emergency Phone';

  @override
  String get requestTrip => 'Request Trip';

  @override
  String get tripNow => 'Trip Now';

  @override
  String get tripByHour => 'Trip by Hour';

  @override
  String get tripByDay => 'Trip by Days';

  @override
  String get carWithDriver => 'Car with Driver';

  @override
  String get armoredCar => 'Armored Car';

  @override
  String get armedEscort => 'Car with Armed Escort';

  @override
  String get unarmedEscort => 'Car with Unarmed Escort';

  @override
  String get panicButton => 'Panic Button';

  @override
  String get myAccount => 'My Account';

  @override
  String get activity => 'Activity';

  @override
  String get wallet => 'Wallet';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Settings';

  @override
  String get profile => 'Profile';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get tripHistory => 'Trip History';

  @override
  String get earnings => 'Earnings';

  @override
  String get documentation => 'Documentation';

  @override
  String get verification => 'Verification';

  @override
  String get uploadDocument => 'Upload Document';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get pickFromGallery => 'Pick from Gallery';

  @override
  String get driverLicense => 'Driver License';

  @override
  String get vehicleRegistration => 'Vehicle Registration';

  @override
  String get insurance => 'Insurance';

  @override
  String get backgroundCheck => 'Background Check';

  @override
  String get startTrip => 'Start Trip';

  @override
  String get endTrip => 'End Trip';

  @override
  String get cancelTrip => 'Cancel Trip';

  @override
  String get rateTrip => 'Rate Trip';

  @override
  String get paymentSuccessful => 'Payment Successful';

  @override
  String get paymentFailed => 'Payment Failed';

  @override
  String get cashPayment => 'Cash Payment';

  @override
  String get cardPayment => 'Card Payment';

  @override
  String get routeChangeRequest => 'Route Change Request';

  @override
  String get approveRouteChange => 'Approve Change';

  @override
  String get rejectRouteChange => 'Reject Change';

  @override
  String emergencyContactMessage(String name) {
    return '$name requires your support and follow-up';
  }

  @override
  String get monthlyEarnings => 'Monthly Earnings';

  @override
  String get totalTrips => 'Total Trips';

  @override
  String get rating => 'Rating';

  @override
  String get available => 'Available';

  @override
  String get busy => 'Busy';

  @override
  String get offline => 'Offline';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get legalNotices => 'Legal Notices';

  @override
  String get acceptTerms => 'I accept the terms and conditions';

  @override
  String get acceptPrivacyPolicy => 'I accept the privacy policy';

  @override
  String get currency => 'USD';

  @override
  String get region => 'United States';

  @override
  String get language => 'Language';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get spanish => 'Spanish';

  @override
  String get english => 'English';

  @override
  String get languageChanged => 'Language changed successfully';

  @override
  String get systemLanguage => 'System language';

  @override
  String get useSystemLanguage => 'Use device language';

  @override
  String get currentLanguage => 'Current language';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get languageDescription => 'Select the app language';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get fullName => 'Full Name';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get updateEmail => 'Update Email';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get passwordUpdated => 'Password updated successfully';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get noData => 'No data';

  @override
  String get home => 'Home';

  @override
  String get routes => 'Routes';

  @override
  String get emergencyContactName => 'Contact Name';

  @override
  String get emergencyContactNameHint => 'E.g.: Maria Garcia';

  @override
  String get emergencyContactDescription =>
      'This contact will be called automatically when you activate the panic button';

  @override
  String get emergencyContactRequired =>
      'You must configure an emergency contact';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nameTooShort => 'Name must have at least 2 characters';

  @override
  String get phoneRequired => 'Phone is required';

  @override
  String get phoneInvalid => 'Enter a valid phone number';

  @override
  String get whenContacted => 'When will they be contacted?';

  @override
  String get contactInfoPanic => 'When you activate the panic button';

  @override
  String get contactInfoCall => 'They will receive an automatic call';

  @override
  String get contactInfoLocation => 'Your real-time location will be shared';

  @override
  String get contactInfoSms => 'They will receive an SMS with trip information';

  @override
  String get configureEmergencyContact => 'Configure emergency contact';

  @override
  String get notConfigured => 'Not configured';

  @override
  String get panicTitle => 'Panic Button';

  @override
  String get panicAlertActive => 'ALERT ACTIVE';

  @override
  String get emergencySystem => 'Emergency System';

  @override
  String get panicActivateInfo => 'When you activate the panic button:';

  @override
  String get panicFeature1 => 'Local authorities will be notified';

  @override
  String get panicFeature2 => 'Your emergency contact will be called';

  @override
  String get panicFeature3 => 'Audio and video will be recorded automatically';

  @override
  String get panicFeature4 => 'Your real-time location will be shared';

  @override
  String get panicFeature5 => 'Nearby drivers will be alerted';

  @override
  String get activatingAlertIn => 'ACTIVATING ALERT IN:';

  @override
  String get alertSent => 'ALERT SENT - Authorities and contacts notified';

  @override
  String get authoritiesNotified =>
      'Authorities have been notified and are on their way';

  @override
  String get authoritiesNotifiedStatus => 'Authorities notified';

  @override
  String get emergencyContactCalled => 'Emergency contact called';

  @override
  String get recordingStarted => 'Recording started';

  @override
  String get locationShared => 'Location shared';

  @override
  String get nearbyDriversAlerted => 'Nearby drivers alerted';

  @override
  String get deactivateAlert => 'DEACTIVATE ALERT';

  @override
  String get deactivateOnlySafe => 'Only deactivate if you are safe';

  @override
  String get emergencyContacts => 'Emergency Contacts';

  @override
  String get emergencies => 'Emergencies';

  @override
  String get support247 => '24/7 Support';

  @override
  String callingContact(String name) {
    return 'Calling $name...';
  }

  @override
  String get callFailed => 'Could not make the call';

  @override
  String get noEmergencyContactConfigured =>
      'You don\'t have an emergency contact configured';
}
