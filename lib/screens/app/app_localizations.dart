import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome',
      'toVisionERP': 'To Vision ERP',
      'RecommendationsForYou': 'Recommendations for You',
      'moveTowardsBetterFuture': 'Move towards a better future',
      'PlanPricing': 'Plan & Pricing',
      'home': 'Home',
      'demo': 'Demo',
      'dashboard': 'Dashboard',
      'profile': 'Profile',
      'menu': 'Menu',
      'loginIntoAccount': 'Login into your\nAccount',
      'enterCredentials': 'Enter your user name and password to log in',
      'userName': 'User Name',
      'password': 'Password',
      'rememberMe': 'Remember me',
      'forgotPassword': 'Forgot Password?',
      'login': 'Login',
      'dontHaveAccount': "Don't have an account? ",
      'signUp': 'Sign Up',
      'myAccount': 'My Account',
      'notification': 'Notification',
      'mySubscription': 'My Subscription',
      'language': 'Language',
      'resetIntro': 'Reset Intro',
      'aboutUs': 'About Us',
      'logout': 'Logout',
      'english': 'English',
      'arabic': 'Arabic',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'main': 'MAIN',
      'settings': 'SETTINGS',
      'moreInfo': 'MORE INFO',
      'organization': 'Organization',
      'accountDetails': 'Account details',
      'documents': 'Documents',
      'turnYourLocation': 'Turn your location',
      'locationSubtitle': 'This will expose face of target',
      'bankDetail': 'BANK DETAIL',
      'bankAccount': 'Bank Account',
      'notifications': 'NOTIFICATIONS',
      'activitiesNotifications': 'Activities notifications',
      'activitiesSubtitle': 'Payment facades, links and other activities',
      'emailNotification': 'Email notification',
      'security': 'SECURITY',
      'signInWithTouchID': 'Sign in with touch ID',
      'changePassword': 'Change password',
      'recentActivity': 'Recent Activity',
      'taskSchedule': 'Task Schedule',
      'viewAll': 'View All',
      'upcomingTasks': 'Upcoming Tasks',
      'seeAll': 'See All',
      'planAndPricing': 'Plan and Pricing',
      'recommendationsForYou': 'Recommendations for you',
      'visionERP': 'Vision ERP',
      'integratingEveryDepartment': 'Integrating every department for seamless data flow and clarity',
      'contractDuration': 'Contract duration',
      'leaveBalance': 'Leave balance',
      'theAudience': 'The Audience',
      'tasks': 'Tasks',
      'visualAuditoryCheck': 'Visual & Auditory Check',
      'visualAuditoryDesc': 'Listen for operation. Check for error lights.',
      'feelTheAuthor': 'Feel the Author',
      'feelTheAuthorDesc': 'Confirm airflow from fresh air supply vents.',
      'checkControlSetting': 'Check the Control Setting',
      'checkControlDesc': 'Ensure unit is on in "Auto" or desired mode.',
      'checkExteriorVents': 'Check Exterior Vents',
      'checkExteriorDesc': 'Ensure outdoor intake/exhaust hoods are not blocked.',
      'done': 'Done',
      'inProgress': 'In Progress',
      'toDo': 'To Do',
    },
    'ar': {
      'welcome': 'مرحباً',
      'toVisionERP': 'في Vision ERP',
      'RecommendationsForYou': 'التوصيات لك',
      'moveTowardsBetterFuture': 'انطلق نحو مستقبل أفضل',
      'PlanPricing': 'الخطة والتكلفة',
      'home': 'الرئيسية',
      'demo': 'تجريبي',
      'dashboard': 'لوحة التحكم',
      'profile': 'الملف الشخصي',
      'menu': 'القائمة',
      'loginIntoAccount': 'تسجيل الدخول إلى\nحسابك',
      'enterCredentials': 'أدخل اسم المستخدم وكلمة المرور لتسجيل الدخول',
      'userName': 'اسم المستخدم',
      'password': 'كلمة المرور',
      'rememberMe': 'تذكرني',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'login': 'تسجيل الدخول',
      'dontHaveAccount': 'ليس لديك حساب؟ ',
      'signUp': 'إنشاء حساب',
      'myAccount': 'حسابي',
      'notification': 'الإشعارات',
      'mySubscription': 'اشتراكي',
      'language': 'اللغة',
      'resetIntro': 'إعادة التعريف',
      'aboutUs': 'من نحن',
      'logout': 'تسجيل الخروج',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'darkMode': 'الوضع الداكن',
      'lightMode': 'الوضع الفاتح',
      'main': 'الرئيسي',
      'settings': 'الإعدادات',
      'moreInfo': 'معلومات أكثر',
      'organization': 'المؤسسة',
      'accountDetails': 'تفاصيل الحساب',
      'documents': 'المستندات',
      'turnYourLocation': 'تشغيل موقعك',
      'locationSubtitle': 'هذا سيكشف وجه الهدف',
      'bankDetail': 'تفاصيل البنك',
      'bankAccount': 'الحساب البنكي',
      'notifications': 'الإشعارات',
      'activitiesNotifications': 'إشعارات الأنشطة',
      'activitiesSubtitle': 'واجهات الدفع، الروابط والأنشطة الأخرى',
      'emailNotification': 'إشعارات البريد الإلكتروني',
      'security': 'الأمان',
      'signInWithTouchID': 'تسجيل الدخول بالبصمة',
      'changePassword': 'تغيير كلمة المرور',
      'recentActivity': 'النشاط الأخير',
      'taskSchedule': 'جدول المهام',
      'viewAll': 'عرض الكل',
      'upcomingTasks': 'المهام القادمة',
      'seeAll': 'رؤية الكل',
      'planAndPricing': 'الخطط والأسعار',
      'recommendationsForYou': 'التوصيات لك',
      'visionERP': 'فيجن ERP',
      'integratingEveryDepartment': 'دمج كل قسم لتدفق بيانات سلس ووضوح',
      'contractDuration': 'مدة العقد',
      'leaveBalance': 'رصيد الإجازات',
      'theAudience': 'الجمهور',
      'tasks': 'المهام',
      'visualAuditoryCheck': 'فحص بصري وسمعي',
      'visualAuditoryDesc': 'الاستماع للتشغيل. التحقق من أضواء الخطأ.',
      'feelTheAuthor': 'الشعور بالمؤلف',
      'feelTheAuthorDesc': 'تأكيد تدفق الهواء من فتحات إمداد الهواء النقي.',
      'checkControlSetting': 'فحص إعدادات التحكم',
      'checkControlDesc': 'تأكد من أن الوحدة في وضع "تلقائي" أو الوضع المطلوب.',
      'checkExteriorVents': 'فحص فتحات التهوية الخارجية',
      'checkExteriorDesc': 'تأكد من أن مداخل ومخارج الهواء الخارجية غير مسدودة.',
      'done': 'مكتمل',
      'inProgress': 'قيد التنفيذ',
      'toDo': 'للقيام',
    },
  };

  var PlanPricing;

  var RecommendationsForYou;

  String? _getText(String key) {
    return _localizedValues[locale.languageCode]?[key];
  }

  // Getters for all translated texts
  String get welcome => _getText('welcome') ?? 'Welcome';
  String get toVisionERP => _getText('toVisionERP') ?? 'To Vision ERP';
  String get moveTowardsBetterFuture => _getText('moveTowardsBetterFuture') ?? 'Move towards a better future';
  String get home => _getText('home') ?? 'Home';
  String get demo => _getText('demo') ?? 'Demo';
  String get dashboard => _getText('dashboard') ?? 'Dashboard';
  String get profile => _getText('profile') ?? 'Profile';
  String get menu => _getText('menu') ?? 'Menu';
  String get loginIntoAccount => _getText('loginIntoAccount') ?? 'Login into your\nAccount';
  String get enterCredentials => _getText('enterCredentials') ?? 'Enter your user name and password to log in';
  String get userName => _getText('userName') ?? 'User Name';
  String get password => _getText('password') ?? 'Password';
  String get rememberMe => _getText('rememberMe') ?? 'Remember me';
  String get forgotPassword => _getText('forgotPassword') ?? 'Forgot Password?';
  String get login => _getText('login') ?? 'Login';
  String get dontHaveAccount => _getText('dontHaveAccount') ?? "Don't have an account? ";
  String get signUp => _getText('signUp') ?? 'Sign Up';
  String get myAccount => _getText('myAccount') ?? 'My Account';
  String get notification => _getText('notification') ?? 'Notification';
  String get mySubscription => _getText('mySubscription') ?? 'My Subscription';
  String get language => _getText('language') ?? 'Language';
  String get resetIntro => _getText('resetIntro') ?? 'Reset Intro';
  String get aboutUs => _getText('aboutUs') ?? 'About Us';
  String get logout => _getText('logout') ?? 'Logout';
  String get english => _getText('english') ?? 'English';
  String get arabic => _getText('arabic') ?? 'Arabic';
  String get darkMode => _getText('darkMode') ?? 'Dark Mode';
  String get lightMode => _getText('lightMode') ?? 'Light Mode';
  String get main => _getText('main') ?? 'MAIN';
  String get settings => _getText('settings') ?? 'SETTINGS';
  String get moreInfo => _getText('moreInfo') ?? 'MORE INFO';
  String get organization => _getText('organization') ?? 'Organization';
  String get accountDetails => _getText('accountDetails') ?? 'Account details';
  String get documents => _getText('documents') ?? 'Documents';
  String get turnYourLocation => _getText('turnYourLocation') ?? 'Turn your location';
  String get locationSubtitle => _getText('locationSubtitle') ?? 'This will expose face of target';
  String get bankDetail => _getText('bankDetail') ?? 'BANK DETAIL';
  String get bankAccount => _getText('bankAccount') ?? 'Bank Account';
  String get activitiesNotifications => _getText('activitiesNotifications') ?? 'Activities notifications';
  String get activitiesSubtitle => _getText('activitiesSubtitle') ?? 'Payment facades, links and other activities';
  String get emailNotification => _getText('emailNotification') ?? 'Email notification';
  String get security => _getText('security') ?? 'SECURITY';
  String get signInWithTouchID => _getText('signInWithTouchID') ?? 'Sign in with touch ID';
  String get changePassword => _getText('changePassword') ?? 'Change password';
  String get recentActivity => _getText('recentActivity') ?? 'Recent Activity';
  String get taskSchedule => _getText('taskSchedule') ?? 'Task Schedule';
  String get viewAll => _getText('viewAll') ?? 'View All';
  String get upcomingTasks => _getText('upcomingTasks') ?? 'Upcoming Tasks';
  String get seeAll => _getText('seeAll') ?? 'See All';
  String get planAndPricing => _getText('planAndPricing') ?? 'Plan and Pricing';
  String get recommendationsForYou => _getText('recommendationsForYou') ?? 'Recommendations for you';
  String get visionERP => _getText('visionERP') ?? 'Vision ERP';
  String get integratingEveryDepartment => _getText('integratingEveryDepartment') ?? 'Integrating every department for seamless data flow and clarity';
  String get contractDuration => _getText('contractDuration') ?? 'Contract duration';
  String get leaveBalance => _getText('leaveBalance') ?? 'Leave balance';
  String get theAudience => _getText('theAudience') ?? 'The Audience';
  String get tasks => _getText('tasks') ?? 'Tasks';
  String get visualAuditoryCheck => _getText('visualAuditoryCheck') ?? 'Visual & Auditory Check';
  String get visualAuditoryDesc => _getText('visualAuditoryDesc') ?? 'Listen for operation. Check for error lights.';
  String get feelTheAuthor => _getText('feelTheAuthor') ?? 'Feel the Author';
  String get feelTheAuthorDesc => _getText('feelTheAuthorDesc') ?? 'Confirm airflow from fresh air supply vents.';
  String get checkControlSetting => _getText('checkControlSetting') ?? 'Check the Control Setting';
  String get checkControlDesc => _getText('checkControlDesc') ?? 'Ensure unit is on in "Auto" or desired mode.';
  String get checkExteriorVents => _getText('checkExteriorVents') ?? 'Check Exterior Vents';
  String get checkExteriorDesc => _getText('checkExteriorDesc') ?? 'Ensure outdoor intake/exhaust hoods are not blocked.';
  String get done => _getText('done') ?? 'Done';
  String get inProgress => _getText('inProgress') ?? 'In Progress';
  String get toDo => _getText('toDo') ?? 'To Do';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}