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

  @override
  String get confirmDeactivation => 'Confirm deactivation';

  @override
  String get typeToConfirm => 'Type: I AM SAFE';

  @override
  String get verifyPhone => 'Verify your phone';

  @override
  String get enterPhoneToVerify =>
      'Enter your phone number to receive a verification code';

  @override
  String get sendCode => 'Send code';

  @override
  String get enterVerificationCode => 'Enter the code';

  @override
  String codeSentTo(String phone) {
    return 'We sent an SMS code to $phone';
  }

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend code';

  @override
  String resendCodeIn(int seconds) {
    return 'Resend code in ${seconds}s';
  }

  @override
  String get changePhoneNumber => 'Change number';

  @override
  String get phoneVerified => 'Phone verified successfully';

  @override
  String get invalidCode => 'Invalid code';

  @override
  String get chatWithDriver => 'Chat with driver';

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get send => 'Send';

  @override
  String get noMessages => 'No messages yet';

  @override
  String get startConversation => 'Start the conversation';

  @override
  String get rateYourTrip => 'Rate your trip';

  @override
  String get howWasYourTrip => 'How was your trip?';

  @override
  String get leaveComment => 'Leave a comment (optional)';

  @override
  String get commentPlaceholder => 'Tell us about your experience...';

  @override
  String get submitRating => 'Submit rating';

  @override
  String get skipRating => 'Skip';

  @override
  String get thankYouForRating => 'Thank you for your rating';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountWarning =>
      'This action is irreversible. All your data will be permanently deleted.';

  @override
  String get confirmDeleteAccount =>
      'Are you sure you want to delete your account?';

  @override
  String get typeDeleteToConfirm => 'Type DELETE to confirm';

  @override
  String get accountDeleted => 'Your account has been deleted';

  @override
  String get delete => 'Delete';

  @override
  String get activityTitle => 'My Activity';

  @override
  String get noTripsYet => 'No trips yet';

  @override
  String get noTripsDescription =>
      'When you complete your first trip, it will appear here';

  @override
  String get tripStatusCompleted => 'Completed';

  @override
  String get tripStatusCancelled => 'Cancelled';

  @override
  String get tripStatusPending => 'Pending';

  @override
  String get tripStatusAssigned => 'Assigned';

  @override
  String get tripStatusInProgress => 'In progress';

  @override
  String get tripStatusAccepted => 'Accepted';

  @override
  String get tripStatusRequested => 'Requested';

  @override
  String get forgotPasswordTitle => 'RECOVER PASSWORD';

  @override
  String get forgotPasswordEmailHint => 'Enter your email address...';

  @override
  String get sendLink => 'Send Link';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get emailSentTitle => 'EMAIL SENT!';

  @override
  String get emailSentMessage => 'We have sent a recovery link to:';

  @override
  String get checkInboxMessage => 'Check your inbox...';

  @override
  String get resendEmailLink => 'Didn\'t receive the email? Try again';

  @override
  String get loginHeroText => 'HIGH-LEVEL MOBILITY\nWITH TOTAL SECURITY.';

  @override
  String get loginTitle => 'LOG IN';

  @override
  String get loginEmailLabel => 'Corporate or Personal Email*';

  @override
  String get loginPasswordLabel => 'Password*';

  @override
  String get forgotPasswordLink => 'Forgot your password?';

  @override
  String get loginButton => 'Log In';

  @override
  String get registerLink => 'New to BlinCar? Sign up!';

  @override
  String get orDivider => 'or';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get facebookComingSoon => 'Facebook Sign In coming soon';

  @override
  String get registerTitle => 'Create account';

  @override
  String get registerSubtitle => 'Complete the information to register';

  @override
  String get accountTypeLabel => 'Account type';

  @override
  String get passengerType => 'Passenger';

  @override
  String get driverType => 'Driver';

  @override
  String get nameHint => 'Your name';

  @override
  String get lastNameHint => 'Your last names';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get termsRequiredError => 'You must accept the terms and conditions';

  @override
  String get privacyRequiredError => 'You must accept the privacy policy';

  @override
  String get ineRequiredError => 'You must upload both sides of your ID';

  @override
  String get documentsUploaded => 'Documents uploaded successfully';

  @override
  String get ineLabel => 'Official ID (INE)';

  @override
  String get ineDescription => 'Upload clear photos of your ID';

  @override
  String get ineFront => 'Front Side';

  @override
  String get ineFrontDescription => 'Photo with your name and photo';

  @override
  String get ineBack => 'Back Side';

  @override
  String get ineBackDescription => 'Photo with the barcode';

  @override
  String get securityNotice => 'Your information is protected and encrypted';

  @override
  String get uploadingDocuments => 'Uploading documents...';

  @override
  String get createAccountButton => 'Create Account';

  @override
  String get helpTitle => 'Help & Support';

  @override
  String get faqSearchHint => 'Search frequently asked questions...';

  @override
  String get faqTitle => 'Frequently Asked Questions';

  @override
  String get noSearchResults => 'No results found';

  @override
  String get contactSupport => 'Contact support';

  @override
  String helloName(String name) {
    return 'Hello, $name';
  }

  @override
  String get transportServices => 'Transport Services';

  @override
  String get byRoute => 'By Route';

  @override
  String get predefinedRoutes => 'Predefined routes';

  @override
  String get byDay => 'By Day';

  @override
  String get fullService => 'Full service';

  @override
  String get customizeTrip => 'Customize your Trip';

  @override
  String get originDestinationManual => 'Enter origin and destination manually';

  @override
  String get quickTrip => 'Quick Trip';

  @override
  String get wherePickup => 'Where should we pick you up?';

  @override
  String get whereGoing => 'Where are you going?';

  @override
  String get serviceTypeLabel => 'Service type';

  @override
  String get scheduleLater => 'Schedule for later';

  @override
  String get changeButton => 'Change';

  @override
  String get panicActivateConfirm =>
      'Are you sure you want to activate the panic button? An immediate alert will be sent.';

  @override
  String get activateButton => 'Activate';

  @override
  String get byDayServiceTitle => 'Day Service';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get byDayDescription =>
      'The day service will allow you to hire a driver full time';

  @override
  String get hoursService => '8 hours of service';

  @override
  String get multipleDestinations => 'Multiple destinations';

  @override
  String get dedicatedDriver => 'Dedicated driver';

  @override
  String get understood => 'Got it';

  @override
  String get selectOrigin => 'Select origin';

  @override
  String get selectDestination => 'Select destination';

  @override
  String get calculatingRoute => 'Calculating route...';

  @override
  String get totalToPay => 'Total to pay';

  @override
  String get continuePayment => 'Continue to payment';

  @override
  String todayAt(String time) {
    return 'Today at $time';
  }

  @override
  String tomorrowAt(String time) {
    return 'Tomorrow at $time';
  }

  @override
  String get minimumScheduling =>
      'The trip must be scheduled at least 30 minutes in advance';

  @override
  String get activityTab => 'Activity';

  @override
  String get profileTab => 'Profile';

  @override
  String get passengerLabel => 'Passenger';

  @override
  String get mexicoOnly => 'Only destinations within Mexico are allowed';

  @override
  String get searching => 'Searching...';

  @override
  String get loadingAddress => 'Loading address...';

  @override
  String get originPoint => 'Origin point';

  @override
  String get destinationPoint => 'Destination point';

  @override
  String get tapMap => 'Tap the map to select';

  @override
  String get confirmOrigin => 'Confirm origin';

  @override
  String get confirmDestination => 'Confirm destination';

  @override
  String get whereFrom => 'Where are you coming from?';

  @override
  String get selectLocationTitle => 'Select location';

  @override
  String get markAllRead => 'Mark all';

  @override
  String get noNotifications => 'You have no notifications';

  @override
  String get justNow => 'Just now';

  @override
  String get paymentHistoryTitle => 'Payment History';

  @override
  String get totalPaid => 'Total paid';

  @override
  String get completedTransactions => 'completed transactions';

  @override
  String get allFilter => 'All';

  @override
  String get refundsFilter => 'Refunds';

  @override
  String get pendingFilter => 'Pending';

  @override
  String get noTransactions => 'No transactions';

  @override
  String get errorLoadingHistory => 'Error loading history';

  @override
  String get statusFailed => 'Failed';

  @override
  String get statusRefunded => 'Refunded';

  @override
  String get refreshButton => 'Refresh';

  @override
  String get personalDocs => 'Personal';

  @override
  String get licenseDocs => 'License';

  @override
  String get vehicleDocs => 'Vehicle';

  @override
  String get insuranceDocs => 'Insurance';

  @override
  String get docApproved => 'Approved';

  @override
  String get docRejected => 'Rejected';

  @override
  String get docExpired => 'Expired';

  @override
  String get docMissing => 'Missing';

  @override
  String get docPending => 'Pending';

  @override
  String get reupload => 'Re-upload';

  @override
  String get viewDocument => 'View Document';

  @override
  String get uploadNewDocument => 'Upload New Document';

  @override
  String get chooseUploadMethod =>
      'Select how you want to upload your document:';

  @override
  String get selectFromGallery => 'Select from Gallery';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get changeProfilePhoto => 'Change profile photo';

  @override
  String get takePhotoOption => 'Take photo';

  @override
  String get chooseGallery => 'Choose from gallery';

  @override
  String get fullNameHint => 'Your full name';

  @override
  String get phone10Digits => '10 digits';

  @override
  String get changeEmailSection => 'Change email';

  @override
  String get emailVerificationNotice => 'A verification email will be sent...';

  @override
  String get newEmail => 'New email';

  @override
  String get updateEmailButton => 'Update email';

  @override
  String get changePasswordSection => 'Change password';

  @override
  String get min8Chars => 'Minimum 8 characters';

  @override
  String get repeatNewPassword => 'Repeat the new password';

  @override
  String get passwordsMismatch => 'Passwords don\'t match';

  @override
  String get myReservations => 'My Reservations';

  @override
  String get activeFilter => 'Active';

  @override
  String get pastFilter => 'Past';

  @override
  String get cancelledFilter => 'Cancelled';

  @override
  String get noReservations => 'You have no reservations';

  @override
  String get reservationDetails => 'Reservation Details';

  @override
  String get reservationId => 'ID:';

  @override
  String get reservationConfirmed => 'Confirmed';

  @override
  String get reservationCompleted => 'Completed';

  @override
  String get reservationCancelled => 'Cancelled';

  @override
  String get modifyButton => 'Modify';

  @override
  String get cancelReservation => 'Cancel';

  @override
  String get notificationTypes => 'Notification types';

  @override
  String get notifTrips => 'Trips';

  @override
  String get notifPayments => 'Payments';

  @override
  String get notifSecurity => 'Security';

  @override
  String get notifPromotions => 'Promotions';

  @override
  String get soundVibration => 'Sound and vibration';

  @override
  String get soundLabel => 'Sound';

  @override
  String get soundDescription => 'Play sound with notifications';

  @override
  String get vibrationLabel => 'Vibration';

  @override
  String get vibrationDescription => 'Vibrate with notifications';

  @override
  String get doNotDisturb => 'Do not disturb';

  @override
  String get quietHours => 'Quiet hours';

  @override
  String get quietHoursDescription => 'Silence notifications during a schedule';

  @override
  String get startTime => 'Start';

  @override
  String get endTime => 'End';

  @override
  String get securityAlertsAlways => 'Security alerts will always be shown';

  @override
  String get notificationsEnabled => 'Notifications enabled';

  @override
  String get notificationsDisabled => 'Notifications disabled';

  @override
  String get enableSystemNotifications =>
      'Please enable notifications in system settings';

  @override
  String get importantLabel => 'Important';

  @override
  String get enableButton => 'Enable';

  @override
  String get confirmPaymentTitle => 'Confirm payment';

  @override
  String get selectPaymentMethod => 'Select a payment method';

  @override
  String get paymentInProgress => 'There is already a payment in progress';

  @override
  String get additionalAuthRequired => 'Additional authentication required';

  @override
  String get paymentRejected => 'Payment rejected:';

  @override
  String get paymentProcessingError => 'Error processing payment';

  @override
  String get paymentConfirmedStatus => 'Payment confirmed';

  @override
  String get paymentProcessed => 'Payment processed for';

  @override
  String get lookingForDriver => 'Looking for driver';

  @override
  String get addNewCard => 'Add new card';

  @override
  String get estimatedTime => 'Estimated time';

  @override
  String get paymentSecurityNotice =>
      'Secure payment. Your information is protected with bank-level encryption.';

  @override
  String get originLabel => 'Origin';

  @override
  String get destinationLabel => 'Destination';

  @override
  String get serviceLabel => 'Service';

  @override
  String get allTrips => 'All';

  @override
  String get completedTrips => 'Completed';

  @override
  String get cancelledTrips => 'Cancelled';

  @override
  String get noTripsDisplay => 'No trips to display';

  @override
  String get selectRoute => 'Select your route';

  @override
  String get noRoutes => 'No routes available';

  @override
  String get reloadRoutes => 'Reload routes';

  @override
  String get changeRoute => 'Change route';

  @override
  String get distanceLabel => 'Distance';

  @override
  String get servicePtp => 'Point to Point';

  @override
  String get serviceArmedEscort => 'With Armed Escort';

  @override
  String get serviceUnarmedEscort => 'With Unarmed Escort';

  @override
  String get serviceArmoredEscort => 'Armored Car + Escort';

  @override
  String get requestTripButton => 'Request trip';

  @override
  String get includesTolls => '(includes tolls)';

  @override
  String get tripInProgressTitle => 'Trip in Progress';

  @override
  String get tripCompletedTitle => 'Trip Completed';

  @override
  String get tripSuccessMessage => 'Your trip has successfully ended!';

  @override
  String get totalLabel => 'Total';

  @override
  String get durationLabel => 'Duration';

  @override
  String get skipButton => 'Skip';

  @override
  String get rateTripButton => 'Rate trip';

  @override
  String get exitTripTitle => 'Exit trip?';

  @override
  String get exitTripMessage =>
      'Your trip is in progress. Are you sure you want to exit? You can return from the main page.';

  @override
  String get exitButton => 'Exit';

  @override
  String get phoneNotAvailable => 'Phone number not available';

  @override
  String get cannotMakeCall => 'Cannot make call';

  @override
  String get errorLoadingTrip => 'Error loading trip';

  @override
  String get onlyDriverFinish => 'Only the driver can finish the trip';

  @override
  String get waitingFinish => 'Waiting for completion';

  @override
  String get panicButtonLabel => 'PANIC';

  @override
  String get vehicleTypeLabel => 'Executive Suburban';

  @override
  String get waitingTitle => 'Waiting for assignment';

  @override
  String get driverAssignedTitle => 'Driver assigned!';

  @override
  String get driverOnWay => 'Your driver is on the way';

  @override
  String get vehicleLabel => 'Vehicle';

  @override
  String get viewTrip => 'View trip';

  @override
  String get tripCancelledTitle => 'Trip cancelled';

  @override
  String get tripCancelledMessage => 'Your trip has been cancelled.';

  @override
  String get tripDetails => 'Trip details';

  @override
  String get routeLabel => 'Route';

  @override
  String get priceLabel => 'Price';

  @override
  String get requestedLabel => 'Requested';

  @override
  String get cancelTripButton => 'Cancel trip';

  @override
  String get stayButton => 'Stay';

  @override
  String get exitAssignmentMessage =>
      'Your trip is still being assigned. Do you want to exit?';

  @override
  String get cancelTripConfirm => 'Are you sure you want to cancel this trip?';

  @override
  String get yesCancel => 'Yes, cancel';

  @override
  String get driverLabel => 'Driver';

  @override
  String get useDeviceCamera => 'Use the device camera';

  @override
  String get acceptTermsPrefix => 'I accept the ';

  @override
  String get termsLink => 'terms and conditions';

  @override
  String get acceptPrivacyPrefix => 'I accept the ';

  @override
  String get privacyLink => 'privacy policy';

  @override
  String errorUploadingDocs(String error) {
    return 'Error uploading documents: $error';
  }

  @override
  String get paymentConfirmed => 'Payment confirmed';

  @override
  String paymentProcessedMessage(String amount) {
    return 'Payment of $amount has been processed';
  }

  @override
  String get confirmPayment => 'Confirm payment';

  @override
  String get noSavedCards => 'No saved cards';

  @override
  String get addCardToContinue => 'Add a card to continue';

  @override
  String get processingPayment => 'Processing payment...';

  @override
  String get retryingPayment => 'Retrying...';

  @override
  String get confirmingPayment => 'Confirming payment...';

  @override
  String get paymentCompleted => 'Payment completed';

  @override
  String get retryPayment => 'Retry payment';

  @override
  String payAmount(String amount) {
    return 'Pay \$$amount';
  }

  @override
  String get securePaymentNote =>
      'Secure payment. Your information is protected with bank-level encryption.';

  @override
  String cardExpires(String date) {
    return 'Expires $date';
  }

  @override
  String get defaultCard => 'Default';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String get exitTitle => 'Exit';

  @override
  String get cancelTripConfirmMessage =>
      'Are you sure you want to cancel this trip?';

  @override
  String get noButton => 'No';

  @override
  String get yesCancelButton => 'Yes, cancel';

  @override
  String get tripCompletedMessage => 'Your trip has successfully ended!';

  @override
  String get onlyDriverCanEnd => 'Only the driver can finish the trip';

  @override
  String get waitingCompletion => 'Waiting for completion';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusAssigned => 'Assigned';

  @override
  String availableRoutes(int count) {
    return 'Available Routes ($count)';
  }

  @override
  String get selectYourRoute => 'Select your route';

  @override
  String get noRoutesAvailable => 'No routes available';

  @override
  String get checkConsoleDetails => 'Check the console for more details';

  @override
  String get minutes => 'minutes';

  @override
  String get serviceType => 'Service type';

  @override
  String get mustLogin => 'You must log in';

  @override
  String get byRouteTitle => 'By Route';

  @override
  String get byRouteSubtitle => 'Predefined routes';

  @override
  String get byDayTitle => 'By Day';

  @override
  String get byDaySubtitle => 'Full service';

  @override
  String get customTripTitle => 'Customize your Trip';

  @override
  String get customTripSubtitle => 'Enter origin and destination manually';

  @override
  String get navHome => 'Home';

  @override
  String get navRoutes => 'Routes';

  @override
  String get navActivity => 'Activity';

  @override
  String get navProfile => 'Profile';

  @override
  String get scheduleForLater => 'Schedule for later';

  @override
  String get selectOriginDestination => 'Select origin and destination';

  @override
  String get errorPrefix => 'Error';

  @override
  String get scheduleMinTime =>
      'The trip must be scheduled at least 30 minutes in advance';

  @override
  String get panicDialogTitle => 'Panic Button';

  @override
  String get panicDialogMessage =>
      'Are you sure you want to activate the panic button? An immediate alert will be sent.';

  @override
  String get continueToPay => 'Continue to payment';

  @override
  String get passengerRole => 'Passenger';

  @override
  String get onlyMexicoDestinations =>
      'Only destinations within Mexico are allowed';

  @override
  String get tapMapToSelect => 'Tap the map to select';

  @override
  String get personalDocsTitle => 'Personal Documents';

  @override
  String get personalDocsDescription =>
      'Valid official ID required for the service';

  @override
  String get notifTripsDescription => 'Updates on your trip status';

  @override
  String get notifPaymentsDescription => 'Payment confirmations and receipts';

  @override
  String get notifSecurityDescription =>
      'Important security and account alerts';

  @override
  String get notifPromotionsDescription => 'Special offers and discounts';

  @override
  String get notificationsEnabledDesc =>
      'You will receive Blincar notifications';

  @override
  String get changeLabel => 'Change';

  @override
  String get scheduleMinimumTime =>
      'The trip must be scheduled at least 30 minutes in advance';

  @override
  String get activate => 'Activate';

  @override
  String get loginRequired => 'You must be logged in';

  @override
  String get serviceTypePtoP => 'Point to Point';

  @override
  String get serviceTypeArmedEscort => 'With Armed Escort';

  @override
  String get serviceTypeUnarmedEscort => 'With Unarmed Escort';

  @override
  String get serviceTypeArmored => 'Armored Vehicle';

  @override
  String get serviceTypeArmoredEscort => 'Armored + Escort';

  @override
  String get byDayComingSoon =>
      'The daily service will allow you to hire a driver and vehicle for a full day for multiple trips.';

  @override
  String get tripsCompleted => 'Completed trips';

  @override
  String get totalSpent => 'Total spent';

  @override
  String get registerLinkPrefix => 'Don\'t have an account? ';

  @override
  String get registerLinkAction => 'Sign up';

  @override
  String get supportDescription =>
      'Our support team is available 24/7 to help you';
}
