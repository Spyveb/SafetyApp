import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @pleaseLoginToProceed.
  ///
  /// In en, this message translates to:
  /// **'Please Login to proceed.'**
  String get pleaseLoginToProceed;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get enterYourPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @pleaseCompleteForm.
  ///
  /// In en, this message translates to:
  /// **'Please complete the form.'**
  String get pleaseCompleteForm;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @preferredUsername.
  ///
  /// In en, this message translates to:
  /// **'Preferred Username'**
  String get preferredUsername;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @tipOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Tip of the day'**
  String get tipOfTheDay;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @upcomingEvents.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Events'**
  String get upcomingEvents;

  /// No description provided for @newEvents.
  ///
  /// In en, this message translates to:
  /// **'New Events'**
  String get newEvents;

  /// No description provided for @helloHowCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'Hello, How can we help?'**
  String get helloHowCanWeHelp;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @advice.
  ///
  /// In en, this message translates to:
  /// **'Advice'**
  String get advice;

  /// No description provided for @helpLine.
  ///
  /// In en, this message translates to:
  /// **'Help Line'**
  String get helpLine;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get callNow;

  /// No description provided for @newsUpdates.
  ///
  /// In en, this message translates to:
  /// **'News Updates'**
  String get newsUpdates;

  /// No description provided for @enterReportDetails.
  ///
  /// In en, this message translates to:
  /// **'Please enter a detailed report of your incident'**
  String get enterReportDetails;

  /// No description provided for @attachScreenshots.
  ///
  /// In en, this message translates to:
  /// **'Attach Screenshots'**
  String get attachScreenshots;

  /// No description provided for @rateFeelings.
  ///
  /// In en, this message translates to:
  /// **'Please rate how you feel'**
  String get rateFeelings;

  /// No description provided for @speakToProfessional.
  ///
  /// In en, this message translates to:
  /// **'Would you like to speak to a professional'**
  String get speakToProfessional;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @likeToSpeak.
  ///
  /// In en, this message translates to:
  /// **'I\'d like to speak to a professional'**
  String get likeToSpeak;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @notRightNow.
  ///
  /// In en, this message translates to:
  /// **'No, not right now'**
  String get notRightNow;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @scrollThroughAdvice.
  ///
  /// In en, this message translates to:
  /// **'Please scroll through our advice section for quick assistance'**
  String get scrollThroughAdvice;

  /// No description provided for @customizeApp.
  ///
  /// In en, this message translates to:
  /// **'Customize your app to get the best experience!'**
  String get customizeApp;

  /// No description provided for @chooseAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose app language'**
  String get chooseAppLanguage;

  /// No description provided for @setAppTheme.
  ///
  /// In en, this message translates to:
  /// **'Set app Theme'**
  String get setAppTheme;

  /// No description provided for @signout.
  ///
  /// In en, this message translates to:
  /// **'Signout'**
  String get signout;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @aboutText.
  ///
  /// In en, this message translates to:
  /// **'Welcome to GVB & Cyber Harassment App! These terms and conditions outline the rules and regulations for the use of GVB &amp; Cyber Harassment App\'s Website, located at https://gbvapp.com. By accessing this website we assume you accept these terms and conditions. Do not continue to use GVB &Cyber Harassment App if you do not agree to take all of the terms and conditions stated on this page. The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: \"Client\", \"You\" and \"Your\" refers to you, the person log on this website and compliant to the Company\'s terms and conditions. \"The Company\", \"Ourselves\", \"We\", \"Our\" and \"Us\", refers to our Company. \"Party\", \"Parties\", or \"Us\", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client\'s needs in respect of provision of the Company\'s stated services, in accordance with and subject to, prevailing law of Namibia.'**
  String get aboutText;

  /// No description provided for @selectPreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select preferred language'**
  String get selectPreferredLanguage;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @pressAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press the back button again to exit'**
  String get pressAgainToExit;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @emergencyServices.
  ///
  /// In en, this message translates to:
  /// **'Emergency Services'**
  String get emergencyServices;

  /// No description provided for @thankYouForReporting.
  ///
  /// In en, this message translates to:
  /// **'Thank you for reporting!'**
  String get thankYouForReporting;

  /// No description provided for @youCanUndoThisReportWithin5Seconds.
  ///
  /// In en, this message translates to:
  /// **'You can undo this report within 5 seconds if it was sent by mistake.'**
  String get youCanUndoThisReportWithin5Seconds;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @pressButtonToSendSOS.
  ///
  /// In en, this message translates to:
  /// **'Press button to send SOS'**
  String get pressButtonToSendSOS;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @reportCrimes.
  ///
  /// In en, this message translates to:
  /// **'Report\nCrimes'**
  String get reportCrimes;

  /// No description provided for @accessEducationalResources.
  ///
  /// In en, this message translates to:
  /// **'Access\nEducational Resources'**
  String get accessEducationalResources;

  /// No description provided for @freeConsultation.
  ///
  /// In en, this message translates to:
  /// **'Free\nConsultation'**
  String get freeConsultation;

  /// No description provided for @safetyPlanning.
  ///
  /// In en, this message translates to:
  /// **'Safety\nPlanning'**
  String get safetyPlanning;

  /// No description provided for @reportYourCase.
  ///
  /// In en, this message translates to:
  /// **'Report your case'**
  String get reportYourCase;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @submitYourInfo.
  ///
  /// In en, this message translates to:
  /// **'Submit your info'**
  String get submitYourInfo;

  /// No description provided for @filesAndInformation.
  ///
  /// In en, this message translates to:
  /// **'Files and Information'**
  String get filesAndInformation;

  /// No description provided for @alertFriends.
  ///
  /// In en, this message translates to:
  /// **'Alert Friends'**
  String get alertFriends;

  /// No description provided for @reportAnonymously.
  ///
  /// In en, this message translates to:
  /// **'Report Anonymously'**
  String get reportAnonymously;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Enter Text....'**
  String get enterText;

  /// No description provided for @confirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Message'**
  String get confirmationMessage;

  /// No description provided for @sendReportAlert.
  ///
  /// In en, this message translates to:
  /// **'You are about to send a report. Are you sure you want to proceed?'**
  String get sendReportAlert;

  /// No description provided for @wouldYouLikeToSpeakAProfessional.
  ///
  /// In en, this message translates to:
  /// **'Would you like to speak a professional?'**
  String get wouldYouLikeToSpeakAProfessional;

  /// No description provided for @ourTeamWillContactYouForMoreDetails.
  ///
  /// In en, this message translates to:
  /// **'Our Team will contact you for more details'**
  String get ourTeamWillContactYouForMoreDetails;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergencyContacts;

  /// No description provided for @pleaseAddYourEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Please add your emergency contacts'**
  String get pleaseAddYourEmergencyContacts;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contacts;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Add Emergency Contacts'**
  String get addEmergencyContacts;

  /// No description provided for @enterYourUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter your Username'**
  String get enterYourUsername;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to'**
  String get iAgreeTo;

  /// No description provided for @registrationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration\nSuccessful!'**
  String get registrationSuccessful;

  /// No description provided for @registrationUnSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Registration\nUnsuccessful!'**
  String get registrationUnSuccessful;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration\nFailed!'**
  String get registrationFailed;

  /// No description provided for @youWillBeRedirectedToTheLogInPage.
  ///
  /// In en, this message translates to:
  /// **'You will be redirected\nto the Log In page'**
  String get youWillBeRedirectedToTheLogInPage;

  /// No description provided for @tapToContinue.
  ///
  /// In en, this message translates to:
  /// **'Tap to Continue'**
  String get tapToContinue;

  /// No description provided for @empower.
  ///
  /// In en, this message translates to:
  /// **'Empower. Protect. Transform.'**
  String get empower;

  /// No description provided for @trainings.
  ///
  /// In en, this message translates to:
  /// **'Trainings'**
  String get trainings;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get training;

  /// No description provided for @allEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Please note: all emergency contacts will receive a copy of your reports.'**
  String get allEmergencyContacts;

  /// No description provided for @emergencyContactsAdded.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts Added'**
  String get emergencyContactsAdded;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No Internet connection'**
  String get noInternetConnection;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, try again later'**
  String get somethingWentWrong;

  /// No description provided for @errorOccurredWhileCommunicatingWithServer.
  ///
  /// In en, this message translates to:
  /// **'Error occurred while Communication with Server with StatusCode'**
  String get errorOccurredWhileCommunicatingWithServer;

  /// No description provided for @pleaseEnter.
  ///
  /// In en, this message translates to:
  /// **'Please enter'**
  String get pleaseEnter;

  /// No description provided for @pleaseEnterAValid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid'**
  String get pleaseEnterAValid;

  /// No description provided for @shouldNotBeGreaterThan.
  ///
  /// In en, this message translates to:
  /// **'Should not be greater than 50'**
  String get shouldNotBeGreaterThan;

  /// No description provided for @pleaseEnterYourUserName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get pleaseEnterYourUserName;

  /// No description provided for @youEnteredAnInvalidUserName.
  ///
  /// In en, this message translates to:
  /// **'You’ve entered an invalid username'**
  String get youEnteredAnInvalidUserName;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status: '**
  String get status;

  /// No description provided for @sosEmergency.
  ///
  /// In en, this message translates to:
  /// **'SOS Emergency'**
  String get sosEmergency;

  /// No description provided for @reportedEmergency.
  ///
  /// In en, this message translates to:
  /// **'Reported Emergency'**
  String get reportedEmergency;

  /// No description provided for @reportedNonEmergency.
  ///
  /// In en, this message translates to:
  /// **'Reported Non Emergency'**
  String get reportedNonEmergency;

  /// No description provided for @logNewIncident.
  ///
  /// In en, this message translates to:
  /// **'Log New Incident'**
  String get logNewIncident;

  /// No description provided for @sosRequest.
  ///
  /// In en, this message translates to:
  /// **'SOS Request'**
  String get sosRequest;

  /// No description provided for @requester.
  ///
  /// In en, this message translates to:
  /// **'Requester: '**
  String get requester;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location: '**
  String get location;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number: '**
  String get mobileNumber;

  /// No description provided for @emergencyEvent.
  ///
  /// In en, this message translates to:
  /// **'Emergency event: '**
  String get emergencyEvent;

  /// No description provided for @estimatedTimeOfArrival.
  ///
  /// In en, this message translates to:
  /// **'Estimated time of arrival: '**
  String get estimatedTimeOfArrival;

  /// No description provided for @requestBackup.
  ///
  /// In en, this message translates to:
  /// **'Request Backup'**
  String get requestBackup;

  /// No description provided for @endSos.
  ///
  /// In en, this message translates to:
  /// **'End SOS'**
  String get endSos;

  /// No description provided for @whatHappenedThisEvent.
  ///
  /// In en, this message translates to:
  /// **'What happened when you responded to this event?'**
  String get whatHappenedThisEvent;

  /// No description provided for @backupRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Backup Request Sent'**
  String get backupRequestSent;

  /// No description provided for @aBackupSentYourDestination.
  ///
  /// In en, this message translates to:
  /// **'A backup will be sent to your destination shortly.'**
  String get aBackupSentYourDestination;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @counsellor.
  ///
  /// In en, this message translates to:
  /// **'Counsellor'**
  String get counsellor;

  /// No description provided for @searchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search location'**
  String get searchLocation;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @addContact.
  ///
  /// In en, this message translates to:
  /// **'Add contact'**
  String get addContact;

  /// No description provided for @enterContactName.
  ///
  /// In en, this message translates to:
  /// **'Enter contact name'**
  String get enterContactName;

  /// No description provided for @enterContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter contact number'**
  String get enterContactNumber;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get userName;

  /// No description provided for @sureDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get sureDeleteAccount;

  /// No description provided for @addNewContact.
  ///
  /// In en, this message translates to:
  /// **'Add new contact'**
  String get addNewContact;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @caseNo.
  ///
  /// In en, this message translates to:
  /// **'Case no'**
  String get caseNo;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @reportedEmergencyCases.
  ///
  /// In en, this message translates to:
  /// **'Reported Emergency Cases'**
  String get reportedEmergencyCases;

  /// No description provided for @searchCases.
  ///
  /// In en, this message translates to:
  /// **'Search case'**
  String get searchCases;

  /// No description provided for @reportedNonEmergencyCases.
  ///
  /// In en, this message translates to:
  /// **'Reported Non Emergency Cases'**
  String get reportedNonEmergencyCases;

  /// No description provided for @sosEmergencyCases.
  ///
  /// In en, this message translates to:
  /// **'SOS Emergency Cases'**
  String get sosEmergencyCases;

  /// No description provided for @areYouSureYouWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureYouWantToLogout;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @emergencyRequestSent.
  ///
  /// In en, this message translates to:
  /// **'EMERGENCY REQUEST SENT'**
  String get emergencyRequestSent;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Permission required'**
  String get permissionRequired;

  /// No description provided for @locationPermissionRequiredSOS.
  ///
  /// In en, this message translates to:
  /// **'To send SOS of your current location, we require the location permission.'**
  String get locationPermissionRequiredSOS;

  /// No description provided for @yourSOSHasBeenSent.
  ///
  /// In en, this message translates to:
  /// **'Your SOS message has been sent. Help is on the way. Stay safe and keep your phone nearby.'**
  String get yourSOSHasBeenSent;

  /// No description provided for @openSetting.
  ///
  /// In en, this message translates to:
  /// **'Open setting'**
  String get openSetting;

  /// No description provided for @sendSOSAlert.
  ///
  /// In en, this message translates to:
  /// **'You are about to send an SOS. Are you sure you want to proceed?'**
  String get sendSOSAlert;

  /// No description provided for @locationRequired.
  ///
  /// In en, this message translates to:
  /// **'Location required'**
  String get locationRequired;

  /// No description provided for @locationRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'To send SOS, we require the location. Select location options.'**
  String get locationRequiredDescription;

  /// No description provided for @addManually.
  ///
  /// In en, this message translates to:
  /// **'Add manually'**
  String get addManually;

  /// No description provided for @myLocation.
  ///
  /// In en, this message translates to:
  /// **'My Location'**
  String get myLocation;

  /// No description provided for @useCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use current location'**
  String get useCurrentLocation;

  /// No description provided for @micPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'To record audio, This app require the microphone permission.'**
  String get micPermissionRequired;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @pleaseEnterPasswordAgain.
  ///
  /// In en, this message translates to:
  /// **'Please enter password again'**
  String get pleaseEnterPasswordAgain;

  /// No description provided for @confirmPasswordDoesNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Password and confirm password does not match'**
  String get confirmPasswordDoesNotMatch;

  /// No description provided for @searchSomething.
  ///
  /// In en, this message translates to:
  /// **'Search something'**
  String get searchSomething;

  /// No description provided for @enterYourEmailToReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to receive a code to reset your password.'**
  String get enterYourEmailToReceiveCode;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @pleaseEnterTheCodeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the Verification code that was sent to '**
  String get pleaseEnterTheCodeSentTo;

  /// No description provided for @policeOfficer.
  ///
  /// In en, this message translates to:
  /// **'Police Officer'**
  String get policeOfficer;

  /// No description provided for @youHaveDeclinedSosRequest.
  ///
  /// In en, this message translates to:
  /// **'You have declined the SOS Request. The request will be sent to another officer'**
  String get youHaveDeclinedSosRequest;

  /// No description provided for @enterYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterYourNewPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @enterNewPasswordAgain.
  ///
  /// In en, this message translates to:
  /// **'Enter new password again'**
  String get enterNewPasswordAgain;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['af', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af': return AppLocalizationsAf();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
