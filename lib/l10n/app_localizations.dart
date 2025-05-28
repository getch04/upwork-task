import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @expressYourMoodsWithStyle.
  ///
  /// In en, this message translates to:
  /// **'Express your\nmoods with\nstyle'**
  String get expressYourMoodsWithStyle;

  /// No description provided for @yourDailyMoodCompanion.
  ///
  /// In en, this message translates to:
  /// **'Your daily\nmood\ncompanion'**
  String get yourDailyMoodCompanion;

  /// No description provided for @expressYourself.
  ///
  /// In en, this message translates to:
  /// **'Express yourself'**
  String get expressYourself;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @disgust.
  ///
  /// In en, this message translates to:
  /// **'Disgust'**
  String get disgust;

  /// No description provided for @fear.
  ///
  /// In en, this message translates to:
  /// **'Fear'**
  String get fear;

  /// No description provided for @happiness.
  ///
  /// In en, this message translates to:
  /// **'Happiness'**
  String get happiness;

  /// No description provided for @calm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get calm;

  /// No description provided for @surprise.
  ///
  /// In en, this message translates to:
  /// **'Surprise'**
  String get surprise;

  /// No description provided for @anger.
  ///
  /// In en, this message translates to:
  /// **'Anger'**
  String get anger;

  /// No description provided for @veryHappy.
  ///
  /// In en, this message translates to:
  /// **'Very Happy'**
  String get veryHappy;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutral;

  /// No description provided for @sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// No description provided for @verySad.
  ///
  /// In en, this message translates to:
  /// **'Very Sad'**
  String get verySad;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'MoodBoard'**
  String get appName;

  /// No description provided for @expressYourEmotions.
  ///
  /// In en, this message translates to:
  /// **'Express your emotions'**
  String get expressYourEmotions;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back,'**
  String get welcomeBack;

  /// No description provided for @todaysMood.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Mood'**
  String get todaysMood;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// No description provided for @weeklyStreak.
  ///
  /// In en, this message translates to:
  /// **'Weekly Streak'**
  String get weeklyStreak;

  /// No description provided for @bestMood.
  ///
  /// In en, this message translates to:
  /// **'Best Mood'**
  String get bestMood;

  /// No description provided for @moodTrends.
  ///
  /// In en, this message translates to:
  /// **'Mood Trends'**
  String get moodTrends;

  /// No description provided for @journalEntries.
  ///
  /// In en, this message translates to:
  /// **'Journal Entries'**
  String get journalEntries;

  /// No description provided for @newEntry.
  ///
  /// In en, this message translates to:
  /// **'New Entry'**
  String get newEntry;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @bestMoodHappy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get bestMoodHappy;

  /// No description provided for @streak5Days.
  ///
  /// In en, this message translates to:
  /// **'5 Days'**
  String get streak5Days;

  /// No description provided for @annette.
  ///
  /// In en, this message translates to:
  /// **'Annette'**
  String get annette;

  /// No description provided for @feelingEnergizedAndMotivated.
  ///
  /// In en, this message translates to:
  /// **'Feeling energized and motivated! Started the day with meditation and a healthy breakfast. Ready to tackle any challenge.'**
  String get feelingEnergizedAndMotivated;

  /// No description provided for @nineThirtyAM.
  ///
  /// In en, this message translates to:
  /// **'9:30 AM'**
  String get nineThirtyAM;

  /// No description provided for @achievedDailyGoals.
  ///
  /// In en, this message translates to:
  /// **'Achieved my daily goals'**
  String get achievedDailyGoals;

  /// No description provided for @creativeBreakthrough.
  ///
  /// In en, this message translates to:
  /// **'Creative breakthrough'**
  String get creativeBreakthrough;

  /// No description provided for @inspired.
  ///
  /// In en, this message translates to:
  /// **'Inspired'**
  String get inspired;

  /// No description provided for @newBeginnings.
  ///
  /// In en, this message translates to:
  /// **'New beginnings'**
  String get newBeginnings;

  /// No description provided for @hopeful.
  ///
  /// In en, this message translates to:
  /// **'Hopeful'**
  String get hopeful;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey'**
  String get signInToContinue;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing In...'**
  String get signingIn;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

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

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @followSystemTheme.
  ///
  /// In en, this message translates to:
  /// **'Follow system theme'**
  String get followSystemTheme;

  /// No description provided for @lightColorScheme.
  ///
  /// In en, this message translates to:
  /// **'Light color scheme'**
  String get lightColorScheme;

  /// No description provided for @darkColorScheme.
  ///
  /// In en, this message translates to:
  /// **'Dark color scheme'**
  String get darkColorScheme;

  /// No description provided for @selectTheme.
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @journalPreviewProductive.
  ///
  /// In en, this message translates to:
  /// **'Today was incredibly productive. I managed to complete all my tasks and even had time for a quick workout.'**
  String get journalPreviewProductive;

  /// No description provided for @journalPreviewCreative.
  ///
  /// In en, this message translates to:
  /// **'Finally found inspiration for my art project. The colors and composition just clicked together perfectly.'**
  String get journalPreviewCreative;

  /// No description provided for @journalPreviewNewBeginnings.
  ///
  /// In en, this message translates to:
  /// **'Started a new chapter in my life. Feeling optimistic about the future and all its possibilities.'**
  String get journalPreviewNewBeginnings;

  /// No description provided for @howAreYouFeelingToday.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get howAreYouFeelingToday;

  /// No description provided for @positiveMoodRate.
  ///
  /// In en, this message translates to:
  /// **'Positive Mood Rate'**
  String get positiveMoodRate;

  /// No description provided for @moodOverview.
  ///
  /// In en, this message translates to:
  /// **'Mood Overview'**
  String get moodOverview;

  /// No description provided for @moodStreak.
  ///
  /// In en, this message translates to:
  /// **'Mood Streak'**
  String get moodStreak;

  /// No description provided for @sevenDays.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get sevenDays;

  /// No description provided for @keepTrackingYourMood.
  ///
  /// In en, this message translates to:
  /// **'Keep tracking your mood!'**
  String get keepTrackingYourMood;

  /// No description provided for @reflections.
  ///
  /// In en, this message translates to:
  /// **'Reflections'**
  String get reflections;

  /// No description provided for @twelve.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get twelve;

  /// No description provided for @writtenThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Written this week'**
  String get writtenThisWeek;

  /// No description provided for @happyDays.
  ///
  /// In en, this message translates to:
  /// **'Happy Days'**
  String get happyDays;

  /// No description provided for @fiveDays.
  ///
  /// In en, this message translates to:
  /// **'5 days'**
  String get fiveDays;

  /// No description provided for @goalsMet.
  ///
  /// In en, this message translates to:
  /// **'Goals Met'**
  String get goalsMet;

  /// No description provided for @threeOfFive.
  ///
  /// In en, this message translates to:
  /// **'3/5'**
  String get threeOfFive;

  /// No description provided for @weeklyProgress.
  ///
  /// In en, this message translates to:
  /// **'Weekly progress'**
  String get weeklyProgress;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
