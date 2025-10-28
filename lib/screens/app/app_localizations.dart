// l10n/app_localizations.dart
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome',
      'to_vision_erp': 'To Vision ERP',
      'move_towards_better_future': 'Move towards a better future',
      'my_account': 'My Account',
      'notification': 'Notification',
      'my_subscription': 'My Subscription',
      'language': 'Language',
      'about_us': 'About Us',
      'logout': 'Logout',
      'light_mode': 'Light Mode ON',
      'dark_mode': 'Dark Mode ON',
      'english': 'English',
      'arabic': 'Arabic',
      'reset_intro': 'Reset Intro (Testing)',
      'profile': 'Profile',
      'organization': 'Organization',
      'demo_system': 'Demo System',
      'live_system_login': 'Live System Login',
      'credentials': 'Credentials',
      'system_url': 'System URL',
      'username': 'Username',
      'password': 'Password',
      'go_to_demo_system': 'Go to Demo System',
      'you_will_be_redirected': 'You will be redirected to the external demo system',
      'demo_system_information': 'Demo System Information',
      'demo_system_description': 'This demo system contains sample data for demonstration purposes. You can explore the features but changes will not be saved.',
      'company_overview': 'Company Overview',
      'key_information': 'Key Information',
      'contact_location': 'Contact & Location',
      'our_teams': 'Our Teams',
      'company_type': 'Company Type',
      'headquarters': 'Headquarters',
      'operating_in': 'Operating In',
      'certifications': 'Certifications',
      'business_hours': 'Business Hours',
      'email': 'Email',
      'phone': 'Phone',
      'website': 'Website',
      'engineering': 'Engineering',
      'product': 'Product',
      'sales': 'Sales',
      'marketing': 'Marketing',
      'support': 'Support',
      'finance': 'Finance',
      'hr': 'HR',
      'operations': 'Operations',
      'employees': 'Employees',
      'projects': 'Projects',
      'clients': 'Clients',
      'countries': 'Countries',
      'account_details': 'Account Details',
      'documents': 'Documents',
      'turn_your_location': 'Turn your location',
      'location_description': 'This will expose face of target',
      'bank_account': 'Bank Account',
      'activities_notifications': 'Activities notifications',
      'notifications_description': 'Payment facades, links and other activities',
      'email_notification': 'Email notification',
      'sign_in_touch_id': 'Sign in with touch ID',
      'change_password': 'Change password',
      'edit_profile': 'Edit Profile',
      'settings': 'Settings',
      'name': 'Name',
      'role': 'Role',
      'location': 'Location',
      'department': 'Department',
    },
    'ar': {
      'welcome': 'مرحباً',
      'to_vision_erp': 'في نظام Vision ERP',
      'move_towards_better_future': 'انطلق نحو مستقبل أفضل',
      'my_account': 'حسابي',
      'notification': 'الإشعارات',
      'my_subscription': 'اشتراكي',
      'language': 'اللغة',
      'about_us': 'من نحن',
      'logout': 'تسجيل الخروج',
      'light_mode': 'الوضع المضيء',
      'dark_mode': 'الوضع الداكن',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'reset_intro': 'إعادة التعريف (اختبار)',
      'profile': 'الملف الشخصي',
      'organization': 'المؤسسة',
      'demo_system': 'النظام التجريبي',
      'live_system_login': 'تسجيل الدخول للنظام المباشر',
      'credentials': 'بيانات الدخول',
      'system_url': 'رابط النظام',
      'username': 'اسم المستخدم',
      'password': 'كلمة المرور',
      'go_to_demo_system': 'الذهاب للنظام التجريبي',
      'you_will_be_redirected': 'سيتم توجيهك إلى النظام التجريبي الخارجي',
      'demo_system_information': 'معلومات النظام التجريبي',
      'demo_system_description': 'يحتوي هذا النظام التجريبي على بيانات نموذجية لأغراض العرض. يمكنك استكشاف الميزات ولكن التغييرات لن يتم حفظها.',
      'company_overview': 'نظرة عامة على الشركة',
      'key_information': 'المعلومات الرئيسية',
      'contact_location': 'الاتصال والموقع',
      'our_teams': 'فرقنا',
      'company_type': 'نوع الشركة',
      'headquarters': 'المقر الرئيسي',
      'operating_in': 'نشطة في',
      'certifications': 'الشهادات',
      'business_hours': 'ساعات العمل',
      'email': 'البريد الإلكتروني',
      'phone': 'الهاتف',
      'website': 'الموقع الإلكتروني',
      'engineering': 'الهندسة',
      'product': 'المنتج',
      'sales': 'المبيعات',
      'marketing': 'التسويق',
      'support': 'الدعم',
      'finance': 'المالية',
      'hr': 'الموارد البشرية',
      'operations': 'العمليات',
      'employees': 'الموظفين',
      'projects': 'المشاريع',
      'clients': 'العملاء',
      'countries': 'الدول',
      'account_details': 'تفاصيل الحساب',
      'documents': 'المستندات',
      'turn_your_location': 'تشغيل موقعك',
      'location_description': 'هذا سيكشف وجه الهدف',
      'bank_account': 'الحساب البنكي',
      'activities_notifications': 'إشعارات الأنشطة',
      'notifications_description': 'واجهات الدفع، الروابط والأنشطة الأخرى',
      'email_notification': 'إشعارات البريد الإلكتروني',
      'sign_in_touch_id': 'تسجيل الدخول ببصمة الإصبع',
      'change_password': 'تغيير كلمة المرور',
      'edit_profile': 'تعديل الملف الشخصي',
      'settings': 'الإعدادات',
      'name': 'الاسم',
      'role': 'المسمى الوظيفي',
      'location': 'الموقع',
      'department': 'القسم',
    },
  };

  String get welcome {
    return _localizedValues[locale.languageCode]!['welcome']!;
  }

  String get toVisionERP {
    return _localizedValues[locale.languageCode]!['to_vision_erp']!;
  }

  String get moveTowardsBetterFuture {
    return _localizedValues[locale.languageCode]!['move_towards_better_future']!;
  }

  String get myAccount {
    return _localizedValues[locale.languageCode]!['my_account']!;
  }

  String get notification {
    return _localizedValues[locale.languageCode]!['notification']!;
  }

  String get mySubscription {
    return _localizedValues[locale.languageCode]!['my_subscription']!;
  }

  String get language {
    return _localizedValues[locale.languageCode]!['language']!;
  }

  String get aboutUs {
    return _localizedValues[locale.languageCode]!['about_us']!;
  }

  String get logout {
    return _localizedValues[locale.languageCode]!['logout']!;
  }

  String get lightMode {
    return _localizedValues[locale.languageCode]!['light_mode']!;
  }

  String get darkMode {
    return _localizedValues[locale.languageCode]!['dark_mode']!;
  }

  String get english {
    return _localizedValues[locale.languageCode]!['english']!;
  }

  String get arabic {
    return _localizedValues[locale.languageCode]!['arabic']!;
  }

  String get resetIntro {
    return _localizedValues[locale.languageCode]!['reset_intro']!;
  }

  String get profile {
    return _localizedValues[locale.languageCode]!['profile']!;
  }

  String get organization {
    return _localizedValues[locale.languageCode]!['organization']!;
  }

  String get demoSytem {
    return _localizedValues[locale.languageCode]!['demo_system']!;
  }

  String get liveSystemLogin {
    return _localizedValues[locale.languageCode]!['live_system_login']!;
  }

  String get credentials {
    return _localizedValues[locale.languageCode]!['credentials']!;
  }

  String get systemUrl {
    return _localizedValues[locale.languageCode]!['system_url']!;
  }

  String get username {
    return _localizedValues[locale.languageCode]!['username']!;
  }

  String get password {
    return _localizedValues[locale.languageCode]!['password']!;
  }

  String get goToDemoSystem {
    return _localizedValues[locale.languageCode]!['go_to_demo_system']!;
  }

  String get youWillBeRedirected {
    return _localizedValues[locale.languageCode]!['you_will_be_redirected']!;
  }

  String get demoSystemInformation {
    return _localizedValues[locale.languageCode]!['demo_system_information']!;
  }

  String get demoSystemDescription {
    return _localizedValues[locale.languageCode]!['demo_system_description']!;
  }

  String get companyOverview {
    return _localizedValues[locale.languageCode]!['company_overview']!;
  }

  String get keyInformation {
    return _localizedValues[locale.languageCode]!['key_information']!;
  }

  String get contactLocation {
    return _localizedValues[locale.languageCode]!['contact_location']!;
  }

  String get ourTeams {
    return _localizedValues[locale.languageCode]!['our_teams']!;
  }

  String get companyType {
    return _localizedValues[locale.languageCode]!['company_type']!;
  }

  String get headquarters {
    return _localizedValues[locale.languageCode]!['headquarters']!;
  }

  String get operatingIn {
    return _localizedValues[locale.languageCode]!['operating_in']!;
  }

  String get certifications {
    return _localizedValues[locale.languageCode]!['certifications']!;
  }

  String get businessHours {
    return _localizedValues[locale.languageCode]!['business_hours']!;
  }

  String get email {
    return _localizedValues[locale.languageCode]!['email']!;
  }

  String get phone {
    return _localizedValues[locale.languageCode]!['phone']!;
  }

  String get website {
    return _localizedValues[locale.languageCode]!['website']!;
  }

  String get engineering {
    return _localizedValues[locale.languageCode]!['engineering']!;
  }

  String get product {
    return _localizedValues[locale.languageCode]!['product']!;
  }

  String get sales {
    return _localizedValues[locale.languageCode]!['sales']!;
  }

  String get marketing {
    return _localizedValues[locale.languageCode]!['marketing']!;
  }

  String get support {
    return _localizedValues[locale.languageCode]!['support']!;
  }

  String get finance {
    return _localizedValues[locale.languageCode]!['finance']!;
  }

  String get hr {
    return _localizedValues[locale.languageCode]!['hr']!;
  }

  String get operations {
    return _localizedValues[locale.languageCode]!['operations']!;
  }

  String get employees {
    return _localizedValues[locale.languageCode]!['employees']!;
  }

  String get projects {
    return _localizedValues[locale.languageCode]!['projects']!;
  }

  String get clients {
    return _localizedValues[locale.languageCode]!['clients']!;
  }

  String get countries {
    return _localizedValues[locale.languageCode]!['countries']!;
  }

  String get accountDetails {
    return _localizedValues[locale.languageCode]!['account_details']!;
  }

  String get documents {
    return _localizedValues[locale.languageCode]!['documents']!;
  }

  String get turnYourLocation {
    return _localizedValues[locale.languageCode]!['turn_your_location']!;
  }

  String get locationDescription {
    return _localizedValues[locale.languageCode]!['location_description']!;
  }

  String get bankAccount {
    return _localizedValues[locale.languageCode]!['bank_account']!;
  }

  String get activitiesNotifications {
    return _localizedValues[locale.languageCode]!['activities_notifications']!;
  }

  String get notificationsDescription {
    return _localizedValues[locale.languageCode]!['notifications_description']!;
  }

  String get emailNotification {
    return _localizedValues[locale.languageCode]!['email_notification']!;
  }

  String get signInTouchId {
    return _localizedValues[locale.languageCode]!['sign_in_touch_id']!;
  }

  String get changePassword {
    return _localizedValues[locale.languageCode]!['change_password']!;
  }

  String get editProfile {
    return _localizedValues[locale.languageCode]!['edit_profile']!;
  }

  String get settings {
    return _localizedValues[locale.languageCode]!['settings']!;
  }

  String get name {
    return _localizedValues[locale.languageCode]!['name']!;
  }

  String get role {
    return _localizedValues[locale.languageCode]!['role']!;
  }

  String get location {
    return _localizedValues[locale.languageCode]!['location']!;
  }

  String get department {
    return _localizedValues[locale.languageCode]!['department']!;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}